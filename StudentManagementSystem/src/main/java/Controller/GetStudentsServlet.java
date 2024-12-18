package Controller;

import java.io.IOException;
import java.sql.*;
import com.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetStudentsServlet")
public class GetStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        String classId = request.getParameter("classId");
        
        if (classId == null || classId.trim().isEmpty()) {
            response.getWriter().write("");
            return;
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                "SELECT sid, name FROM students WHERE class_id = ? ORDER BY name")) {
            
            pstmt.setInt(1, Integer.parseInt(classId));
            StringBuilder html = new StringBuilder();
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    html.append("<tr>")
                        .append("<td>").append(rs.getInt("sid")).append("</td>")
                        .append("<td>").append(rs.getString("name")).append("</td>")
                        .append("<td>")
                        .append("<input type='hidden' name='sid' value='").append(rs.getInt("sid")).append("'>")
                        .append("<select name='status' class='form-control' required>")
                        .append("<option value=''>Select</option>")
                        .append("<option value='PRESENT'>Present</option>")
                        .append("<option value='ABSENT'>Absent</option>")
                        .append("</select>")
                        .append("</td>")
                        .append("</tr>");
                }
            }
            
            response.getWriter().write(html.toString());
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("<tr><td colspan='3'>Error loading students</td></tr>");
        }
    }
}
