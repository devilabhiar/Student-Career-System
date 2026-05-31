package com.studentcareer.dao;

import java.sql.*;
import java.util.*;
import com.studentcareer.model.Student;

public class StudentDAO {

    // ✅ Check if email already exists
    public static boolean emailExists(String email) {
        boolean exists = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id FROM students WHERE email = ?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // ✅ Register a new student
    public static boolean registerStudent(Student student) {
        boolean result = false;
        String sql = "INSERT INTO students (name, email, password, contact, course) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());
            ps.setString(4, student.getContact());
            ps.setString(5, student.getCourse());

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ✅ Get student object by email and password (for login)
    public static Student getStudentByEmailAndPassword(String email, String password) {
        Student student = null;
        String sql = "SELECT * FROM students WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setPassword(rs.getString("password"));
                student.setContact(rs.getString("contact"));
                student.setCourse(rs.getString("course"));
                // Agar 'about' column hai to:
                try { student.setAbout(rs.getString("about")); } catch (SQLException ignore) {}
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    // ✅ NEW: Get student by email (for resume, profile etc.)
    public static Student getStudentByEmail(String email) {
        Student student = null;
        String sql = "SELECT * FROM students WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setPassword(rs.getString("password"));
                student.setContact(rs.getString("contact"));
                student.setCourse(rs.getString("course"));
                // optional summary/about field
                try { student.setAbout(rs.getString("about")); } catch (SQLException ignore) {}
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    // ✅ Validate student login (old version)
    public static boolean validateLogin(String email, String password) {
        boolean isValid = false;
        String sql = "SELECT id FROM students WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            isValid = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    // ✅ Get student ID by email
    public static int getStudentIdByEmail(String email) {
        int studentId = -1;
        String sql = "SELECT id FROM students WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                studentId = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return studentId;
    }

    // ✅ Insert skill and level into student_skills table
    public static boolean insertSkill(int studentId, String skillName, String skillLevel) {
        boolean result = false;
        String sql = "INSERT INTO student_skills (student_id, skill_name, skill_level) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setString(2, skillName);
            ps.setString(3, skillLevel);

            result = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ✅ Fetch all skills and levels by email
    public static List<String> getSkillsByEmail(String email) {
        List<String> skills = new ArrayList<>();
        String sql = "SELECT s.skill_name, s.skill_level FROM student_skills s "
                   + "JOIN students st ON s.student_id = st.id WHERE st.email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skillName = rs.getString("skill_name");
                String skillLevel = rs.getString("skill_level");
                if (skillLevel == null || skillLevel.trim().isEmpty()) skillLevel = "N/A";
                skills.add(skillName + " (" + skillLevel + ")");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return skills;
    }

    // ✅ Get all students for admin
    public List<Student> getAllStudents() {
        List<Student> studentList = new ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setPassword(rs.getString("password"));
                student.setContact(rs.getString("contact"));
                student.setCourse(rs.getString("course"));
                try { student.setAbout(rs.getString("about")); } catch (SQLException ignore) {}
                studentList.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return studentList;
    }

    // ✅ Delete student by ID
    public static boolean deleteStudentById(int id) {
        boolean status = false;
        String sql = "DELETE FROM students WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            status = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // ✅ Get skill names by student ID
    public List<String> getSkillNamesByStudentId(int studentId) {
        List<String> skills = new ArrayList<>();
        String sql = "SELECT skill_name FROM student_skills WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, studentId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) skills.add(rs.getString("skill_name"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return skills;
    }

    // ✅ Update student password
    public static boolean updatePassword(String email, String newPassword) {
        boolean result = false;
        String sql = "UPDATE students SET password = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword.trim());
            stmt.setString(2, email.trim());
            result = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
