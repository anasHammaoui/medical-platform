package com.example.medicalplatform.model;

import com.example.medicalplatform.enums.DemandePrioritee;
import com.example.medicalplatform.enums.DemandeStatus;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "demandes_expertises")
public class DemandeExpertise {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String question;
    @Enumerated(EnumType.STRING)
    private DemandeStatus status;
    @Enumerated(EnumType.STRING)
    private DemandePrioritee prioritee;
    @CreationTimestamp
    private LocalDateTime dateDemande;
    private String avisMedecin;
    @OneToOne(mappedBy = "demandeExpertise")
    private Creneau creneau;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public DemandeStatus getStatus() {
        return status;
    }

    public void setStatus(DemandeStatus status) {
        this.status = status;
    }

    public DemandePrioritee getPrioritee() {
        return prioritee;
    }

    public void setPrioritee(DemandePrioritee prioritee) {
        this.prioritee = prioritee;
    }

    public LocalDateTime getDateDemande() {
        return dateDemande;
    }

    public void setDateDemande(LocalDateTime dateDemande) {
        this.dateDemande = dateDemande;
    }

    public String getAvisMedecin() {
        return avisMedecin;
    }

    public void setAvisMedecin(String avisMedecin) {
        this.avisMedecin = avisMedecin;
    }

    public Creneau getCreneau() {
        return creneau;
    }

    public void setCreneau(Creneau creneau) {
        this.creneau = creneau;
    }
}
