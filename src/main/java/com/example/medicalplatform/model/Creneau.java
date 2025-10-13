package com.example.medicalplatform.model;

import com.example.medicalplatform.enums.CreneauEnum;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "creneaux")
public class Creneau {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "medecin_id", nullable = false)
    private Specialiste specialiste;
    private LocalDateTime dateHeureDebut;
    private LocalDateTime dateHeureFin;
    private CreneauEnum status;
    @OneToOne(mappedBy = "creneau")
    private DemandeExpertise demandeExpertise;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Specialiste getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(Specialiste specialiste) {
        this.specialiste = specialiste;
    }

    public LocalDateTime getDateHeureDebut() {
        return dateHeureDebut;
    }

    public void setDateHeureDebut(LocalDateTime dateHeureDebut) {
        this.dateHeureDebut = dateHeureDebut;
    }

    public LocalDateTime getDateHeureFin() {
        return dateHeureFin;
    }

    public void setDateHeureFin(LocalDateTime dateHeureFin) {
        this.dateHeureFin = dateHeureFin;
    }

    public CreneauEnum getStatus() {
        return status;
    }

    public void setStatus(CreneauEnum status) {
        this.status = status;
    }

    public DemandeExpertise getDemandeExpertise() {
        return demandeExpertise;
    }

    public void setDemandeExpertise(DemandeExpertise demandeExpertise) {
        this.demandeExpertise = demandeExpertise;
    }
}
