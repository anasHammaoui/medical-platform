package com.example.medicalplatform.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EmfUtil{
    public static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("medical-platform");

    public static EntityManagerFactory getEntityManagerFactory(){
        return emf;
    }
    public static EntityManager getEntityManager(){
        return emf.createEntityManager();
    }
}
