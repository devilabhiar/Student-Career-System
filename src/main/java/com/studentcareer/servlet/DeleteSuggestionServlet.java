package com.studentcareer.servlet;

import com.studentcareer.dao.CareerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteSuggestionServlet")
public class DeleteSuggestionServlet extends HttpServlet {
    private CareerDAO careerDAO = new CareerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            boolean ok = careerDAO.deleteSuggestion(id);
            if (ok) req.getSession().setAttribute("msg", "Deleted successfully");
            else req.getSession().setAttribute("msg", "Delete failed");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("msg", "Invalid id");
        }
        resp.sendRedirect("ViewSuggestionsServlet");
    }
}
