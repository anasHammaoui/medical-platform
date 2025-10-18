package com.example.medicalplatform.service;

import com.example.medicalplatform.model.DossierMedical;
import com.example.medicalplatform.model.Patient;
import com.example.medicalplatform.model.SignesVitaux;
import jakarta.persistence.NoResultException;
import org.hibernate.HibernateException;

import java.util.List;

public interface PatientServiceInterface {
    public Patient addPatient(Patient patient, DossierMedical dossierMedical, SignesVitaux signesVitaux) throws HibernateException;
    public Patient getPatient(long id) throws NoResultException;
    public List<Patient> getPatients() throws NoResultException;
    public Patient updatePatient(Patient patient, DossierMedical dossierMedical, SignesVitaux signesVitaux) throws HibernateException;
}
