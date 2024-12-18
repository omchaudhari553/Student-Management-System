<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Classes - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .dashboard-card {
            transition: transform 0.3s;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 15px 20px;
        }
        .table {
            margin-bottom: 0;
        }
    </style>
</head>
<body class="bg-light">
    <%@ include file="user-navbar.jsp" %>
    
    <div class="container mt-4">
        <div class="card dashboard-card">
            <div class="card-header">
                <h4 class="mb-0">Available Classes</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Class Name</th>
                                <th>Section</th>
                                <th>Subject</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            try (Connection conn = DBConnection.getConnection()) {
                                String sql = "SELECT class_name, section, subject FROM classes ORDER BY class_name, section";
                                try (PreparedStatement stmt = conn.prepareStatement(sql);
                                     ResultSet rs = stmt.executeQuery()) {
                                    while (rs.next()) {
                            %>
                                        <tr>
                                            <td><%= rs.getString("class_name") %></td>
                                            <td><%= rs.getString("section") %></td>
                                            <td><%= rs.getString("subject") %></td>
                                        </tr>
                            <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='3' class='text-danger'>Error loading classes: " + e.getMessage() + "</td></tr>");
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
