package com.example.medicalplatform.service.impl;

import com.example.medicalplatform.dao.impl.AuthDao;
import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.model.Admin;
import com.example.medicalplatform.model.Generaliste;
import com.example.medicalplatform.model.Infermier;
import com.example.medicalplatform.model.Specialiste;
import com.example.medicalplatform.model.Utilisateur;
import com.example.medicalplatform.service.AuthServiceInterface;
import org.hibernate.HibernateException;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Map;

public class AuthService implements AuthServiceInterface {
    private final AuthDao authDao;

    public AuthService() {
        authDao = new AuthDao();
    }

    @Override
    public Utilisateur register(String nom, String prenom, String email, String password,
                                String role, Map<String, Object> additionalData) throws HibernateException {

        if (authDao.findUserByEmail(email) != null) {
            throw new HibernateException("An account with this email already exists.");
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Utilisateur user = null;

        try {
            switch (role.toUpperCase()) {
                case "ADMIN":
                    user = new Admin(nom, prenom, email, hashedPassword);
                    break;

                case "GENERALISTE":
                    String telephoneGen = additionalData != null ?
                            (String) additionalData.get("telephone") : null;
                    user = new Generaliste(nom, prenom, email, hashedPassword, telephoneGen);
                    break;

                case "SPECIALISTE":
                    if (additionalData == null || !additionalData.containsKey("specialite")) {
                        throw new HibernateException("Specialty is required for a specialist");
                    }

                    String telephoneSpec = (String) additionalData.get("telephone");
                    SpecialiteEnum specialite = (SpecialiteEnum) additionalData.get("specialite");
                    Double tarif = additionalData.containsKey("tarif") ?
                            ((Number) additionalData.get("tarif")).doubleValue() : 150.0;
                    Integer dureeConsultation = additionalData.containsKey("dureeConsultation") ?
                            ((Number) additionalData.get("dureeConsultation")).intValue() : 30;

                    user = new Specialiste(nom, prenom, email, hashedPassword,
                            telephoneSpec, specialite, tarif, dureeConsultation);
                    break;

                case "INFERMIER":
                    user = new Infermier(nom, prenom, email, hashedPassword);
                    break;

                default:
                    throw new HibernateException("Invalid role: " + role);
            }

            // Save user to database
            return authDao.save(user);

        } catch (HibernateException e) {
            throw new HibernateException("Error during registration: " + e.getMessage());
        }
    }

    @Override
    public Utilisateur login(String email, String password) {
        try {
            Utilisateur user = authDao.findUserByEmail(email);

            if (user == null) {
                return null;
            }

            if (BCrypt.checkpw(password, user.getMotDePasse())) {
                return user;
            }

            return null;
        } catch (Exception e) {
            throw new HibernateException("Error during login: " + e.getMessage());
        }
    }
}
