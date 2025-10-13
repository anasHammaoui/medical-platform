package com.example.medicalplatform.model;

import com.example.medicalplatform.enums.SpecialiteEnum;
import jakarta.persistence.*;

import java.util.List;

@Entity
@DiscriminatorValue("SPECIALISTE")
public class Specialiste extends Utilisateur{
    @Enumerated(EnumType.STRING)
    private SpecialiteEnum specialite;
    @Column(nullable = false)
    private double tarif;
    @Column(nullable = false)
    private int duree_consultation;
    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL)
    private List<Creneau> creneaux;

    public SpecialiteEnum getSpecialite() {
        return specialite;
    }

    public void setSpecialite(SpecialiteEnum specialite) {
        this.specialite = specialite;
    }

    public double getTarif() {
        return tarif;
    }

    public void setTarif(double tarif) {
        this.tarif = tarif;
    }

    public int getDuree_consultation() {
        return duree_consultation;
    }

    public void setDuree_consultation(int duree_consultation) {
        this.duree_consultation = duree_consultation;
    }

    public List<Creneau> getCreneaux() {
        return creneaux;
    }

    public void setCreneaux(List<Creneau> creneaux) {
        this.creneaux = creneaux;
    }
}
