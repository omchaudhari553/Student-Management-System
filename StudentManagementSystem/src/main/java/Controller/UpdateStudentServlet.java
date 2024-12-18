// UpdateStudentServlet.java
package Controller;

import com.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Get parameters
            int sid = Integer.parseInt(request.getParameter("sid"));
            String name = request.getParameter("name");
            int age = Integer.parseInt(request.getParameter("age"));
            String email = request.getParameter("email");

            // Validate input
            if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                session.setAttribute("message", "Failed: All fields are required");
                session.setAttribute("messageType", "error");
                response.sendRedirect("update-student.jsp");
                return;
            }

            // Database operations
            try (Connection conn = DBConnection.getConnection()) {
                if (conn == null) {
                    throw new SQLException("Database connection failed");
                }

                String sql = "UPDATE students SET name = ?, age = ?, email = ? WHERE sid = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, name);
                    stmt.setInt(2, age);
                    stmt.setString(3, email);
                    stmt.setInt(4, sid);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        session.setAttribute("message", "Student data successfully updated!");
                        session.setAttribute("messageType", "success");
                    } else {
                        session.setAttribute("message", "Failed: Unable to update student data");
                        session.setAttribute("messageType", "error");
                    }
                    response.sendRedirect("update-student.jsp");
                }
            } catch (SQLException e) {
                session.setAttribute("message", "Failed: Database error - " + e.getMessage());
                session.setAttribute("messageType", "error");
                response.sendRedirect("update-student.jsp");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Failed: Invalid ID or age format");
            session.setAttribute("messageType", "error");
            response.sendRedirect("update-student.jsp");
        } catch (Exception e) {
            session.setAttribute("message", "Failed: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect("update-student.jsp");
        }
    }
}
