package com.postaldelivery.web;

import java.io.IOException;
import java.util.List;

import com.postaldelivery.dao.CustomerDAO;
import com.postaldelivery.dao.PostCardDAO;
import com.postaldelivery.dao.PostManDAO;
import com.postaldelivery.model.core.Customer;
import com.postaldelivery.model.core.PostCard;
import com.postaldelivery.model.core.PostMan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/postman")
public class PostManServlet extends HttpServlet {
    private PostManDAO postManDAO;
    private CustomerDAO customerDAO;
    private PostCardDAO postCardDAO;

    public void init() {
        postManDAO = new PostManDAO();
        customerDAO = new CustomerDAO();
        postCardDAO = new PostCardDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("login")) {
            authenticatePostMan(request, response);
        } else if (action.equals("deliverPostcard")) {
            deliverPostCard(request, response);
        }
    }

    private void authenticatePostMan(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        PostMan postMan = postManDAO.authenticatePostMan(name, password);
        if (postMan != null) {
            HttpSession session = request.getSession();
            session.setAttribute("postman", postMan);
            List<PostCard> undeliveredPostcards = postCardDAO.getUndeliveredPostcardsForPostOffice(postMan.getPostOfficeId());
            session.setAttribute("postcards", undeliveredPostcards);
            response.sendRedirect("postman-dashboard.jsp");
        } else {
            response.sendRedirect("postman-login.jsp?error=Invalid%20Credentials");
        }
    }

    protected void deliverPostCard(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int postCardId = Integer.parseInt(request.getParameter("postCardId"));

        PostCard postcard = postCardDAO.getPostcardById(postCardId);
        
        Customer receiver = customerDAO.getCustomerByNameAndAddress(postcard.getReceiverName(), postcard.getReceiverAddress());

        if (receiver != null) {
            postCardDAO.deliverPostcardToCustomer(postCardId, receiver.getId());
        }
        HttpSession session = request.getSession();
        PostMan postman = (PostMan) session.getAttribute("postman");
        List<PostCard> undeliveredPostcards = postCardDAO.getUndeliveredPostcardsForPostOffice(postman.getPostOfficeId());
        session.setAttribute("postcards", undeliveredPostcards);

        response.sendRedirect("postman-dashboard.jsp");
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("postman-dashboard.jsp");
    }
}
