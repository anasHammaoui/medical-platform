package com.example.medicalplatform.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "signes_vitaux")
public class SignesVitaux {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @CreationTimestamp
    private LocalDateTime dateSaisie;
    private String tension;
    private int frequenceCardiaque;
    private double temperature;
    private int frequenceRespiratoire;
    private double poids;
    private double taille;
    @OneToOne(mappedBy = "signesVitaux", cascade = CascadeType.ALL)
    private DossierMedical dossierMedical;
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public LocalDateTime getDateSaisie() {
        return dateSaisie;
    }

    public void setDateSaisie(LocalDateTime dateSaisie) {
        this.dateSaisie = dateSaisie;
    }

    public String getTension() {
        return tension;
    }

    public void setTension(String tension) {
        this.tension = tension;
    }

    public int getFrequenceCardiaque() {
        return frequenceCardiaque;
    }

    public void setFrequenceCardiaque(int frequenceCardiaque) {
        this.frequenceCardiaque = frequenceCardiaque;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public int getFrequenceRespiratoire() {
        return frequenceRespiratoire;
    }

    public void setFrequenceRespiratoire(int frequenceRespiratoire) {
        this.frequenceRespiratoire = frequenceRespiratoire;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getTaille() {
        return taille;
    }

    public void setTaille(double taille) {
        this.taille = taille;
    }
    public DossierMedical getDossierMedical() {
        return dossierMedical;
    }
    public void setDossierMedical(DossierMedical dossierMedical) {
        this.dossierMedical = dossierMedical;
    }
}
