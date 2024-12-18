<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Students - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .controls-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .search-box {
            flex: 1;
            max-width: 300px;
            margin-right: 10px;
        }
        .table-responsive {
            margin-top: 20px;
            overflow-x: auto;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
            justify-content: flex-start;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            transition: opacity 0.2s;
        }
        .btn-action:hover {
            opacity: 0.9;
        }
        @media (max-width: 768px) {
            .controls-row {
                flex-direction: column;
                align-items: stretch;
            }
            .search-box {
                max-width: 100%;
                margin-right: 0;
                margin-bottom: 10px;
            }
            .action-buttons {
                flex-direction: column;
            }
            .btn-action {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="navbar.jsp" />
    
    <div class="container mt-4">
        <!-- Alert Messages -->
        <%
            String success = (String) session.getAttribute("success");
            String error = (String) session.getAttribute("error");
            if (success != null) {
                session.removeAttribute("success");
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
            if (error != null) {
                session.removeAttribute("error");
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
        %>
        
        <h2 class="mb-4">All Students</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% 
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="alert alert-<%= messageType.equals("success") ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            session.removeAttribute("message");
            session.removeAttribute("messageType");
            }
        %>
        
        <div class="table-container">
            <div class="controls-row">
                <div class="search-box">
                    <div class="input-group">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search students...">
                        <button class="btn btn-primary" type="button" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <a href="add-student.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Student
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Age</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="studentTableBody">
                        <% 
                        List<Student> students = (List<Student>) request.getAttribute("students");
                        if(students != null && !students.isEmpty()) {
                            for(Student student : students) {
                        %>
                            <tr>
                                <td><%= student.getSid() %></td>
                                <td><%= student.getName() %></td>
                                <td><%= student.getEmail() %></td>
                                <td><%= student.getAge() %></td>
                                <td class="action-buttons">
                                    <button onclick="deleteStudent(<%= student.getSid() %>, '<%= student.getName() %>')" class="btn-action btn-delete">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        <%
                            }
                        } else {
                        %>
                            <tr>
                                <td colspan="5" class="text-center">No students found</td>
                            </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const searchBtn = document.getElementById('searchBtn');
        const tableBody = document.getElementById('studentTableBody');

        function performSearch() {
            const filter = searchInput.value.toLowerCase();
            const rows = tableBody.getElementsByTagName('tr');
            
            for(let row of rows) {
                const cells = row.getElementsByTagName('td');
                let found = false;
                
                for(let i = 0; i < cells.length - 1; i++) {
                    const cell = cells[i];
                    if(cell.textContent.toLowerCase().includes(filter)) {
                        found = true;
                        break;
                    }
                }
                row.style.display = found ? '' : 'none';
            }
        }

        searchInput.addEventListener('keyup', performSearch);
        searchBtn.addEventListener('click', performSearch);

        // Delete functionality
        function deleteStudent(id, name) {
            if (confirm(`Are you sure you want to delete student "${name}" (ID: ${id})?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/DeleteStudentServlet';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const closeBtn = alert.querySelector('.btn-close');
                    if (closeBtn) {
                        closeBtn.click();
                    }
                }, 5000);
            });
        });
    </script>
</body>
</html>
