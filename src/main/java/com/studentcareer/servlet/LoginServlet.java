package com.studentcareer.servlet;

import java.io.IOException;

import com.studentcareer.dao.StudentDAO;
import com.studentcareer.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ✅ Student object return karne ke liye updated method call
        Student student = StudentDAO.getStudentByEmailAndPassword(email, password);

        if (student != null) {
            // ✅ Session me dono info store karo
            HttpSession session = request.getSession();
            session.setAttribute("studentId", student.getId());
            session.setAttribute("studentEmail", student.getEmail());
            session.setAttribute("studentName", student.getName());

            // ✅ Redirect to dashboard
            response.sendRedirect("student-dashboard.jsp");
        } else {
            // ❌ Invalid credentials
            response.sendRedirect("student-login.html?error=invalid");
        }
    }
}
