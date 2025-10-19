package com.example.medicalplatform.dao;

import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.model.Specialiste;
import org.hibernate.HibernateException;

import java.util.List;

public interface SpecialisteInterface {
    List<Specialiste> getSpecialistesBySpecialite(SpecialiteEnum specialite) throws HibernateException;
    Specialiste getSpecialiste(long id) throws HibernateException;
}
