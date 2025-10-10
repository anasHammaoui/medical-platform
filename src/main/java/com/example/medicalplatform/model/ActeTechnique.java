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
}
