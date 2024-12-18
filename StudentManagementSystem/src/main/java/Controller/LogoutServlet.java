package Controller;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String username = null;
        
        if (session != null) {
            // Get username before invalidating session
            username = (String) session.getAttribute("username");
            // Invalidate the session
            session.invalidate();
        }
        
        // Redirect with username and logout message
        if (username != null && !username.trim().isEmpty()) {
            String encodedUsername = URLEncoder.encode(username, "UTF-8");
            response.sendRedirect("login.jsp?message=logout_success&username=" + encodedUsername);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
