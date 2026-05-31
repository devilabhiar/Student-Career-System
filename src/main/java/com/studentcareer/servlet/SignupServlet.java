package com.studentcareer.servlet;

import java.io.IOException;

import com.studentcareer.dao.StudentDAO;
import com.studentcareer.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String contact = request.getParameter("contact");
        String course = request.getParameter("course");

        // Check if email already exists
        if (StudentDAO.emailExists(email)) {
            response.sendRedirect("student-signup.html?error=exists");
            return;
        }

        // Create Student object and set values
        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setPassword(pass);
        student.setContact(contact);
        student.setCourse(course);

        // Save student in DB
        boolean isSaved = StudentDAO.registerStudent(student);

        // Redirect with message
        if (isSaved) {
            response.sendRedirect("student-login.html?success=1");
        } else {
            response.sendRedirect("student-signup.html?error=1");
        }
    }
}
