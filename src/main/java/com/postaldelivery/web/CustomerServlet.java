package com.postaldelivery.web;

import java.io.IOException;
import java.util.List;

import com.postaldelivery.dao.CustomerDAO;
import com.postaldelivery.dao.PostCardDAO;
import com.postaldelivery.dao.PostOfficeDAO;
import com.postaldelivery.model.core.Customer;
import com.postaldelivery.model.core.PostCard;
import com.postaldelivery.model.core.PostOffice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {
	private CustomerDAO customerDAO;
	private PostOfficeDAO postOfficeDAO;
	private PostCardDAO postCardDAO;

	public void init() {
		customerDAO = new CustomerDAO();
		postOfficeDAO = new PostOfficeDAO();
		postCardDAO = new PostCardDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("register")) {
			registerCustomer(request, response);
		} else if (action.equals("login")) {
			loginCustomer(request, response);
		} else if (action.equals("sendPostCard")) {
			sendPostCard(request, response);
		} else if (action.equals("trackPostCard")) {
			trackPostCard(request, response);
		} else if (action.equals("viewReceivedPosts")) {
			viewReceivedPosts(request, response);
		}
	}

	private void registerCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("name");
		String aadhar = request.getParameter("aadharnumber");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String password = request.getParameter("password");
		PostOffice postOffice = postOfficeDAO.getPostOfficeOfACity(city);
		if (postOffice == null) {
			response.sendRedirect("customer-registration.jsp?msg=invalid%20city");
			return;
		} else {
			Customer customer = new Customer(name, aadhar, address, postOffice.getCityId(), password);
			boolean f = customerDAO.registerCustomer(customer);
			if (f) {
				response.sendRedirect("customer-login.jsp?success=Registration%20Successful");
			} else {
				response.sendRedirect("customer-registration.jsp?error=Something%20went%20wrong!");
			}

		}
	}

	private void loginCustomer(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String aadharNumber = request.getParameter("aadharNumber");
		String password = request.getParameter("password");

		Customer customer = customerDAO.loginCustomer(aadharNumber, password);
		if (customer != null) {
			HttpSession session = request.getSession();
			session.setAttribute("customer", customer);
			response.sendRedirect("customer-dashboard.jsp");
		} else {
			response.sendRedirect("customer-login.jsp?error=Invalid%20Aadhar%20Number");
		}
	}

	private void sendPostCard(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Customer sender = (Customer) session.getAttribute("customer");
		String receiverName = request.getParameter("receiverName");
		String receiverAddress = request.getParameter("receiverAddress");
		String receiverCity = request.getParameter("receiverCity");
		String message = request.getParameter("message");

		if (receiverAddress == null || receiverAddress.isEmpty()) {
			response.sendRedirect("customer-dashboard.jsp?error=Receiver%20Address%20is%20empty");
			return;
		}

		PostCard postCard = new PostCard(sender.getId(), sender.getName(), sender.getAddress(), sender.getCity(),
				receiverName, receiverAddress, receiverCity, message);
		int postcardId = postCardDAO.sendPostcard(postCard);
	    response.sendRedirect("customer-dashboard.jsp?success=Postcard%20Sent%20Successfully%20%5BPostcardId%3A%20" + postcardId + "%5D");
	}

	private void trackPostCard(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String postCardId = request.getParameter("postCardId");

		if (postCardId == null || postCardId.isEmpty()) {
			response.sendRedirect("postcard-status.jsp?error=Invalid%20Postcard%20ID");
			return;
		}

		int id;
		try {
			id = Integer.parseInt(postCardId);
		} catch (NumberFormatException e) {
			response.sendRedirect("postcard-status.jsp?error=Invalid%20Postcard%20ID");
			return;
		}

		PostCardDAO postcardDAO = new PostCardDAO();
		PostCard postcard = postCardDAO.getPostcardById(id);

		if (postcard == null) {
			response.sendRedirect("postcard-status.jsp?error=Postcard%20Not%20Found");
			return;
		}

		request.setAttribute("postcard", postcard);

		try {
			request.getRequestDispatcher("postcard-status.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	private void viewReceivedPosts(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("customer"); // Get logged-in customer

		List<PostCard> receivedPosts = postCardDAO.getReceivedPostcardsForCustomer(customer.getId());
		request.setAttribute("receivedPosts", receivedPosts);
		request.getRequestDispatcher("customer-received-posts.jsp").forward(request, response);
	}

}
