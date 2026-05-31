package com.studentcareer.model;

public class Student {
    private int id;
    private String name;
    private String email;
    private String password;
    private String contact;
    private String about;

    private String course;
    // ✅ New field added

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }
    public void setContact(String contact) {
        this.contact = contact;
    }

    // ✅ New getter and setter
    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }
    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about;
    }
    }

