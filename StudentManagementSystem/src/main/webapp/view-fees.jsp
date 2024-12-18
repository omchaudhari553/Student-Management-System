<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Fees - Student Management System</title>
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
        .fee-status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 4px;
            display: inline-block;
            min-width: 80px;
            text-align: center;
        }
        .paid {
            color: #198754;
            background-color: #d1e7dd;
        }
        .pending {
            color: #dc3545;
            background-color: #f8d7da;
        }
        .delete-btn {
            color: #dc3545;
            cursor: pointer;
            transition: color 0.2s;
        }
        .delete-btn:hover {
            color: #bb2d3b;
        }
    </style>
</head>
<body class="bg-light">
    <% 
    String userType = (String) session.getAttribute("userType");
    if ("admin".equals(userType)) {
    %>
        <%@ include file="admin-navbar.jsp" %>
    <% } else { %>
        <%@ include file="user-navbar.jsp" %>
    <% } %>
    
    <div class="container mt-4">
        <% if (session.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <%= session.getAttribute("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("success"); %>
        <% } %>
        
        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show">
                <%= session.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <div class="card dashboard-card">
            <div class="card-header">
                <h4 class="mb-0">
                    <% if ("admin".equals(userType)) { %>
                        All Fee Records
                    <% } else { %>
                        Fee Records
                    <% } %>
                </h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Fee ID</th>
                                <th>Student Name</th>
                                <th>Fee Type</th>
                                <th>Amount</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            try (Connection conn = DBConnection.getConnection()) {
                                String sql = "SELECT f.*, s.name FROM fees f " +
                                           "JOIN students s ON f.s_id = s.sid " +
                                           "ORDER BY f.fee_id ASC";
                                try (PreparedStatement pstmt = conn.prepareStatement(sql);
                                     ResultSet rs = pstmt.executeQuery()) {
                                    while (rs.next()) {
                                        String status = rs.getString("status");
                                        String statusClass = status.equalsIgnoreCase("Paid") ? "paid" : "pending";
                            %>
                                        <tr>
                                            <td><%= rs.getInt("fee_id") %></td>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getString("fee_type") %></td>
                                            <td>₹<%= String.format("%.2f", rs.getDouble("amount")) %></td>
                                            <td><%= rs.getDate("due_date") %></td>
                                            <td><span class="fee-status <%= statusClass %>"><%= status %></span></td>
                                            <td>
                                                <form action="ManageFeesServlet" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="<%= rs.getInt("fee_id") %>">
                                                    <button type="submit" class="btn btn-link p-0 delete-btn" onclick="return confirm('Are you sure you want to delete this fee record?');">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                            <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='7' class='text-danger'>Error loading fee records: " + e.getMessage() + "</td></tr>");
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
