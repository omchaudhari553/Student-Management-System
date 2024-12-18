<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String userType = (String) session.getAttribute("userType");
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-light: #818cf8;
            --primary-dark: #3730a3;
            --secondary: #f43f5e;
            --background: #f8fafc;
            --surface: #ffffff;
            --text: #0f172a;
            --text-secondary: #475569;
            --border: #e2e8f0;
            --shadow: rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }
        
        body {
            background-color: var(--background);
            min-height: 100vh;
            color: var(--text);
            line-height: 1.6;
            padding-top: 5rem;
        }
        
        .dashboard-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 1.5rem;
            min-height: calc(100vh - 5rem);
        }
        
        .welcome-message {
            background: var(--surface);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px var(--shadow),
                       0 2px 4px -2px var(--shadow);
            text-align: center;
        }
        
        .welcome-message h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            line-height: 1.2;
        }
        
        .welcome-message h3 {
            font-size: 1.5rem;
            color: var(--text);
            margin-bottom: 1rem;
            font-weight: 600;
        }
        
        .welcome-message p {
            font-size: 1.125rem;
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
            gap: 2rem;
        }
        
        .action-button {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.25rem;
            background: var(--surface);
            color: var(--text);
            border: 1px solid var(--border);
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px var(--shadow);
            position: relative;
            overflow: hidden;
        }
        
        .action-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px -2px var(--shadow);
            border-color: var(--primary);
            color: var(--primary);
            background: linear-gradient(145deg, var(--surface), #f8fafc);
        }
        
        .action-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255, 255, 255, 0.2),
                transparent
            );
            transition: 0.5s;
        }
        
        .action-button:hover::before {
            left: 100%;
        }
        
        .action-button i {
            font-size: 1.5rem;
            color: var(--primary);
            transition: transform 0.3s ease;
        }
        
        .action-button:hover i {
            transform: scale(1.1);
        }
        
        .student-info {
            padding: 2rem;
            background: var(--surface);
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px var(--shadow),
                       0 2px 4px -2px var(--shadow);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .info-label {
            font-size: 1.125rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        .info-value {
            font-size: 1.125rem;
            color: var(--text);
        }
        
        @media (max-width: 768px) {
            body {
                padding-top: 4.5rem;
            }
            
            .dashboard-container {
                padding: 1rem;
            }
            
            .welcome-message {
                padding: 1.5rem;
                border-radius: 12px;
            }
            
            .welcome-message h1 {
                font-size: 2rem;
            }
            
            .welcome-message h3 {
                font-size: 1.25rem;
            }
            
            .welcome-message p {
                font-size: 1rem;
            }
            
            .action-buttons {
                flex-direction: column;
                padding: 0;
                gap: 1rem;
            }
            
            .action-button {
                width: 100%;
                padding: 1rem;
                font-size: 1rem;
            }
            
            .action-button i {
                font-size: 1.25rem;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding-top: 4rem;
            }
            
            .dashboard-container {
                padding: 0.75rem;
            }
            
            .welcome-message {
                padding: 1.25rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
            }
            
            .welcome-message h1 {
                font-size: 1.75rem;
            }
            
            .welcome-message h3 {
                font-size: 1.125rem;
            }
            
            .welcome-message p {
                font-size: 0.875rem;
                margin-bottom: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%
    if ("admin".equals(userType)) {
        %><%@ include file="admin-navbar.jsp" %><%
    } else {
        %><%@ include file="user-navbar.jsp" %><%
    }
    %>
    
    <div class="dashboard-container">
        <%
        if ("admin".equals(userType)) {
        %>
            <div class="welcome-message">
                <h1>Welcome to Student Management System</h1>
                <h3>Hello, <%= session.getAttribute("username") %>!</h3>
                <p>Manage your students efficiently with our comprehensive system.</p>
            </div>
            
            <div class="action-buttons">
                <a href="add-student.jsp" class="action-button">
                    <i class="fas fa-user-plus"></i>
                    <span>Add New Student</span>
                </a>
                <a href="search-student.jsp" class="action-button">
                    <i class="fas fa-search"></i>
                    <span>Find Student</span>
                </a>
            </div>
        <%
        } else {
        %>
            <div class="welcome-message">
                <h1>Welcome, <%= session.getAttribute("username") %>!</h1>
                <h3>Your Student Information</h3>
            </div>
            
            <div class="student-info">
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Student ID</span>
                        <span class="info-value"><%= session.getAttribute("sid") != null ? session.getAttribute("sid") : "Not Available" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Name</span>
                        <span class="info-value"><%= session.getAttribute("name") != null ? session.getAttribute("name") : "Not Available" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Age</span>
                        <span class="info-value"><%= session.getAttribute("age") != null ? session.getAttribute("age") : "Not Available" %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Email</span>
                        <span class="info-value"><%= session.getAttribute("email") != null ? session.getAttribute("email") : session.getAttribute("username") %></span>
                    </div>
                </div>
            </div>
        <%
        }
        %>
    </div>
</body>
</html>