package com.studentcareer.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static String url = "jdbc:mysql://localhost:3306/student_career_db?useSSL=false";
    private static String username = "root";
    private static String password = "Abhishek@143rs"; // Change as needed

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
