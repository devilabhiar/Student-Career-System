package com.studentcareer.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.studentcareer.dao.StudentDAO;
import com.studentcareer.model.Student;

public class ViewStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Admin session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        // ✅ Fetch all students
        StudentDAO studentDAO = new StudentDAO();
        List<Student> studentList = studentDAO.getAllStudents();

        // ✅ Forward to JSP
        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("view_students.jsp").forward(request, response);
    }
}
