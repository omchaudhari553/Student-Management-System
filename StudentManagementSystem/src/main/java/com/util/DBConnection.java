package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // Make sure you have the MySQL JDBC driver
            String url = "jdbc:mysql://localhost:3306/java_ee";  // Replace with your DB details
            String username = "root";  // Your database username
            String password = "Shubham@12345";  // Your database password
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found.", e);
        }
    }
}
