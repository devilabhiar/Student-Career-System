package com.studentcareer.servlet;

import com.studentcareer.dao.StudentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AddSkillServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("student-login.html");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");
        String skill = request.getParameter("skill");
        String level = request.getParameter("skill_level"); // ✅ Corrected parameter name

        int studentId = StudentDAO.getStudentIdByEmail(email);

        boolean success = StudentDAO.insertSkill(studentId, skill, level); // ✅ Insert with level

        if (success) {
            response.sendRedirect("student-dashboard.jsp?success=true");
        } else {
            response.sendRedirect("student-dashboard.jsp?error=true");
        }
    }
}
