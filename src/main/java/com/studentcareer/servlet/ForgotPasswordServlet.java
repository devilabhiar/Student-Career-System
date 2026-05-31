package com.studentcareer.servlet;

import java.io.IOException;
import com.studentcareer.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email != null && !email.trim().isEmpty()) {
            // Check if student email exists
            boolean exists = StudentDAO.emailExists(email.trim());

            if (exists) {
                // Store email in session for reset step
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", email.trim());

                // ✅ Use forward instead of redirect to retain session
                request.getRequestDispatcher("student-reset-password.jsp").forward(request, response);
            } else {
                response.sendRedirect("student-forgot-password.html?error=notfound");
            }
        } else {
            // Invalid email input
            response.sendRedirect("student-forgot-password.html?error=empty");
        }
    }
}
