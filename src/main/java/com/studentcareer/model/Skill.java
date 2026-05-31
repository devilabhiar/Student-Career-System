package com.studentcareer.model;

public class Skill {

    private int studentId;
    private String studentName;
    private String email;
    private String skillName;
    private String skillLevel;

    // ✅ Default constructor
    public Skill() {
    }

    // ✅ Parameterized constructor (optional - for DAO use)
    public Skill(int studentId, String studentName, String email, String skillName, String skillLevel) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.email = email;
        this.skillName = skillName;
        this.skillLevel = skillLevel;
    }

    // ✅ Getters
    public int getStudentId() {
        return studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public String getEmail() {
        return email;
    }

    public String getSkillName() {
        return skillName;
    }

    public String getSkillLevel() {
        return skillLevel;
    }

    // ✅ Setters
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public void setSkillLevel(String skillLevel) {
        this.skillLevel = skillLevel;
    }

    // ✅ Optional: toString for debug
    @Override
    public String toString() {
        return "Skill{" +
                "studentId=" + studentId +
                ", studentName='" + studentName + '\'' +
                ", email='" + email + '\'' +
                ", skillName='" + skillName + '\'' +
                ", skillLevel='" + skillLevel + '\'' +
                '}';
    }
}
