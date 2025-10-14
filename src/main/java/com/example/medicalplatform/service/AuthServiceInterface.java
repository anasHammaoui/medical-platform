package com.example.medicalplatform.service;

import com.example.medicalplatform.model.Utilisateur;
import org.hibernate.HibernateException;

import java.util.Map;

public interface AuthServiceInterface {
    Utilisateur register(String nom, String prenom, String email, String password, String role, Map<String, Object> additionalData) throws HibernateException;
    Utilisateur login(String email, String password);
}
