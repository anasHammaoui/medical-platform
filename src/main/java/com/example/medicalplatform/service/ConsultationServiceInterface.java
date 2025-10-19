package com.example.medicalplatform.service;

import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.model.DemandeExpertise;
import com.example.medicalplatform.model.Specialiste;
import org.hibernate.HibernateException;

import java.util.List;

public interface ConsultationServiceInterface {
    Consultation createConsultation(Consultation consultation) throws HibernateException;
    Consultation updateConsultation(Consultation consultation) throws HibernateException;
    Consultation getConsultation(long id) throws HibernateException;
    List<Consultation> getConsultationsByGeneraliste(long generalisteId) throws HibernateException;
    
    // Tele-expertise methods
    List<Specialiste> getSpecialistesBySpecialite(SpecialiteEnum specialite) throws HibernateException;
    DemandeExpertise createDemandeExpertise(Consultation consultation, DemandeExpertise demande) throws HibernateException;
}
