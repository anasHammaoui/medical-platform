package com.example.medicalplatform.servlet;

import com.example.medicalplatform.enums.DemandePrioritee;
import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.enums.StatutConsultation;
import com.example.medicalplatform.model.Consultation;
import com.example.medicalplatform.model.DemandeExpertise;
import com.example.medicalplatform.model.Generaliste;
import com.example.medicalplatform.model.Specialiste;
import com.example.medicalplatform.service.impl.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/generaliste/consultation")
public class ConsultationDetailServlet extends HttpServlet {
    private ConsultationService consultationService;

    @Override
    public void init() {
        consultationService = new ConsultationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !(session.getAttribute("user") instanceof Generaliste)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                session.setAttribute("errorMessage", "Consultation ID is missing");
                response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
                return;
            }
            
            long consultationId = Long.parseLong(idParam);
            Consultation consultation = consultationService.getConsultation(consultationId);
            
            if (consultation == null) {
                session.setAttribute("errorMessage", "Consultation not found");
                response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
                return;
            }
            
            request.setAttribute("consultation", consultation);
            request.setAttribute("specialites", SpecialiteEnum.values());
            request.setAttribute("priorites", DemandePrioritee.values());
            
            request.getRequestDispatcher("/WEB-INF/views/generaliste/consultation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid consultation ID format: " + e.getMessage());
            session.setAttribute("errorMessage", "Invalid consultation ID");
            response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
        } catch (Exception e) {
            System.err.println("Error loading consultation: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error loading consultation: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || !(session.getAttribute("user") instanceof Generaliste)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String action = request.getParameter("action");
        long consultationId = Long.parseLong(request.getParameter("consultationId"));

        try {
            Consultation consultation = consultationService.getConsultation(consultationId);
            
            if ("saveObservations".equals(action)) {
                String motif = request.getParameter("motif");
                String observations = request.getParameter("observations");
                
                consultation.setMotif(motif);
                consultation.setObservations(observations);
                
                consultationService.updateConsultation(consultation);
                session.setAttribute("successMessage", "Observations saved successfully");
                
            } else if ("complete".equals(action)) {
                String diagnostic = request.getParameter("diagnostic");
                String traitement = request.getParameter("traitement");
                
                consultation.setDiganostic(diagnostic);
                consultation.setTraitement(traitement);
                consultation.setStatus(StatutConsultation.TERMINEE);
                
                // Remove patient from waiting queue
                consultation.getDossierMedical().getPatient().setFileAttente(false);
                
                consultationService.updateConsultation(consultation);
                session.setAttribute("successMessage", "Consultation completed successfully");
                
                response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
                return;
                
            } else if ("requestSpecialist".equals(action)) {
                String specialiteStr = request.getParameter("specialite");
                SpecialiteEnum specialite = SpecialiteEnum.valueOf(specialiteStr);
                
                // Get specialists for this specialty (sorted by tariff)
                List<Specialiste> specialistes = consultationService.getSpecialistesBySpecialite(specialite);
                
                request.setAttribute("consultation", consultation);
                request.setAttribute("selectedSpecialite", specialite);
                request.setAttribute("specialistes", specialistes);
                request.setAttribute("priorites", DemandePrioritee.values());
                
                request.getRequestDispatcher("/WEB-INF/views/generaliste/demande-expertise.jsp").forward(request, response);
                return;
                
            } else if ("createDemande".equals(action)) {
                String question = request.getParameter("question");
                String prioriteStr = request.getParameter("priorite");
                long specialisteId = Long.parseLong(request.getParameter("specialisteId"));
                long creneauId = Long.parseLong(request.getParameter("creneauId"));
                
                DemandeExpertise demande = new DemandeExpertise();
                demande.setQuestion(question);
                demande.setPrioritee(DemandePrioritee.valueOf(prioriteStr));
                
                // Note: Specialist and creneau linking will be done in the specialist module
                consultationService.createDemandeExpertise(consultation, demande);
                
                session.setAttribute("successMessage", "Specialist request created successfully");
                response.sendRedirect(request.getContextPath() + "/dashboard/generaliste");
                return;
            }
            
            response.sendRedirect(request.getContextPath() + "/dashboard/generaliste/consultation?id=" + consultationId);
            
        } catch (Exception e) {
            System.err.println("Error in consultation action: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/dashboard/generaliste/consultation?id=" + consultationId);
        }
    }
}
