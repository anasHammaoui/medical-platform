package com.example.medicalplatform.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("ADMIN")
public class Admin extends Utilisateur{
    protected Admin() {}
    public Admin(String nom, String prenom, String email, String password) {
        super(nom, prenom, email, password);
    }
}
