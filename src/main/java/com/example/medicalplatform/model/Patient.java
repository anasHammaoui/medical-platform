package com.example.medicalplatform.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "patients")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String nom;
    private String prenom;
    private String email;
    private String telephone;
    private String adresse;
    private LocalDateTime dateNaissance;
    private String numeroSecuriteSociale;
    private String mutuelle;
    private boolean fileAttente;
    @OneToOne
    @JoinColumn(name = "dossier_id", nullable = false)
    private DossierMedical dossierMedical;
}
