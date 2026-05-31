package com.studentcareer.servlet;

import com.studentcareer.dao.CareerDAO;
import com.studentcareer.dao.StudentDAO;
import com.studentcareer.model.CareerSuggestion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

//@WebServlet("/ShowCareerSuggestionsServlet")
public class ShowCareerSuggestionsServlet extends HttpServlet {

    private final CareerDAO careerDAO = new CareerDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔒 Session check
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("studentEmail") == null) {
            resp.sendRedirect("index.html");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");
        int studentId = StudentDAO.getStudentIdByEmail(email);

        // 🧠 Fetch student's skills
        List<String> skills = studentDAO.getSkillNamesByStudentId(studentId);

        if (skills == null || skills.isEmpty()) {
            req.setAttribute("message", "No skills found. Please add your skills first.");
            req.getRequestDispatcher("student-career-suggestions.jsp").forward(req, resp);
            return;
        }

        // 🧩 Map: Skill -> Career Suggestions list
        Map<String, List<CareerSuggestion>> suggestionsMap = new LinkedHashMap<>();

        for (String skill : skills) {
            List<CareerSuggestion> list = careerDAO.getSuggestionsBySkill(skill);
            suggestionsMap.put(skill, list != null ? list : new ArrayList<>());
        }

        // ✅ Send data to JSP
        req.setAttribute("suggestionsMap", suggestionsMap);
        req.getRequestDispatcher("student-career-suggestions.jsp").forward(req, resp);
    }
}
