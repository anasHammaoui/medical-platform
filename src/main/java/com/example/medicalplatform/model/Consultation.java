package com.example.medicalplatform.model;

import com.example.medicalplatform.enums.StatutConsultation;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @ManyToOne
    @JoinColumn(name = "generaliste_id", nullable = false)
    private Generaliste generaliste;
    private LocalDateTime dateConsultation;
    private String motif;
    @Column(length = 500)
    private String observations;
    @Enumerated(EnumType.STRING)
    private StatutConsultation status;
    private String diganostic;
    private String traitement;
    private Double cout;
    @OneToMany(mappedBy = "consultations", cascade = CascadeType.ALL)
    private  List<ActeTechnique> acteTechniques;
    @ManyToOne
    @JoinColumn(name = "dossier_id", nullable = false)
    private DossierMedical dossierMedical;

}
