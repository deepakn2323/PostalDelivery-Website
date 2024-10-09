
package com.postaldelivery.web;

import com.postaldelivery.dao.PostOfficeDAO;
import com.postaldelivery.model.core.Admin;
import com.postaldelivery.model.core.PostOffice;
import com.postaldelivery.dao.AdminDAO;  // Import AdminDAO for admin authentication

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private PostOfficeDAO postOfficeDAO;
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        postOfficeDAO = new PostOfficeDAO();
        adminDAO = new AdminDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "login":
                loginAdmin(request, response);
                break;
            default:
                response.sendRedirect("admin-login.jsp?error=Invalid%20Action");
                break;
        }
    }

    private void loginAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name");
        String password = request.getParameter("password");

        Admin admin = adminDAO.authenticateAdmin(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);  // Store admin in session
            List<PostOffice> postOffice = postOfficeDAO.getAllPostOffices();
            session.setAttribute("postOffices",postOffice);
            response.sendRedirect("admin-dashboard.jsp");  // Redirect to admin dashboard
        } else {
            response.sendRedirect("admin-login.jsp?error=Invalid%20Credentials");
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
