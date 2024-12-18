package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.util.DBConnection;

@WebServlet("/ManageClassesServlet")
public class ManageClassesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String className = request.getParameter("className");
        String section = request.getParameter("section");
        String subject = request.getParameter("subject");
        String action = request.getParameter("action");

        System.out.println("Received request to add class: " + className + ", " + section + ", " + subject); // Debug log

        try (Connection conn = DBConnection.getConnection()) {
            if ("add".equals(action)) {
                String sql = "INSERT INTO classes (class_name, section, subject) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, className);
                    stmt.setString(2, section);
                    stmt.setString(3, subject);
                    
                    int result = stmt.executeUpdate();
                    System.out.println("Insert result: " + result); // Debug log
                    
                    if (result > 0) {
                        response.sendRedirect("manage-classes.jsp?success=true");
                    } else {
                        response.sendRedirect("manage-classes.jsp?error=failed");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage()); // Debug log
            request.setAttribute("error", "Failed to add class: " + e.getMessage());
            request.getRequestDispatcher("manage-classes.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM classes";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                request.setAttribute("classes", rs);
                request.getRequestDispatcher("manage-classes.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch classes: " + e.getMessage());
            request.getRequestDispatcher("manage-classes.jsp").forward(request, response);
        }
    }
}
