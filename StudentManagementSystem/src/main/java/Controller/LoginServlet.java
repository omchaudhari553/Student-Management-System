package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        System.out.println("LoginServlet: doPost method called"); // Debug log
        
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Check for admin credentials first
            if ("admin".equals(userType) && "admin".equals(username) && "admin123".equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userType", "admin");
                response.sendRedirect("admin-dashboard.jsp");
                return;
            }
            
            // For regular users, check database
            conn = DBConnection.getConnection();
            System.out.println("Database connection status: " + (conn != null ? "Connected" : "Failed")); // Debug log
            
            if (conn == null) {
                throw new SQLException("Database connection failed");
            }
            
            String sql = "SELECT * FROM user WHERE uname = ? AND upwd = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            System.out.println("Executing SQL query: " + sql); // Debug log
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("Login successful for user: " + username); // Debug log
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userType", "user");
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("fullname", rs.getString("fullname")); 
                response.sendRedirect("dashboard.jsp");
            } else {
                System.out.println("Login failed for user: " + username); // Debug log
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage()); // Debug log
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
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
        response.sendRedirect("login.jsp");
    }
}
