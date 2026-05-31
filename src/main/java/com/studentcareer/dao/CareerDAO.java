package com.studentcareer.dao;

import com.studentcareer.model.CareerSuggestion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CareerDAO {

    // ✅ Insert suggestion (used by Admin)
    public boolean addSuggestion(CareerSuggestion cs) {
        String sql = "INSERT INTO career_suggestions (skill_name, suggestion) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, cs.getSkillName().trim());
            pst.setString(2, cs.getSuggestion().trim());

            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error adding suggestion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get suggestions for a particular skill (used by Student)
    public List<CareerSuggestion> getSuggestionsBySkill(String skillName) {
        List<CareerSuggestion> list = new ArrayList<>();
        String sql = "SELECT id, skill_name, suggestion FROM career_suggestions WHERE skill_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, skillName);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                CareerSuggestion cs = new CareerSuggestion(
                    rs.getInt("id"),
                    rs.getString("skill_name"),
                    rs.getString("suggestion")
                );
                list.add(cs);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching suggestions by skill: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Get all suggestions (for Admin)
    public List<CareerSuggestion> getAllSuggestions() {
        List<CareerSuggestion> list = new ArrayList<>();
        String sql = "SELECT id, skill_name, suggestion FROM career_suggestions ORDER BY skill_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                list.add(new CareerSuggestion(
                    rs.getInt("id"),
                    rs.getString("skill_name"),
                    rs.getString("suggestion")
                ));
            }

        } catch (SQLException e) {
            System.out.println("Error fetching all suggestions: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Delete suggestion by ID (for Admin)
    public boolean deleteSuggestion(int id) {
        String sql = "DELETE FROM career_suggestions WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, id);
            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting suggestion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
