<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Classes - Student Management System</title>
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
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
            padding: 8px 20px;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
        }
        .form-control {
            border-radius: 5px;
            padding: 10px;
        }
    </style>
</head>
<body class="bg-light">
    <%@ include file="navbar.jsp" %>
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manage Classes</h2>
            <a href="admin-dashboard.jsp" class="btn btn-primary"><i class="fas fa-arrow-left me-2"></i>Back to Admin Dashboard</a>
        </div>

        <!-- Add New Class Form -->
        <div class="card dashboard-card">
            <div class="card-header">
                <h4 class="mb-0">Add New Class</h4>
            </div>
            <div class="card-body">
                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getParameter("error") %>
                    </div>
                <% } %>
                <% if (request.getParameter("success") != null) { %>
                    <div class="alert alert-success">
                        Class added successfully!
                    </div>
                <% } %>
                <form action="ManageClassesServlet" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="className" class="form-label">Class Name</label>
                        <input type="text" class="form-control" id="className" name="className" required>
                    </div>
                    <div class="mb-3">
                        <label for="section" class="form-label">Section</label>
                        <input type="text" class="form-control" id="section" name="section" required>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" name="subject" required>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Class
                    </button>
                </form>
            </div>
        </div>

        <!-- List of Classes -->
        <div class="card dashboard-card">
            <div class="card-header">
                <h4 class="mb-0">Existing Classes</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Class ID</th>
                                <th>Class Name</th>
                                <th>Section</th>
                                <th>Subject</th>
                                <th>Created At</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            try (Connection conn = DBConnection.getConnection()) {
                                String sql = "SELECT id, class_name, section, subject, created_at FROM classes ORDER BY created_at DESC";
                                try (PreparedStatement stmt = conn.prepareStatement(sql);
                                     ResultSet rs = stmt.executeQuery()) {
                                    while (rs.next()) {
                            %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("class_name") %></td>
                                            <td><%= rs.getString("section") %></td>
                                            <td><%= rs.getString("subject") %></td>
                                            <td><%= rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toString() : "N/A" %></td>
                                        </tr>
                            <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='5' class='text-danger'>Error loading classes: " + e.getMessage() + "</td></tr>");
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
