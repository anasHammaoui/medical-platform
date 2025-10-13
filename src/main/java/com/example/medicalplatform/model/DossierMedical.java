package com.example.medicalplatform.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "dossiers_medicaux")
public class DossierMedical {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @OneToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;
    private String anticedents;
    private String allergies;
    private String traitementEnCours;
    @OneToMany(mappedBy = "dossierMedical", cascade = CascadeType.ALL)
    private List<Consultation> consultations;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getAnticedents() {
        return anticedents;
    }

    public void setAnticedents(String anticedents) {
        this.anticedents = anticedents;
    }

    public String getAllergies() {
        return allergies;
    }

    public void setAllergies(String allergies) {
        this.allergies = allergies;
    }

    public String getTraitementEnCours() {
        return traitementEnCours;
    }

    public void setTraitementEnCours(String traitementEnCours) {
        this.traitementEnCours = traitementEnCours;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
