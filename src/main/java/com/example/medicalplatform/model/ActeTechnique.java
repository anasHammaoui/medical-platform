package com.example.medicalplatform.model;

import com.example.medicalplatform.enums.ActeTechniqueType;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "acte_technique")
public class ActeTechnique {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Enumerated(EnumType.STRING)
    private ActeTechniqueType type;
    private LocalDateTime date;
    private String resultat;
    @ManyToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ActeTechniqueType getType() {
        return type;
    }

    public void setType(ActeTechniqueType type) {
        this.type = type;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getResultat() {
        return resultat;
    }

    public void setResultat(String resultat) {
        this.resultat = resultat;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
}
