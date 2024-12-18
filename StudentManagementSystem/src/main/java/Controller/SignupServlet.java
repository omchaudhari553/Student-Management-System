package Controller;

import com.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("SignupServlet: doPost method called"); // Debug log
        
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        System.out.println("Received parameters:"); // Debug logs
        System.out.println("fullname: " + fullname);
        System.out.println("username: " + username);
        System.out.println("email: " + email);

        // Basic validation
        if (fullname == null || username == null || email == null || password == null || 
            fullname.trim().isEmpty() || username.trim().isEmpty() || 
            email.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Password confirmation check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            System.out.println("Database connection status: " + (conn != null ? "Connected" : "Failed")); // Debug log
            
            if (conn == null) {
                throw new SQLException("Database connection failed");
            }

            String sql = "INSERT INTO user (fullname, uname, email, upwd) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullname);
            stmt.setString(2, username);
            stmt.setString(3, email);
            stmt.setString(4, password);

            System.out.println("Executing SQL query: " + sql); // Debug log
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("User registered successfully: " + username); // Debug log
                response.sendRedirect(request.getContextPath() + "/login.jsp?message=signup_success&username=" + username);
            } else {
                System.out.println("Registration failed for user: " + username); // Debug log
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/signup.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage()); // Debug log
            e.printStackTrace();
            
            String errorMessage = e.getMessage().toLowerCase();
            if (errorMessage.contains("duplicate") || errorMessage.contains("unique")) {
                if (errorMessage.contains("email")) {
                    request.setAttribute("error", "Email already exists");
                } else if (errorMessage.contains("uname")) {
                    request.setAttribute("error", "Username already exists");
                } else {
                    request.setAttribute("error", "User already exists");
                }
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
            
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/signup.jsp");
    }
}
