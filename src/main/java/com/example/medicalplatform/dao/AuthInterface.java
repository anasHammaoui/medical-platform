package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.Utilisateur;
import org.hibernate.HibernateException;

public interface AuthInterface {
    public Utilisateur save(Utilisateur admin) throws HibernateException;
    public Utilisateur findUserByEmail(String email);
}
