<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Fees - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .fee-status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 4px;
            display: inline-block;
            min-width: 100px;
            text-align: center;
        }
        .status-paid {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .status-pending {
            background-color: #f8d7da;
            color: #842029;
        }
        .status-overdue {
            background-color: #ff6b6b;
            color: #ffffff;
        }
        .status-partial {
            background-color: #fff3cd;
            color: #664d03;
        }
    </style>
</head>
<body>
    <%@ include file="user-navbar.jsp" %>
    
    <div class="container mt-4">
        <% 
        String error = (String) session.getAttribute("error");
        String success = (String) session.getAttribute("success");
        if (error != null) {
            session.removeAttribute("error");
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
        }
        if (success != null) {
            session.removeAttribute("success");
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
        }
        %>
        
        <div class="card shadow">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">Manage Student Fees</h4>
                <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addFeeModal">
                    <i class="fas fa-plus"></i> Add New Fee
                </button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Student Name</th>
                                <th>Fee Type</th>
                                <th>Amount</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            try (Connection conn = DBConnection.getConnection()) {
                                String sql = "SELECT f.*, s.name FROM fees f JOIN students s ON f.s_id = s.sid ORDER BY f.due_date DESC";
                                try (PreparedStatement stmt = conn.prepareStatement(sql);
                                     ResultSet rs = stmt.executeQuery()) {
                                    while (rs.next()) {
                                        String status = rs.getString("status");
                                        String statusClass = "status-" + status.toLowerCase();
                            %>
                                        <tr>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getString("fee_type") %></td>
                                            <td>₹<%= String.format("%.2f", rs.getDouble("amount")) %></td>
                                            <td><%= rs.getDate("due_date") %></td>
                                            <td>
                                                <span class="fee-status <%= statusClass %>">
                                                    <%= status %>
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-danger" onclick="deleteFee(<%= rs.getInt("fee_id") %>)">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                            <%
                                    }
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Fee Modal -->
    <div class="modal fade" id="addFeeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Add New Fee</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="ManageFeesServlet" method="POST" class="needs-validation" novalidate>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="student" class="form-label">Student <span class="text-danger">*</span></label>
                            <select class="form-select" name="s_id" id="student" required>
                                <option value="">Select Student</option>
                                <% 
                                try (Connection conn = DBConnection.getConnection()) {
                                    String sql = "SELECT sid, name FROM students ORDER BY name";
                                    try (PreparedStatement stmt = conn.prepareStatement(sql);
                                         ResultSet rs = stmt.executeQuery()) {
                                        while (rs.next()) {
                                %>
                                            <option value="<%= rs.getInt("sid") %>">
                                                <%= rs.getString("name") %>
                                            </option>
                                <%
                                        }
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                %>
                            </select>
                            <div class="invalid-feedback">Please select a student.</div>
                        </div>
                        <div class="mb-3">
                            <label for="feeType" class="form-label">Fee Type <span class="text-danger">*</span></label>
                            <select class="form-select" name="fee_type" id="feeType" required>
                                <option value="">Select Fee Type</option>
                                <option value="Tuition">Tuition Fee</option>
                                <option value="Exam">Exam Fee</option>
                                <option value="Library">Library Fee</option>
                                <option value="Transport">Transport Fee</option>
                            </select>
                            <div class="invalid-feedback">Please select a fee type.</div>
                        </div>
                        <div class="mb-3">
                            <label for="amount" class="form-label">Amount <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <input type="number" class="form-control" name="amount" id="amount" required min="1" step="0.01">
                            </div>
                            <div class="invalid-feedback">Please enter a valid amount greater than 0.</div>
                        </div>
                        <div class="mb-3">
                            <label for="dueDate" class="form-label">Due Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="due_date" id="dueDate" required>
                            <div class="invalid-feedback">Please select a due date.</div>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status <span class="text-danger">*</span></label>
                            <select class="form-select" name="status" id="status" required>
                                <option value="">Select Status</option>
                                <option value="Paid">Paid</option>
                                <option value="Pending">Pending</option>
                                <option value="Overdue">Overdue</option>
                                <option value="Partial">Partial</option>
                            </select>
                            <div class="invalid-feedback">Please select a status.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Fee</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()

        function deleteFee(feeId) {
            if (confirm('Are you sure you want to delete this fee record?')) {
                window.location.href = 'ManageFeesServlet?action=delete&id=' + feeId;
            }
        }
    </script>
</body>
</html>
