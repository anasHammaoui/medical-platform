package com.example.medicalplatform.service.impl;

import com.example.medicalplatform.dao.impl.ConsultationDao;
import com.example.medicalplatform.dao.impl.DemandeExpertiseDao;
import com.example.medicalplatform.dao.impl.SpecialisteDao;
import com.example.medicalplatform.enums.DemandeStatus;
import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.enums.StatutConsultation;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.model.DemandeExpertise;
import com.example.medicalplatform.model.Specialiste;
import com.example.medicalplatform.service.ConsultationServiceInterface;
import org.hibernate.HibernateException;

import java.util.List;

public class ConsultationService implements ConsultationServiceInterface {
    private final ConsultationDao consultationDao;
    private final DemandeExpertiseDao demandeExpertiseDao;
    private final SpecialisteDao specialisteDao;

    public ConsultationService() {
        this.consultationDao = new ConsultationDao();
        this.demandeExpertiseDao = new DemandeExpertiseDao();
        this.specialisteDao = new SpecialisteDao();
    }

    @Override
    public Consultation createConsultation(Consultation consultation) throws HibernateException {
        try {
            return consultationDao.createConsultation(consultation);
        } catch (HibernateException e) {
            throw new HibernateException("Service error creating consultation: " + e.getMessage(), e);
        }
    }

    @Override
    public Consultation updateConsultation(Consultation consultation) throws HibernateException {
        try {
            return consultationDao.updateConsultation(consultation);
        } catch (HibernateException e) {
            throw new HibernateException("Service error updating consultation: " + e.getMessage(), e);
        }
    }

    @Override
    public Consultation getConsultation(long id) throws HibernateException {
        try {
            return consultationDao.getConsultation(id);
        } catch (HibernateException e) {
            throw new HibernateException("Service error getting consultation: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> getConsultationsByGeneraliste(long generalisteId) throws HibernateException {
        try {
            return consultationDao.getConsultationsByGeneraliste(generalisteId);
        } catch (Exception e) {
            // Log error but return empty list to prevent dashboard crash
            System.err.println("Service error getting consultations: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public List<Specialiste> getSpecialistesBySpecialite(SpecialiteEnum specialite) throws HibernateException {
        try {
            return specialisteDao.getSpecialistesBySpecialite(specialite);
        } catch (HibernateException e) {
            throw new HibernateException("Service error getting specialistes: " + e.getMessage(), e);
        }
    }

    @Override
    public DemandeExpertise createDemandeExpertise(Consultation consultation, DemandeExpertise demande) throws HibernateException {
        try {
            // Set the bidirectional relationship
            demande.setConsultation(consultation);
            demande.setStatus(DemandeStatus.EN_ATTENTE);
            consultation.setDemandeExpertise(demande);
            consultation.setStatus(StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE);
            
            // Update consultation with demande
            consultationDao.updateConsultation(consultation);
            return demande;
        } catch (HibernateException e) {
            throw new HibernateException("Service error creating demande expertise: " + e.getMessage(), e);
        }
    }
}
