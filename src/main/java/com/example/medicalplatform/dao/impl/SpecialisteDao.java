package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.SpecialisteInterface;
import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.model.Specialiste;
import com.example.medicalplatform.utils.EmfUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import org.hibernate.HibernateException;

import java.util.List;

public class SpecialisteDao implements SpecialisteInterface {
    private final EntityManagerFactory emf;

    public SpecialisteDao() {
        this.emf = EmfUtil.getEntityManagerFactory();
    }

    @Override
    public List<Specialiste> getSpecialistesBySpecialite(SpecialiteEnum specialite) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            // Get specialists and use JPQL ORDER BY for tariff sorting (cheapest first)
            String jpql = "SELECT s FROM Specialiste s " +
                         "LEFT JOIN FETCH s.creneaux " +
                         "WHERE s.specialite = :specialite " +
                         "ORDER BY s.tarif ASC";
            return em.createQuery(jpql, Specialiste.class)
                    .setParameter("specialite", specialite)
                    .getResultList();
        } catch (Exception e) {
            throw new HibernateException("Error getting specialistes: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Specialiste getSpecialiste(long id) throws HibernateException {
        EntityManager em = emf.createEntityManager();
        try {
            Specialiste specialiste = em.find(Specialiste.class, id);
            if (specialiste == null) {
                throw new HibernateException("Specialiste not found with id: " + id);
            }
            // Force load creneaux
            if (specialiste.getCreneaux() != null) {
                specialiste.getCreneaux().size();
            }
            return specialiste;
        } catch (Exception e) {
            throw new HibernateException("Error getting specialiste: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }
}
