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
    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private  List<ActeTechnique> acteTechniques;
    @ManyToOne
    @JoinColumn(name = "dossier_id", nullable = false)
    private DossierMedical dossierMedical;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Generaliste getGeneraliste() {
        return generaliste;
    }

    public void setGeneraliste(Generaliste generaliste) {
        this.generaliste = generaliste;
    }

    public LocalDateTime getDateConsultation() {
        return dateConsultation;
    }

    public void setDateConsultation(LocalDateTime dateConsultation) {
        this.dateConsultation = dateConsultation;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public StatutConsultation getStatus() {
        return status;
    }

    public void setStatus(StatutConsultation status) {
        this.status = status;
    }

    public String getDiganostic() {
        return diganostic;
    }

    public void setDiganostic(String diganostic) {
        this.diganostic = diganostic;
    }

    public String getTraitement() {
        return traitement;
    }

    public void setTraitement(String traitement) {
        this.traitement = traitement;
    }

    public Double getCout() {
        return cout;
    }

    public void setCout(Double cout) {
        this.cout = cout;
    }

    public List<ActeTechnique> getActeTechniques() {
        return acteTechniques;
    }

    public void setActeTechniques(List<ActeTechnique> acteTechniques) {
        this.acteTechniques = acteTechniques;
    }

    public DossierMedical getDossierMedical() {
        return dossierMedical;
    }

    public void setDossierMedical(DossierMedical dossierMedical) {
        this.dossierMedical = dossierMedical;
    }

}
