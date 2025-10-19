package com.example.medicalplatform.servlet;

import com.example.medicalplatform.model.*;
import com.example.medicalplatform.service.impl.AuthService;
import com.example.medicalplatform.utils.CsrfValidation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.HibernateException;

import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService;
    @Override
    public void init() {
        authService = new AuthService();
    }
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/auth/login.jsp").forward(request,response);
    }
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession(false);
        
        try {
                Utilisateur user = authService.login(email, password);
                if (user != null){
                    if (user instanceof  Admin){
                        session.setAttribute("user",(Admin)user);
                        response.sendRedirect(request.getContextPath()+"/dashboard/admin");
                    } else if(user instanceof Infermier){
                        session.setAttribute("user",(Infermier)user);
                        response.sendRedirect(request.getContextPath()+"/dashboard/infermier");
                    } else if(user instanceof Generaliste){
                        session.setAttribute("user",(Generaliste)user);
                        response.sendRedirect(request.getContextPath()+"/dashboard/generaliste");
                    } else if (user instanceof Specialiste){
                        session.setAttribute("user",(Specialiste)user);
                        response.sendRedirect(request.getContextPath()+"/dashboard/specialiste");
                    }
                } else {
                    request.setAttribute("errorMessage", "Email or password is incorrect");
                    request.getRequestDispatcher("/auth/login.jsp").forward(request,response);
                }
            } catch (HibernateException e){
                request.setAttribute("message",e.getMessage());
                request.getRequestDispatcher("/auth/login.jsp").forward(request,response);
            }
    }

}
