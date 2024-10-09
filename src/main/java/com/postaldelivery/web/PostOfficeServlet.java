package com.postaldelivery.web;

import java.io.IOException;
import java.util.List;

import com.postaldelivery.dao.PostManDAO;
import com.postaldelivery.dao.PostOfficeDAO;
import com.postaldelivery.model.core.PostOffice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/postoffice")
public class PostOfficeServlet extends HttpServlet {
    private PostOfficeDAO postOfficeDAO;
    private PostManDAO postManDAO;

    public void init() {
        postOfficeDAO = new PostOfficeDAO(); 
        postManDAO = new PostManDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "addPostOffice":
                String city = request.getParameter("city");
                if(postOfficeDAO.addPostOffice(city)) {
                HttpSession session = request.getSession();
                List<PostOffice> postOffice = postOfficeDAO.getAllPostOffices();
                session.setAttribute("postOffices",postOffice);
                response.sendRedirect("admin-dashboard.jsp?success=Post%20Office%20Added%20and%20Postman%20Assigned");
                }
                else {
                	response.sendRedirect("admin-dashboard.jsp?failure=Post%20Office%20already%20exists");
                }
                break;
            case "removePostOffice":
                city = request.getParameter("city");
                postOfficeDAO.removePostOffice(city); 
                HttpSession session = request.getSession();
                List<PostOffice> postOffice = postOfficeDAO.getAllPostOffices();
                session.setAttribute("postOffices",postOffice);
                response.sendRedirect("admin-dashboard.jsp?success=Post%20Office%20Removed");
                break;
            default:
                response.sendRedirect("admin-dashboard.jsp?error=Invalid%20Action");
        }
    }
}
