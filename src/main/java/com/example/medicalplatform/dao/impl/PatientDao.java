package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.PatientInterface;
import com.example.medicalplatform.model.Patient;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import org.hibernate.HibernateException;

import java.util.List;

public class PatientDao implements PatientInterface {
    private final EntityManagerFactory emf;
    public PatientDao() {
        this.emf = EmfUtil.getEntityManagerFactory();
    }
    @Override
    public Patient addPatient(Patient patient) throws HibernateException {
        EntityManager em = emf.createEntityManager();
                try{
                    em.getTransaction().begin();
                    em.persist(patient);
                    em.getTransaction().commit();
                    return patient;
                }catch (HibernateException e){
                    if (em.getTransaction().isActive()){
                        em.getTransaction().rollback();
                    }
                    throw new HibernateException("Patient dao exception: " + e.getMessage());
                } finally {
                    em.close();
                }

    }

    @Override
    public Patient getPatient(long id) throws NoResultException {
        EntityManager em = emf.createEntityManager();
            Patient patient = em.find(Patient.class,id);
            if (patient == null){
                throw new NoResultException("No patient found with id: " + id);
            }
            return patient;
    }

    @Override
    public List<Patient> getPatients() throws NoResultException {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            // Use JOIN FETCH to load all relations in one query to avoid LazyInitializationException
            String jpql = "SELECT DISTINCT p FROM Patient p " +
                         "LEFT JOIN FETCH p.dossierMedical dm " +
                         "LEFT JOIN FETCH dm.consultations " +
                         "LEFT JOIN FETCH dm.signesVitaux";
            List<Patient> patients = em.createQuery(jpql, Patient.class).getResultList();
            return patients; // Returns empty list if no patients found - this is normal
        } catch (Exception e) {
            System.err.println("Error in PatientDao.getPatients: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Patient Dao exception: " + e.getMessage(), e);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public Patient updatePatient(Patient patient) throws HibernateException {
        try (EntityManager em = emf.createEntityManager()) {
        em.getTransaction().begin();
        em.merge(patient);
        em.getTransaction().commit();
        return patient;
        } catch (HibernateException e) {
            throw new HibernateException("Patient dao exception: " + e.getMessage());
        }
    }
}
