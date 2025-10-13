package com.example.medicalplatform.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("INFERMIER")
public class Infermier extends Utilisateur{
    protected Infermier(){
        super();
    }
    public Infermier(String nom, String prenom, String email, String password) {
        super(nom, prenom, email, password);
    }
}
