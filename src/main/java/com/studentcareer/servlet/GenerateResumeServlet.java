package com.studentcareer.servlet;

import com.studentcareer.dao.StudentDAO;
import com.studentcareer.model.Student;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// iText / OpenPDF imports
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.pdf.PdfWriter;

public class GenerateResumeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("student-login.html");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");

        // Fetch student + skills (ensure these DAO methods exist)
        Student student = null;
        List<String> skills = null;
        try {
            student = StudentDAO.getStudentByEmail(email);
            skills = StudentDAO.getSkillsByEmail(email);
        } catch (Exception e) {
            // If DAO throws, log and continue with safe defaults
            e.printStackTrace();
        }

        // Create a safe filename (remove spaces, unsafe chars)
        String baseName = (student != null && student.getName() != null && !student.getName().isBlank())
                ? student.getName().trim()
                : "student";
        // keep only letters, numbers, underscore
        baseName = baseName.replaceAll("[^A-Za-z0-9_\\-]", "_");
        String filename = "resume_" + baseName + ".pdf";

        // Set response headers
        response.setContentType("application/pdf");
        // Use RFC5987 style filename* for UTF-8 safety and fallback
        String encoded = URLEncoder.encode(filename, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + encoded);

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        OutputStream out = response.getOutputStream();
        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Fonts
            Font h1 = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font h2 = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            Font normal = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL);
            Font small = new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC);

            // Name / Header
            String name = (student != null && student.getName() != null && !student.getName().isBlank()) ? student.getName() : email;
            document.add(new Paragraph(name, h1));

            // Contact row
            Paragraph contact = new Paragraph();
            if (student != null && student.getContact() != null && !student.getContact().isBlank()) {
                contact.add(new Chunk("Phone: ", h2));
                contact.add(new Chunk(student.getContact() + "    ", normal));
            }
            contact.add(new Chunk("Email: ", h2));
            contact.add(new Chunk(email, normal));
            document.add(contact);

            document.add(Chunk.NEWLINE);

            // Summary
            document.add(new Paragraph("Summary", h2));
            String about = (student != null && student.getAbout() != null && !student.getAbout().isBlank())
                    ? student.getAbout()
                    : "Motivated student seeking opportunities to learn and grow.";
            document.add(new Paragraph(about, normal));
            document.add(Chunk.NEWLINE);

            // Skills
            document.add(new Paragraph("Skills", h2));
            if (skills != null && !skills.isEmpty()) {
                // com.itextpdf.text.List to avoid conflict with java.util.List
                com.itextpdf.text.List pdfList = new com.itextpdf.text.List(com.itextpdf.text.List.ORDERED, 10);
                for (String s : skills) {
                    pdfList.add(new ListItem(s, normal));
                }
                document.add(pdfList);
            } else {
                document.add(new Paragraph("No skills added.", small));
            }

            document.add(Chunk.NEWLINE);

            // Education / Course
            document.add(new Paragraph("Education", h2));
            String course = (student != null && student.getCourse() != null && !student.getCourse().isBlank())
                    ? student.getCourse()
                    : "B.Tech (Information Technology)";
            document.add(new Paragraph(course, normal));

            document.close();
        } catch (DocumentException de) {
            // Convert to IOException so servlet container can handle it
            throw new IOException("PDF generation error: " + de.getMessage(), de);
        } finally {
            // ensure output stream flushed (container will close it)
            try {
                out.flush();
            } catch (Exception ignore) { }
        }
    }
}
