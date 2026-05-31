package com.studentcareer.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.studentcareer.dao.AdminDAO;
import com.studentcareer.model.Admin;

public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Getting input values from admin_login.jsp
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Creating DAO object
        AdminDAO dao = new AdminDAO();

        // Calling DAO method to validate login
        Admin admin = dao.loginAdmin(email, password);

        // If admin found
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            // Redirect to admin dashboard
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            // If login failed, show error on same page
            request.setAttribute("errorMessage", "Invalid email or password");
            RequestDispatcher rd = request.getRequestDispatcher("admin_login.jsp");
            rd.forward(request, response);
        }
    }
}
