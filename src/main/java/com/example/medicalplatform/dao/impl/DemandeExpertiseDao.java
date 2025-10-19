package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.DemandeExpertiseInterface;
import com.example.medicalplatform.model.DemandeExpertise;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import org.hibernate.HibernateException;

public class DemandeExpertiseDao implements DemandeExpertiseInterface {
    private final EntityManagerFactory emf;

    public DemandeExpertiseDao() {
        this.emf = EmfUtil.getEntityManagerFactory();
    }

    @Override
    public DemandeExpertise createDemande(DemandeExpertise demande) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(demande);
            em.getTransaction().commit();
            return demande;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new HibernateException("Error creating demande: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public DemandeExpertise updateDemande(DemandeExpertise demande) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            DemandeExpertise updated = em.merge(demande);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new HibernateException("Error updating demande: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public DemandeExpertise getDemande(long id) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            DemandeExpertise demande = em.find(DemandeExpertise.class, id);
            if (demande == null) {
                throw new HibernateException("Demande not found with id: " + id);
            }
            return demande;
        } catch (Exception e) {
            throw new HibernateException("Error getting demande: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
