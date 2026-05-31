package com.studentcareer.servlet;

import java.io.IOException;
import com.studentcareer.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get new password
        String newPassword = request.getParameter("newPassword");

        // Get email from session
        HttpSession session = request.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("resetEmail") : null;

        System.out.println("Received newPassword: " + newPassword);
        System.out.println("Session Email: " + email);

        if (email == null || newPassword == null || newPassword.trim().isEmpty()) {
            System.out.println("❌ Missing email or newPassword. Aborting reset.");
            response.sendRedirect("student-reset-password.jsp?error=1");
            return;
        }

        // Update password
        boolean updated = StudentDAO.updatePassword(email, newPassword.trim());

        if (updated) {
            session.removeAttribute("resetEmail");
            System.out.println("✅ Password updated for: " + email);
            response.sendRedirect("student-reset-password.jsp?success=1");
        } else {
            System.out.println("❌ Password update failed in DB for: " + email);
            response.sendRedirect("student-reset-password.jsp?error=1");
        }
    }
}
