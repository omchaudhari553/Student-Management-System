package Controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Add your admin authentication logic here
        // This is a simple example - you should implement proper authentication
        if (username != null && password != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userType", "admin");
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
