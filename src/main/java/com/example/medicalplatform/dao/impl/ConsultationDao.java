package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.ConsultationInterface;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import org.hibernate.HibernateException;

import java.util.List;

public class ConsultationDao implements ConsultationInterface {
    private final EntityManagerFactory emf;

    public ConsultationDao() {
        this.emf = EmfUtil.getEntityManagerFactory();
    }

    @Override
    public Consultation createConsultation(Consultation consultation) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            if (consultation.getGeneraliste() != null && consultation.getGeneraliste().getId() > 0) {
                consultation.setGeneraliste(em.merge(consultation.getGeneraliste()));
            }
            
            if (consultation.getDossierMedical() != null && consultation.getDossierMedical().getId() > 0) {
                consultation.setDossierMedical(em.merge(consultation.getDossierMedical()));
            }
            
            em.persist(consultation);
            em.getTransaction().commit();
            
            return consultation;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new HibernateException("Error creating consultation: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Consultation updateConsultation(Consultation consultation) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Consultation updated = em.merge(consultation);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new HibernateException("Error updating consultation: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Consultation getConsultation(long id) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT c FROM Consultation c " +
                         "LEFT JOIN FETCH c.generaliste g " +
                         "LEFT JOIN FETCH c.dossierMedical dm " +
                         "LEFT JOIN FETCH dm.patient p " +
                         "LEFT JOIN FETCH dm.signesVitaux sv " +
                         "WHERE c.id = :id";
            return em.createQuery(jpql, Consultation.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (Exception e) {
            System.err.println("Error getting consultation: " + e.getMessage());
            e.printStackTrace();
            throw new HibernateException("Error getting consultation: " + e.getMessage(), e);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public List<Consultation> getConsultationsByGeneraliste(long generalisteId) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT c FROM Consultation c " +
                         "LEFT JOIN FETCH c.dossierMedical dm " +
                         "LEFT JOIN FETCH dm.patient " +
                         "WHERE c.generaliste.id = :generalisteId " +
                         "ORDER BY c.dateConsultation DESC";
            return em.createQuery(jpql, Consultation.class)
                    .setParameter("generalisteId", generalisteId)
                    .getResultList();
        } catch (Exception e) {
            throw new HibernateException("Error getting consultations: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
