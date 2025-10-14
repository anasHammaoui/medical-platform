package com.example.medicalplatform.servlet;

import com.example.medicalplatform.enums.SpecialiteEnum;
import com.example.medicalplatform.model.Utilisateur;
import com.example.medicalplatform.service.impl.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() {
        authService = new AuthService();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String nom = request.getParameter("fName");
        String prenom = request.getParameter("lName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Map<String, Object> additionalData = new HashMap<>();

            if ("GENERALISTE".equalsIgnoreCase(role) || "SPECIALISTE".equalsIgnoreCase(role)) {
                String telephone = request.getParameter("telephone");
                additionalData.put("telephone", telephone);
            }

            if ("SPECIALISTE".equalsIgnoreCase(role)) {
                String specialiteStr = request.getParameter("specialite");
                if (specialiteStr != null && !specialiteStr.isEmpty()) {
                    SpecialiteEnum specialite = SpecialiteEnum.valueOf(specialiteStr.toUpperCase());
                    additionalData.put("specialite", specialite);
                }

                String tarifStr = request.getParameter("tarif");
                if (tarifStr != null && !tarifStr.isEmpty()) {
                    additionalData.put("tarif", Double.parseDouble(tarifStr));
                }

                String dureeStr = request.getParameter("dureeConsultation");
                if (dureeStr != null && !dureeStr.isEmpty()) {
                    additionalData.put("dureeConsultation", Integer.parseInt(dureeStr));
                }
            }

            Utilisateur user = authService.register(nom, prenom, email, password, role, additionalData);

            if (user != null) {
                request.setAttribute("successMessage", "Registration successful! You can now log in.");
                response.sendRedirect(request.getContextPath() + "/auth/login");
            } else {
                request.setAttribute("errorMessage", "Error during registration");
                request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
            }

        } catch (HibernateException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }
}
