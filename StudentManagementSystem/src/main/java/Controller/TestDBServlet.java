package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.util.DBConnection;

@WebServlet("/testDB")
public class TestDBServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                response.getWriter().println("Database connection successful!<br>");
                
                // Test students table
                String sql = "SELECT COUNT(*) as count FROM students";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        int count = rs.getInt("count");
                        response.getWriter().println("Number of students in database: " + count);
                    }
                }
            } else {
                response.getWriter().println("Failed to connect to database!");
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
