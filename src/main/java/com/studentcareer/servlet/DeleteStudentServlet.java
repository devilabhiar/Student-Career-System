package com.studentcareer.servlet;

import com.studentcareer.dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


public class DeleteStudentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);

                // Use DAO object to delete student
                StudentDAO dao = new StudentDAO();
                boolean success = dao.deleteStudentById(id);

                if (success) {
                    response.sendRedirect("viewStudents"); // Redirect back to student list
                } else {
                    response.getWriter().println("Failed to delete student.");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid ID format.");
            }
        } else {
            response.getWriter().println("ID not provided.");
        }
    }
}
