<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        .error-container {
            width: 80%;
            margin: 50px auto;
            text-align: center;
        }
        .error-message {
            color: red;
            margin: 20px 0;
            padding: 10px;
            border: 1px solid red;
            background-color: #ffe6e6;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="error-container">
        <h2>Error Occurred</h2>
        <div class="error-message">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unknown error occurred" %>
        </div>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>