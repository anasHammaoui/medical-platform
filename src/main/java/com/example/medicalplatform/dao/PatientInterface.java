package com.example.medicalplatform.dao;

import com.example.medicalplatform.model.Patient;
import jakarta.persistence.NoResultException;
import org.hibernate.HibernateException;

import java.util.List;

public interface PatientInterface {
    public Patient addPatient(Patient patient) throws HibernateException;
    public Patient getPatient(long id) throws NoResultException;
    public List<Patient> getPatients() throws NoResultException;
    public Patient updatePatient(Patient patient) throws HibernateException;
}
