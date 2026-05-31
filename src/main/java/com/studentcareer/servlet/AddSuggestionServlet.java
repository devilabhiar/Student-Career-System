package com.studentcareer.servlet;

import com.studentcareer.dao.CareerDAO;
import com.studentcareer.model.CareerSuggestion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddSuggestionServlet")
public class AddSuggestionServlet extends HttpServlet {
    private CareerDAO careerDAO = new CareerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String skillName = req.getParameter("skillName");
        String suggestion = req.getParameter("suggestion");

        if (skillName == null || suggestion == null || skillName.trim().isEmpty() || suggestion.trim().isEmpty()) {
            req.getSession().setAttribute("msg", "Please fill all fields");
            resp.sendRedirect("admin-add-suggestion.jsp");
            return;
        }

        CareerSuggestion cs = new CareerSuggestion(skillName.trim(), suggestion.trim());
        boolean ok = careerDAO.addSuggestion(cs);

        if (ok) {
            req.getSession().setAttribute("msg", "Suggestion added successfully");
        } else {
            req.getSession().setAttribute("msg", "Failed to add suggestion");
        }
        resp.sendRedirect("admin-add-suggestion.jsp");
    }
}
