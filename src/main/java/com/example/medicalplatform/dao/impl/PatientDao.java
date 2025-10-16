package com.example.medicalplatform.dao.impl;

import com.example.medicalplatform.dao.PatientInterface;
import com.example.medicalplatform.model.Patient;
import jakarta.persistence.NoResultException;
import org.hibernate.HibernateException;

import java.util.List;

public class PatientDao implements PatientInterface {
    @Override
    public Patient addPatient(Patient patient) throws HibernateException {
        return null;
    }

    @Override
    public Patient getPatient(long id) throws NoResultException {
        return null;
    }

    @Override
    public List<Patient> getPatients() throws NoResultException {
        return List.of();
    }

    @Override
    public Patient updatePatient(Patient patient) throws HibernateException {
        return null;
    }
}
