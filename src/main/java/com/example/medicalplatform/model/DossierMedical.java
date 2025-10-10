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

}
