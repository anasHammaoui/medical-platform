package com.example.medicalplatform.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("INFERMIER")
public class Infermier extends Utilisateur{

}
