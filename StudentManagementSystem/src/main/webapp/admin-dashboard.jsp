<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Student Management System</title>
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
        .metric-value {
            font-size: 24px;
            font-weight: bold;
            color: #4a5568;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-light">
    <%
    // Check if user is logged in and is admin
    String userType = (String) session.getAttribute("userType");
    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>

    <%@ include file="navbar.jsp" %>

    <div class="container-fluid mt-4 px-4">
        <h2 class="mb-4">Admin Dashboard</h2>
        <p>Welcome, ${sessionScope.username}!</p>

        <!-- Quick Stats Row -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Students</h6>
                            <div class="metric-value">350</div>
                        </div>
                        <i class="fas fa-users fa-2x text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Total Classes</h6>
                            <div class="metric-value">12</div>
                        </div>
                        <i class="fas fa-chalkboard-teacher fa-2x text-success"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Attendance Rate</h6>
                            <div class="metric-value">92%</div>
                        </div>
                        <i class="fas fa-chart-line fa-2x text-warning"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-muted">Fee Collection</h6>
                            <div class="metric-value">₹5.2L</div>
                        </div>
                        <i class="fas fa-rupee-sign fa-2x text-danger"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Management Cards Row -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-4 text-center">
                    <i class="fas fa-user-graduate fa-3x mb-3 text-primary"></i>
                    <h5>Student Management</h5>
                    <div class="mt-3">
                        <a href="ViewAllStudentsServlet" class="btn btn-primary btn-sm mb-2 w-100">View All Students</a>
                        <a href="search-student.jsp" class="btn btn-outline-primary btn-sm w-100">Search Students</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-4 text-center">
                    <i class="fas fa-chalkboard fa-3x mb-3 text-success"></i>
                    <h5>Class Management</h5>
                    <p class="text-muted">Manage classes and sections</p>
                    <a href="manage-classes.jsp" class="btn btn-success">Manage</a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-4 text-center">
                    <i class="fas fa-calendar-check fa-3x mb-3 text-warning"></i>
                    <h5>Attendance Records</h5>
                    <p class="text-muted">Track student attendance</p>
                    <a href="attendance-records.jsp" class="btn btn-warning">View</a>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card bg-white p-4 text-center">
                    <i class="fas fa-money-check-alt fa-3x mb-3 text-danger"></i>
                    <h5>Fees Management</h5>
                    <p class="text-muted">Manage student fees</p>
                    <a href="manage-fees.jsp" class="btn btn-danger">Manage</a>
                </div>
            </div>
        </div>

        <!-- Top Performing Students Table -->
        <div class="table-container mb-4">
            <h4 class="mb-4">Top Performing Students</h4>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Student Name</th>
                        <th>Class</th>
                        <th>Average Score</th>
                        <th>Attendance</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Rahul Sharma</td>
                        <td>Class X-A</td>
                        <td>98.5%</td>
                        <td>100%</td>
                        <td><span class="badge bg-success">Outstanding</span></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Priya Patel</td>
                        <td>Class X-B</td>
                        <td>97.8%</td>
                        <td>98%</td>
                        <td><span class="badge bg-success">Outstanding</span></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Amit Kumar</td>
                        <td>Class X-A</td>
                        <td>96.5%</td>
                        <td>97%</td>
                        <td><span class="badge bg-primary">Excellent</span></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Sneha Gupta</td>
                        <td>Class X-C</td>
                        <td>95.9%</td>
                        <td>96%</td>
                        <td><span class="badge bg-primary">Excellent</span></td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>Raj Malhotra</td>
                        <td>Class X-B</td>
                        <td>95.2%</td>
                        <td>95%</td>
                        <td><span class="badge bg-primary">Excellent</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>
