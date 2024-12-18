package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.util.DBConnection;

@WebServlet("/ManageFeesServlet")
public class ManageFeesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            Connection conn = null;
            PreparedStatement pst = null;
            try {
                String feeId = request.getParameter("feeId");
                String status = request.getParameter("status");
                
                conn = DBConnection.getConnection();
                String sql = "UPDATE fees SET status = ? WHERE fee_id = ?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, status);
                pst.setInt(2, Integer.parseInt(feeId));
                
                int result = pst.executeUpdate();
                if(result > 0) {
                    session.setAttribute("success", "Fee status updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update fee status!");
                }
            } catch(Exception e) {
                session.setAttribute("error", "Error updating fee status: " + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if(pst != null) pst.close();
                    if(conn != null) conn.close();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            }
            response.sendRedirect("view-fees.jsp");
            return;
        }
        
        // Get form data
        String s_id = request.getParameter("s_id");
        String feeType = request.getParameter("fee_type");
        String amount = request.getParameter("amount");
        String dueDate = request.getParameter("due_date");
        String status = request.getParameter("status");
        
        // Validate required fields
        if(s_id == null || s_id.trim().isEmpty() || 
           feeType == null || feeType.trim().isEmpty() || 
           amount == null || amount.trim().isEmpty() || 
           dueDate == null || dueDate.trim().isEmpty()) {
            session.setAttribute("error", "Please fill all required fields!");
            response.sendRedirect("manage-fees.jsp");
            return;
        }

        // Set default status to Pending if not provided
        if(status == null || status.trim().isEmpty()) {
            status = "Pending";
        } else {
            status = status.trim();
        }
        
        Connection conn = null;
        PreparedStatement pst = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO fees (s_id, fee_type, amount, due_date, status) VALUES (?, ?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(s_id));
            pst.setString(2, feeType);
            pst.setDouble(3, Double.parseDouble(amount));
            pst.setDate(4, Date.valueOf(dueDate));
            pst.setString(5, status);
            
            int result = pst.executeUpdate();
            if(result > 0) {
                session.setAttribute("success", "Fee record added successfully!");
            } else {
                session.setAttribute("error", "Failed to add fee record!");
            }
        } catch(SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if(pst != null) pst.close();
                if(conn != null) conn.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("manage-fees.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT f.*, s.name as student_name FROM fees f JOIN students s ON f.s_id = s.sid ORDER BY f.due_date";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();
                
                request.setAttribute("feesRecords", rs);
                request.getRequestDispatcher("view-fees.jsp").forward(request, response);
                return;
            } catch(SQLException e) {
                session.setAttribute("error", "Database error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(pst != null) pst.close();
                    if(conn != null) conn.close();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        // Handle delete action
        String id = request.getParameter("id");
        if(action != null && id != null) {
            Connection conn = null;
            PreparedStatement pst = null;
            try {
                conn = DBConnection.getConnection();
                if(action.equals("delete")) {
                    String sql = "DELETE FROM fees WHERE fee_id = ?";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, Integer.parseInt(id));
                    int result = pst.executeUpdate();
                    if(result > 0) {
                        session.setAttribute("success", "Fee record deleted successfully!");
                    } else {
                        session.setAttribute("error", "Failed to delete fee record!");
                    }
                }
            } catch(SQLException e) {
                session.setAttribute("error", "Database error: " + e.getMessage());
                e.printStackTrace();
            } finally {
                try {
                    if(pst != null) pst.close();
                    if(conn != null) conn.close();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        response.sendRedirect("manage-fees.jsp");
    }
}
