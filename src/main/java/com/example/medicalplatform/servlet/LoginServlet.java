package com.example.medicalplatform.servlet;

import com.example.medicalplatform.dao.AdminDao;
import com.example.medicalplatform.dao.AuthDao;
import com.example.medicalplatform.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private AuthDao authDao;
    @Override
    public void init() {
        authDao = new AuthDao();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/auth/login.jsp").forward(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Admin admin = authDao.findAdminByEmail(email);
        if (admin != null) {
            if (BCrypt.checkpw(password, admin.getMotDePasse())) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                request.setAttribute("auth", "Login successful");

            } else {
                request.setAttribute("auth", "password incorrect");
            }
        } else {
            request.setAttribute("auth", "Incorrrect email");
        }

        request.getRequestDispatcher("/home.jsp").forward(request, response);

    }

}
