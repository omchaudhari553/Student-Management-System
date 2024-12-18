<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:include page="navbar.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        .dashboard-container {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
        }
        .welcome-message {
            color: #2c3e50;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="welcome-message">
            <h1>Welcome to Student Management System</h1>
            <h3>Welcome, <%= session.getAttribute("username") %>!</h3>
            <p>You have successfully logged in.</p>
        </div>
    </div>
</body>
</html>