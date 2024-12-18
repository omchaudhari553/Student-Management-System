<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .present { color: green; }
        .absent { color: red; }
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
<body>
    <%@ include file="navbar.jsp" %>
    <div class="container mt-4">
        <h2>Attendance Management</h2>
        
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

        <div class="card mb-4">
            <div class="card-header">
                <h5>Add New Attendance</h5>
            </div>
            <div class="card-body">
                <form action="AttendanceServlet" method="post">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label>Class:</label>
                            <select name="classId" id="classSelect" class="form-control" required>
                                <option value="">Select Class</option>
                                <% 
                                try (Connection conn = DBConnection.getConnection();
                                     Statement stmt = conn.createStatement();
                                     ResultSet rs = stmt.executeQuery("SELECT * FROM classes")) {
                                    while (rs.next()) { %>
                                        <option value="<%= rs.getInt("id") %>">
                                            <%= rs.getString("class_name") %>
                                        </option>
                                    <% }
                                } catch (SQLException e) { 
                                    e.printStackTrace(); 
                                } %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label>Date:</label>
                            <input type="date" name="date" id="dateInput" class="form-control" required>
                        </div>
                    </div>

                    <div id="studentList" style="display: none;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Roll No</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id="studentTableBody">
                            </tbody>
                        </table>
                        <button type="submit" class="btn btn-primary">Save Attendance</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5>View Attendance Records</h5>
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Class</th>
                            <th>Student</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try (Connection conn = DBConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery(
                                "SELECT ar.id, ar.date, c.class_name, s.name, ar.status " +
                                "FROM attendance_records ar " +
                                "JOIN classes c ON ar.class_id = c.id " +
                                "JOIN students s ON ar.student_id = s.sid " +
                                "ORDER BY ar.date DESC, c.class_name, s.name")) {
                            
                            while (rs.next()) {
                                String statusClass = rs.getString("status").equals("PRESENT") ? "present" : "absent";
                                int recordId = rs.getInt("id");
                        %>
                            <tr>
                                <td><%= rs.getDate("date") %></td>
                                <td><%= rs.getString("class_name") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td class="<%= statusClass %>"><%= rs.getString("status") %></td>
                                <td>
                                    <form action="AttendanceServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                        <button type="submit" class="btn btn-link p-0 delete-btn" onclick="return confirm('Are you sure you want to delete this attendance record?');">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <%  }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set today's date
        document.getElementById('dateInput').valueAsDate = new Date();

        // Load students when class is selected
        document.getElementById('classSelect').addEventListener('change', function() {
            const classId = this.value;
            const studentList = document.getElementById('studentList');
            const studentTableBody = document.getElementById('studentTableBody');

            if (!classId) {
                studentList.style.display = 'none';
                return;
            }

            fetch('GetStudentsServlet?classId=' + classId)
                .then(response => response.text())
                .then(html => {
                    studentTableBody.innerHTML = html;
                    studentList.style.display = 'block';
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error loading students');
                });
        });
    </script>
</body>
</html>
