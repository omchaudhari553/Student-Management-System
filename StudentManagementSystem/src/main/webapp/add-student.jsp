<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="navbar.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-light: #818cf8;
            --primary-dark: #4f46e5;
            --accent: #f43f5e;
            --background: #f8fafc;
            --surface: #ffffff;
            --surface-2: #f1f5f9;
            --text: #0f172a;
            --text-secondary: #475569;
            --border: #e2e8f0;
            --success: #22c55e;
            --error: #ef4444;
            --shadow: rgba(51, 65, 85, 0.1);
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
            color: var(--text);
            line-height: 1.6;
            padding: 1rem;
            position: relative;
            z-index: 1;
            min-height: 100vh;
            padding-top: 5rem;
        }

        .container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            background: var(--surface);
            border-radius: 16px;
            border: 1px solid var(--border);
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px var(--shadow);
        }

        h2 {
            font-weight: 700;
            font-size: 1.75rem;
            color: var(--primary);
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text);
            font-size: 0.9375rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 1rem;
            color: var(--text);
            background: var(--surface);
            transition: all 0.2s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        button[type="submit"] {
            width: 100%;
            padding: 0.875rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 1rem;
        }

        button[type="submit"]:hover {
            background: var(--primary-dark);
        }

        button[type="submit"]:active {
            transform: scale(0.98);
        }

        .success-message,
        .error-message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 500;
            text-align: center;
        }

        .success-message {
            background: rgba(34, 197, 94, 0.1);
            color: var(--success);
            border: 1px solid rgba(34, 197, 94, 0.2);
        }

        .error-message {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        @media (max-width: 768px) {
            body {
                padding: 0.75rem;
                padding-top: 4rem;
            }

            .container {
                padding: 1.25rem;
                border-radius: 12px;
            }

            h2 {
                font-size: 1.5rem;
                margin-bottom: 1.25rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            label {
                font-size: 0.875rem;
            }

            input[type="text"],
            input[type="email"],
            input[type="tel"],
            input[type="number"],
            select {
                padding: 0.625rem;
                font-size: 1rem;
            }

            button[type="submit"] {
                padding: 0.75rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 0.5rem;
                padding-top: 4rem;
            }

            .container {
                padding: 1rem;
                border-radius: 8px;
            }

            h2 {
                font-size: 1.25rem;
            }

            input[type="text"],
            input[type="email"],
            input[type="tel"],
            input[type="number"],
            select {
                font-size: 16px; /* Prevents zoom on iOS */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Student</h2>
        
        <% 
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <%
            session.removeAttribute("message");
            session.removeAttribute("messageType");
            }
        %>
        
        <form action="addStudent" method="post">
            <div class="form-content">
                <div class="form-group">
                    <label for="sid">Student ID</label>
                    <input type="number" id="sid" name="sid" required placeholder="Enter student ID">
                </div>
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" required placeholder="Enter full name">
                </div>
                <div class="form-group">
                    <label for="age">Age</label>
                    <input type="number" id="age" name="age" required placeholder="Enter age">
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required placeholder="Enter email address">
                </div>
            </div>
            
            <button type="submit">Add Student</button>
        </form>
    </div>
</body>
</html>
