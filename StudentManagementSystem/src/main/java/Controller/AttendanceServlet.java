package Controller;

import java.io.IOException;
import java.sql.*;
import com.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteAttendance(request, response);
        } else {
            saveAttendance(request, response);
        }
    }

    private void deleteAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM attendance_records WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));
            
            int result = stmt.executeUpdate();
            if (result > 0) {
                request.getSession().setAttribute("success", "Attendance record deleted successfully!");
            } else {
                request.getSession().setAttribute("error", "Failed to delete attendance record.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("attendance-records.jsp");
    }

    private void saveAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            String classId = request.getParameter("classId");
            String date = request.getParameter("date");
            String[] sids = request.getParameterValues("sid");
            String[] statuses = request.getParameterValues("status");

            if (classId == null || date == null || sids == null || statuses == null) {
                throw new Exception("Please fill all required fields");
            }

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Delete existing records for this date and class
            String deleteSQL = "DELETE FROM attendance_records WHERE class_id = ? AND date = ?";
            pstmt = conn.prepareStatement(deleteSQL);
            pstmt.setInt(1, Integer.parseInt(classId));
            pstmt.setDate(2, Date.valueOf(date));
            pstmt.executeUpdate();
            pstmt.close();

            // Insert new records
            String insertSQL = "INSERT INTO attendance_records (student_id, class_id, date, status) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL);

            for (int i = 0; i < sids.length; i++) {
                if (sids[i] != null && !sids[i].trim().isEmpty() && 
                    statuses[i] != null && !statuses[i].trim().isEmpty()) {
                    pstmt.setInt(1, Integer.parseInt(sids[i]));
                    pstmt.setInt(2, Integer.parseInt(classId));
                    pstmt.setDate(3, Date.valueOf(date));
                    pstmt.setString(4, statuses[i].toUpperCase());
                    pstmt.executeUpdate();
                }
            }

            conn.commit();
            request.getSession().setAttribute("success", "Attendance saved successfully!");

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            request.getSession().setAttribute("error", e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("attendance-records.jsp");
    }
}
