package com.studentcareer.servlet;

import com.studentcareer.dao.CareerDAO;
import com.studentcareer.model.CareerSuggestion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewSuggestionsServlet")
public class ViewSuggestionsServlet extends HttpServlet {
    private CareerDAO careerDAO = new CareerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CareerSuggestion> list = careerDAO.getAllSuggestions();
        req.setAttribute("suggestions", list);
        req.getRequestDispatcher("admin-view-suggestions.jsp").forward(req, resp);
    }
}
