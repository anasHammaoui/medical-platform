package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.Consultation;
import org.hibernate.HibernateException;

import java.util.List;

public interface ConsultationInterface {
    Consultation createConsultation(Consultation consultation) throws HibernateException;
    Consultation updateConsultation(Consultation consultation) throws HibernateException;
    Consultation getConsultation(long id) throws HibernateException;
    List<Consultation> getConsultationsByGeneraliste(long generalisteId) throws HibernateException;
}
