package com.studentcareer.dao;

import com.studentcareer.model.Admin;
import com.studentcareer.model.Skill;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    // ✅ Admin Login
    public Admin loginAdmin(String email, String password) {
        Admin admin = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String pass = rs.getString("password");

                admin = new Admin(id, username, pass);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }

    // ✅ Get all student skills with name & email
    public List<Skill> getAllStudentSkills() {
        List<Skill> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                "SELECT s.student_id, st.name, st.email, s.skill_name, s.skill_level " +
                "FROM student_skills s " +
                "INNER JOIN students st ON s.student_id = st.id")) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Skill skill = new Skill();
                skill.setStudentId(rs.getInt("student_id"));
                skill.setStudentName(rs.getString("name"));
                skill.setEmail(rs.getString("email"));
                skill.setSkillName(rs.getString("skill_name"));
                skill.setSkillLevel(rs.getString("skill_level")); // currently null but handled
                list.add(skill);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
