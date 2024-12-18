package Controller;

import com.util.DBConnection;
import com.model.Student;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/searchStudent")
public class SearchStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userType") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String query = request.getParameter("query");
        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Database connection failed");
            }

            String sql;
            if (query != null && !query.trim().isEmpty()) {
                // Search with query
                sql = "SELECT * FROM students WHERE LOWER(name) LIKE ? OR CAST(sid AS CHAR) LIKE ? OR LOWER(email) LIKE ?";
                stmt = conn.prepareStatement(sql);
                String searchPattern = "%" + query.toLowerCase() + "%";
                stmt.setString(1, searchPattern);
                stmt.setString(2, searchPattern);
                stmt.setString(3, searchPattern);
            } else {
                // Show all students
                sql = "SELECT * FROM students";
                stmt = conn.prepareStatement(sql);
            }
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setSid(rs.getInt("sid"));
                student.setName(rs.getString("name"));
                student.setAge(rs.getInt("age"));
                student.setEmail(rs.getString("email"));
                students.add(student);
            }
            
            request.setAttribute("students", students);
            request.setAttribute("query", query); // Send back the query for form persistence
            request.getRequestDispatcher("/search-student.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("Database error in SearchStudentServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to search students. Please try again later.");
            request.getRequestDispatcher("/search-student.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
