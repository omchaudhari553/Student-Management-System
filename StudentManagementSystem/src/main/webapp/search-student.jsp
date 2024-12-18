<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<jsp:include page="navbar.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Student</title>
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
            min-height: 100vh;
            color: var(--text);
            line-height: 1.6;
            padding: 1rem;
            padding-top: 5rem;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            background: var(--surface);
            border-radius: 16px;
            border: 1px solid var(--border);
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px var(--shadow);
        }

        h2 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-align: center;
            color: var(--text);
        }

        .search-form {
            width: 100%;
            max-width: 600px;
            margin: 0 auto 1.5rem;
        }

        .search-input {
            width: 100%;
            padding: 0.875rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.2s ease;
            background: var(--surface);
            color: var(--text);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .search-button {
            width: 100%;
            padding: 0.875rem;
            margin-top: 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .search-button:hover {
            background: var(--primary-dark);
        }

        .search-button:active {
            transform: scale(0.98);
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 1.5rem;
            border-radius: 8px;
            border: 1px solid var(--border);
        }

        .student-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        .student-table th,
        .student-table td {
            padding: 0.875rem;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .student-table th {
            background: var(--surface-2);
            font-weight: 600;
            color: var(--text);
            white-space: nowrap;
        }

        .student-table td {
            color: var(--text-secondary);
        }

        .student-table tr:last-child td {
            border-bottom: none;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }

        .back-link:hover {
            color: var(--primary-dark);
        }

        .no-results {
            text-align: center;
            padding: 2rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            body {
                padding: 0.75rem;
                padding-top: 4.5rem;
            }

            .container {
                padding: 1.25rem;
                border-radius: 12px;
            }

            h2 {
                font-size: 1.5rem;
                margin-bottom: 1.25rem;
            }

            .search-input,
            .search-button {
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
                margin-bottom: 1rem;
            }

            .search-input {
                font-size: 16px; /* Prevents zoom on iOS */
            }

            .table-container {
                margin-top: 1rem;
                border-radius: 6px;
            }

            .student-table th,
            .student-table td {
                padding: 0.75rem;
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Search Students</h2>
        
        <form action="searchStudent" method="GET" class="search-form">
            <input type="text" name="query" class="search-input" placeholder="Search by name, ID, or email..." 
                   value="${param.query}" required>
            <button type="submit" class="search-button">Search</button>
        </form>

        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% 
        List<Student> students = (List<Student>) request.getAttribute("students");
        if(students != null && !students.isEmpty()) { 
        %>
            <table class="student-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Age</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Student student : students) { %>
                        <tr>
                            <td><%= student.getSid() %></td>
                            <td><%= student.getName() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getAge() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else if(request.getParameter("query") != null) { %>
            <div class="no-results">
                No students found matching your search criteria.
            </div>
        <% } %>
    </div>
</body>
</html>
