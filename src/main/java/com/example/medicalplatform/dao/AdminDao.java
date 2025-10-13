package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.Admin;
import com.example.medicalplatform.model.Utilisateur;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;


public class AdminDao {
    private final EntityManagerFactory emf;

    public AdminDao() {
        this.emf = EmfUtil.getEntityManagerFactory();
    }

    public void saveAdmin(Admin admin){
        EntityManager em = emf.createEntityManager();
        try{
            em.getTransaction().begin();
            em.persist(admin);
            em.getTransaction().commit();
            System.out.println("admin saved successfully: " + admin.getEmail());
        } catch (Exception e){
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Error saving admin: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to save admin", e);
        } finally {
            em.close();
        }
    }
}
