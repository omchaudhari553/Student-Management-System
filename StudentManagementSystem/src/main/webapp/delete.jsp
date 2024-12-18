<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #818cf8;
            --background-color: #f8fafc;
            --text-color: #1f2937;
            --border-color: #e5e7eb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            padding-top: 5rem;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .card-header h2 {
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            transition: border-color 0.2s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .btn-danger {
            background-color: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background-color: #dc2626;
            transform: translateY(-1px);
        }

        .text-center {
            text-align: center;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .alert-success {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
            }

            .card {
                padding: 1.5rem;
                border-radius: 12px;
            }

            .card-header h2 {
                font-size: 1.75rem;
            }

            .form-control {
                padding: 0.625rem 0.875rem;
            }

            .btn {
                width: 100%;
                padding: 0.625rem 1.25rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding-top: 4rem;
            }

            .container {
                padding: 0 0.75rem;
            }

            .card {
                padding: 1.25rem;
                border-radius: 8px;
            }

            .card-header h2 {
                font-size: 1.5rem;
            }

            .form-label {
                font-size: 0.875rem;
            }

            .form-control {
                font-size: 0.875rem;
            }

            .btn {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2>Delete Student</h2>
                <p>Enter student ID to remove them from the system</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/deleteStudent" method="get" onsubmit="return confirm('Are you sure you want to delete this student?');">
                <% 
                    String message = (String) session.getAttribute("message");
                    String messageType = (String) session.getAttribute("messageType");
                    if (message != null && messageType != null) {
                %>
                    <div class="alert alert-<%= messageType %>">
                        <%= message %>
                    </div>
                <%
                    session.removeAttribute("message");
                    session.removeAttribute("messageType");
                    }
                %>
                
                <div class="form-group">
                    <label for="sid" class="form-label">Student ID*</label>
                    <input type="number" class="form-control" id="sid" name="sid" required>
                </div>
                
                <div class="text-center">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i>
                        Delete Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
</body>
</html>
