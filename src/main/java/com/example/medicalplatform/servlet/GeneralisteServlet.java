package com.example.medicalplatform.servlet;

import com.example.medicalplatform.enums.StatutConsultation;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.model.Generaliste;
import com.example.medicalplatform.model.Patient;
import com.example.medicalplatform.service.impl.ConsultationService;
import com.example.medicalplatform.service.impl.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard/generaliste")
public class GeneralisteServlet extends HttpServlet {
    private PatientService patientService;
    private ConsultationService consultationService;

    @Override
    public void init() {
        patientService = new PatientService();
        consultationService = new ConsultationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check authentication
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        if (!(session.getAttribute("user") instanceof Generaliste)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Generaliste generaliste = (Generaliste) session.getAttribute("user");
        
        try {
            // Get all patients in waiting queue
            List<Patient> allPatients = patientService.getPatients();
            
            // Get generaliste's consultations
            List<Consultation> consultations = consultationService.getConsultationsByGeneraliste(generaliste.getId());
            
            // Filter patients using Stream API: only those waiting AND without active consultations
            List<Patient> waitingPatients = allPatients.stream()
                    .filter(patient -> patient != null && patient.isFileAttente())
                    .filter(patient -> !hasActiveConsultation(patient))
                    .collect(Collectors.toList());
            
            // Calculate today's consultations count
            long todayCount = consultations.stream()
                    .filter(c -> c != null && c.getDateConsultation() != null)
                    .filter(c -> c.getDateConsultation().toLocalDate().equals(java.time.LocalDate.now()))
                    .count();
            
            request.setAttribute("patients", waitingPatients);
            request.setAttribute("consultations", consultations);
            request.setAttribute("todayCount", todayCount);
            request.setAttribute("generaliste", generaliste);
            
            request.getRequestDispatcher("/dashboard/generaliste/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in GeneralisteServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard data");
            request.getRequestDispatcher("/dashboard/generaliste/dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Helper method to check if a patient has an active or completed consultation
     * Patient should not appear in waiting queue if they have any consultation that is:
     * - EN_COURS (in progress)
     * - EN_ATTENTE_AVIS_SPECIALISTE (waiting for specialist opinion)
     * - TERMINEE (completed)
     */
    private boolean hasActiveConsultation(Patient patient) {
        if (patient == null || patient.getDossierMedical() == null) {
            return false;
        }
        
        List<Consultation> consultations = patient.getDossierMedical().getConsultations();
        if (consultations == null || consultations.isEmpty()) {
            return false;
        }
        
        return consultations.stream()
                .anyMatch(c -> c != null && 
                              (c.getStatus() == StatutConsultation.EN_COURS || 
                               c.getStatus() == StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE ||
                               c.getStatus() == StatutConsultation.TERMINEE));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !(session.getAttribute("user") instanceof Generaliste)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Generaliste generaliste = (Generaliste) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            if ("startConsultation".equals(action)) {
                long patientId = Long.parseLong(request.getParameter("patientId"));
                Patient patient = patientService.getPatient(patientId);
                
                // Validate patient has dossier medical
                if (patient == null || patient.getDossierMedical() == null) {
                    request.setAttribute("errorMessage", "Patient or medical record not found");
                    doGet(request, response);
                    return;
                }
                
                // Create new consultation
                Consultation consultation = new Consultation();
                // Use the generaliste ID to avoid detached entity issues
                consultation.setGeneraliste(generaliste);
                consultation.setDossierMedical(patient.getDossierMedical());
                consultation.setDateConsultation(LocalDateTime.now());
                consultation.setStatus(StatutConsultation.EN_COURS);
                
                // Create consultation and get the persisted entity with ID
                Consultation savedConsultation = consultationService.createConsultation(consultation);
                
                if (savedConsultation != null && savedConsultation.getId() > 0) {
                    session.setAttribute("successMessage", "Consultation started successfully");
                    response.sendRedirect(request.getContextPath() + "/dashboard/generaliste/consultation?id=" + savedConsultation.getId());
                } else {
                    request.setAttribute("errorMessage", "Failed to create consultation");
                    doGet(request, response);
                }
                
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
            }
        } catch (Exception e) {
            System.err.println("Error in GeneralisteServlet POST: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}
