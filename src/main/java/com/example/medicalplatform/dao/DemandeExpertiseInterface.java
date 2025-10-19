package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.DemandeExpertise;
import org.hibernate.HibernateException;

public interface DemandeExpertiseInterface {
    DemandeExpertise createDemande(DemandeExpertise demande) throws HibernateException;
    DemandeExpertise updateDemande(DemandeExpertise demande) throws HibernateException;
    DemandeExpertise getDemande(long id) throws HibernateException;
}
