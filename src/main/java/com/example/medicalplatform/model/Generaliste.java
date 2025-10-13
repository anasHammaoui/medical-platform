package com.example.medicalplatform.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
@DiscriminatorValue("GENERALISTE")
public class Generaliste extends Utilisateur{
    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL)
    List<Consultation> consultations;

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
