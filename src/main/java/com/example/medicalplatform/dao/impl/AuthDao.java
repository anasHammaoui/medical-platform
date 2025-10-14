package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.AuthInterface;
import com.example.medicalplatform.model.Admin;
import com.example.medicalplatform.model.Utilisateur;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.*;
import org.hibernate.HibernateException;

public class AuthDao implements AuthInterface {

    public final EntityManagerFactory emf;
    
    public AuthDao(){
        emf = EmfUtil.getEntityManagerFactory();
    }

    public Utilisateur save(Utilisateur user) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            return user;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new HibernateException("AuthDao Exception: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    public Utilisateur findUserByEmail(String email){
        try (EntityManager em = emf.createEntityManager()) {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.email = :email", 
                Utilisateur.class
            );
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


}
