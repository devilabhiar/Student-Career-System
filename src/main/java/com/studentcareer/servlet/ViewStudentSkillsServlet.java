package com.studentcareer.servlet;

import com.studentcareer.dao.AdminDAO;
import com.studentcareer.model.Skill;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet; // ADD THIS
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewStudentSkills") // ✅ Add this annotation
public class ViewStudentSkillsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            AdminDAO dao = new AdminDAO();
            List<Skill> skillList = dao.getAllStudentSkills();

            request.setAttribute("skills", skillList);
            RequestDispatcher rd = request.getRequestDispatcher("admin-view-skills.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong while fetching student skills.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
