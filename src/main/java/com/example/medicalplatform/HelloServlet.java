package com.example.medicalplatform;

import java.io.*;

import com.example.medicalplatform.dao.AdminDao;
import com.example.medicalplatform.model.Admin;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
        AdminDao user = new AdminDao();
        Admin admin = new Admin("Admin", "Admin", "admin@gm.co","admin123");
        try {
            user.saveAdmin(admin);
        } catch (Exception e) {
            out.println("Error saving admin: " + e.getMessage());
            return;
        }
        out.println("Admin saved");

    }

    public void destroy() {
    }
}