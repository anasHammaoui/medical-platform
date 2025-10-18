package com.example.medicalplatform.service.impl;

import com.example.medicalplatform.dao.impl.PatientDao;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.model.DossierMedical;
import com.example.medicalplatform.model.Patient;
import com.example.medicalplatform.model.SignesVitaux;
import com.example.medicalplatform.service.PatientServiceInterface;
import jakarta.persistence.NoResultException;
import org.hibernate.HibernateException;

import java.util.ArrayList;
import java.util.List;

public class PatientService implements PatientServiceInterface {
    private final PatientDao patientDao;
    public PatientService() {
        this.patientDao = new PatientDao();
    }

    @Override
    public Patient addPatient(Patient patient, DossierMedical dossierMedical, SignesVitaux signesVitaux) throws HibernateException {
        patient.setDossierMedical(dossierMedical);
        dossierMedical.setPatient(patient);
        dossierMedical.setSignesVitaux(signesVitaux);
        signesVitaux.setDossierMedical(dossierMedical);
        
        dossierMedical.setConsultations(new ArrayList<>());
        (new Consultation()).setDossierMedical(dossierMedical);
        try {
            return patientDao.addPatient(patient);
        } catch (HibernateException e) {
            throw new HibernateException("Patient service exception: " + e.getMessage());
        }
    }

    @Override
    public Patient getPatient(long id) throws NoResultException {
        try {
            return patientDao.getPatient(id);
        } catch (NoResultException e) {
            throw new NoResultException("Patient service exception: " + e.getMessage());
        }
    }

    @Override
    public List<Patient> getPatients() {
        try {
            return patientDao.getPatients();
        } catch (Exception e) {
            // Log the error but return empty list instead of throwing exception
            System.err.println("Error getting patients: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    @Override
    public Patient updatePatient(Patient patient, DossierMedical dossierMedical, SignesVitaux signesVitaux) throws HibernateException {
        try {
            patient.setDossierMedical(dossierMedical);
            dossierMedical.setPatient(patient);
            dossierMedical.setSignesVitaux(signesVitaux);
            return patientDao.updatePatient(patient);
        } catch (HibernateException e) {
            throw new HibernateException("Patient service exception: " + e.getMessage());
        }
    }
}
