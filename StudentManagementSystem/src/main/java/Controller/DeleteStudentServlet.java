package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Connection conn = DBConnection.getConnection();
                String sql = "DELETE FROM students WHERE sid = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, id);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    session.setAttribute("success", "Student deleted successfully!");
                } else {
                    session.setAttribute("error", "No student found with ID " + id);
                }

            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "Database error: " + e.getMessage());
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid student ID format");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error deleting student: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "Student ID is required");
        }

        response.sendRedirect("ViewAllStudentsServlet");
    }

    // Redirect GET requests to the student list page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("ViewAllStudentsServlet");
    }
}
