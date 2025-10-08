package com.example.medicalplatform.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("GENERALISTE")
public class Generaliste extends Utilisateur{
}
