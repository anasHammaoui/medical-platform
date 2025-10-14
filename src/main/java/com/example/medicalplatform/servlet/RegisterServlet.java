package com.example.medicalplatform.servlet;

import com.example.medicalplatform.dao.AuthDao;
import com.example.medicalplatform.model.Admin;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {
    private AuthDao authDao;
    @Override
    public void init()   {
        authDao = new AuthDao();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    request.getRequestDispatcher("/auth/register.jsp").forward(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("fName");
        String lastName = request.getParameter("lName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (authDao.findAdminByEmail(email) == null) {
            String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());
          String register =  authDao.save(new Admin(name, lastName, email,  hashPassword));
          request.setAttribute("auth", register);
          request.getRequestDispatcher("/home.jsp").forward(request, response);
        } else  {
            String register = "Email already exists";
            request.setAttribute("auth", register);
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }

    }
}
