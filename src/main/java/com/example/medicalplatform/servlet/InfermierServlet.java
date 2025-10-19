package com.example.medicalplatform.servlet;

import com.example.medicalplatform.model.DossierMedical;
import com.example.medicalplatform.model.Infermier;
import com.example.medicalplatform.model.Patient;
import com.example.medicalplatform.model.SignesVitaux;
import com.example.medicalplatform.service.impl.PatientService;
import jakarta.persistence.NoResultException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.HibernateException;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard/infermier")
public class InfermierServlet extends HttpServlet {
    private PatientService patientService;
    public void init(){
        patientService = new PatientService();
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            if (!(session.getAttribute("user") instanceof Infermier)) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        List<Patient> patients = new ArrayList<>();
        try {
            patients = patientService.getPatients();
        } catch (Exception e){
            System.err.println("Error loading patients: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.setAttribute("patients", patients);
        
        request.getRequestDispatcher("/dashboard/infermier/login.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // patient infos
       String nom =  request.getParameter("nom");
       String prenom = request.getParameter("prenom");
        LocalDateTime dateNaissance = LocalDate.parse(request.getParameter("dateNaissance")).atStartOfDay();
        String numeroSecuriteSociale = request.getParameter("numeroSecuriteSociale");
       String adresse = request.getParameter("adresse");
       String telephone = request.getParameter("telephone");
       String mutuelle = request.getParameter("mutuelle");
       // dossier medical infos
        String antecedents = request.getParameter("antecedents");
         String allergies = request.getParameter("allergies");
         String traitementsEnCours = request.getParameter("traitementsEnCours");
     // signes vitaux
        String tension = request.getParameter("tension");
        int frequenceCardiaque =  Integer.parseInt(request.getParameter("frequenceCardiaque"));
        double temperature = Double.parseDouble(request.getParameter("temperature"));
        int frequenceRespiratoire = Integer.parseInt(request.getParameter("frequenceRespiratoire"));
        double poids = Double.parseDouble(request.getParameter("poids"));
        double taille = Double.parseDouble(request.getParameter("taille"));

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setDateNaissance(dateNaissance);
        patient.setNumeroSecuriteSociale(numeroSecuriteSociale);
        patient.setAdresse(adresse);
        patient.setTelephone(telephone);
        patient.setMutuelle(mutuelle);
        patient.setFileAttente(true);

        DossierMedical dossierMedical = new DossierMedical();
        dossierMedical.setAnticedents(antecedents);
        dossierMedical.setAllergies(allergies);
        dossierMedical.setTraitementEnCours(traitementsEnCours);

        SignesVitaux signesVitaux = new SignesVitaux();
        signesVitaux.setTension(tension);
        signesVitaux.setFrequenceCardiaque(frequenceCardiaque);
        signesVitaux.setTemperature(temperature);
        signesVitaux.setFrequenceRespiratoire(frequenceRespiratoire);
        signesVitaux.setPoids(poids);
        signesVitaux.setTaille(taille);

        try {
            patientService.addPatient(patient, dossierMedical, signesVitaux);
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Patient added successfully");
            response.sendRedirect(request.getContextPath() + "/dashboard/infermier");
        } catch (HibernateException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/dashboard/infermier/login.jsp").forward(request, response);
        }

    }
}
