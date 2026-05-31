package com.studentcareer.model;

public class CareerSuggestion {
    private int id;
    private String skillName;
    private String suggestion;

    // Default constructor
    public CareerSuggestion() {}

    // Constructor with all fields
    public CareerSuggestion(int id, String skillName, String suggestion) {
        this.id = id;
        this.skillName = skillName;
        this.suggestion = suggestion;
    }

    // Constructor without id (used when adding new suggestion)
    public CareerSuggestion(String skillName, String suggestion) {
        this.skillName = skillName;
        this.suggestion = suggestion;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName != null ? skillName.trim() : null;
    }

    public String getSuggestion() {
        return suggestion;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion != null ? suggestion.trim() : null;
    }

    @Override
    public String toString() {
        return "CareerSuggestion{" +
                "id=" + id +
                ", skillName='" + skillName + '\'' +
                ", suggestion='" + suggestion + '\'' +
                '}';
    }
}
