package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.model.Student;
import com.util.DBConnection;

@WebServlet("/ViewAllStudentsServlet")
public class ViewAllStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }

            String sql = "SELECT * FROM students ORDER BY sid";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Student student = new Student();
                student.setSid(rs.getInt("sid"));
                student.setName(rs.getString("name"));
                student.setAge(rs.getInt("age"));
                student.setEmail(rs.getString("email")); // Corrected this line
                students.add(student);
            }

            request.setAttribute("students", students);
            request.getRequestDispatcher("/view-all-students.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error retrieving students: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
