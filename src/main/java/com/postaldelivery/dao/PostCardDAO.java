package com.postaldelivery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.postaldelivery.db.DatabaseUtil;
import com.postaldelivery.model.core.PostCard;

public class PostCardDAO {
	private Connection connection;
	private PostOfficeDAO postOfficeDAO;

	public PostCardDAO() {
		connection = DatabaseUtil.getConnection();
		postOfficeDAO = new PostOfficeDAO();
	}

	public List<PostCard> getUndeliveredPostcardsForPostOffice(int postOfficeId) {
		List<PostCard> postcards = new ArrayList<>();
		String query = "SELECT pc.*, " + "s.name AS sender_name, " + "s.aadhar_number AS sender_aadhar, "
				+ "s.address AS sender_address, " + "sc.city_name AS sender_city, " + "r.name AS receiver_name, "
				+ "r.aadhar_number AS receiver_aadhar, " + "r.address AS receiver_address, "
				+ "rc.city_name AS receiver_city " + "FROM postcards pc " + "JOIN customers s ON pc.sender_id = s.id "
				+ "JOIN cities sc ON s.city_id = sc.id " + "JOIN customers r ON pc.receiver_id = r.id "
				+ "JOIN cities rc ON r.city_id = rc.id " + "WHERE pc.post_office_id = ? "
				+ "AND pc.status = 'Not Delivered'";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, postOfficeId); 
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				PostCard postcard = new PostCard(rs.getInt("id"), rs.getInt("sender_id"), rs.getString("sender_name"),
						rs.getString("sender_address"), rs.getString("sender_city"), rs.getString("receiver_name"),
						rs.getString("receiver_address"), rs.getString("receiver_city"), rs.getString("status"));
				postcards.add(postcard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return postcards;
	}

	public void deliverPostcardToCustomer(int postcardId, int customerId) {
		String query = "UPDATE postcards SET status = 'Delivered', delivered_to_customer_id = ? WHERE id = ?";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, customerId); 
			ps.setInt(2, postcardId); 
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<PostCard> getReceivedPostcardsForCustomer(int customerId) {
		List<PostCard> postcards = new ArrayList<>();
		String query = "SELECT pc.*, "
				+ "s.name AS sender_name, s.address AS sender_address, sc.city_name AS sender_city, "
				+ "r.name AS receiver_name, r.address AS receiver_address, rc.city_name AS receiver_city "
				+ "FROM postcards pc " + "JOIN customers s ON pc.sender_id = s.id "
				+ "JOIN customers r ON pc.receiver_id = r.id " + "JOIN cities sc ON s.city_id = sc.id "
				+ "JOIN cities rc ON r.city_id = rc.id "
				+ "WHERE pc.delivered_to_customer_id = ? AND pc.status = 'Delivered'";

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, customerId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				PostCard postcard = new PostCard(rs.getInt("pc.id"), rs.getString("sender_name"),
						rs.getString("sender_address"), rs.getString("sender_city"), rs.getString("receiver_name"),
						rs.getString("receiver_address"), rs.getString("receiver_city"), rs.getString("pc.message"),
						rs.getString("pc.status"));
				postcards.add(postcard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return postcards;
	}

	public int sendPostcard(PostCard postCard) {
		String query = "INSERT INTO postcards (sender_id, receiver_id, message, status, post_office_id) "
				+ "VALUES (?, ?, ?, ?, ?)";

		int postOfficeId = postOfficeDAO.getPostOfficeIdOfAPostOffice(postCard.getReceiverCity());
		int senderId = 0;
		int receiverId = 0;
		if (postOfficeId != 0) {
			senderId = getCustomerIdByName(postCard.getSenderName()); 
			receiverId = getCustomerIdByName(postCard.getReceiverName()); 
		}

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, senderId);
			ps.setInt(2, receiverId); 
			ps.setString(3, postCard.getMessage());
			ps.setString(4, postCard.getStatus());
			ps.setInt(5, postOfficeId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return postCard.getId();
	}

	private int getCustomerIdByName(String customerName) {
		String query = "SELECT id FROM customers WHERE name = ?";
		int customerId = -1;

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setString(1, customerName);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				customerId = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customerId; 
	}

	public PostCard getPostcardById(int id) {
		String query = "SELECT pc.*, "
				+ "s.name AS sender_name, s.address AS sender_address, sc.city_name AS sender_city, "
				+ "r.name AS receiver_name, r.address AS receiver_address, rc.city_name AS receiver_city "
				+ "FROM postcards pc " + "JOIN customers s ON pc.sender_id = s.id "
				+ "JOIN customers r ON pc.receiver_id = r.id " + "JOIN cities sc ON s.city_id = sc.id "
				+ "JOIN cities rc ON r.city_id = rc.id " + "WHERE pc.id = ?";
		PostCard postCard = null;

		try (PreparedStatement ps = connection.prepareStatement(query)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				postCard = new PostCard(rs.getInt("pc.id"), rs.getString("sender_name"), rs.getString("sender_address"),
						rs.getString("sender_city"), rs.getString("receiver_name"), rs.getString("receiver_address"),
						rs.getString("receiver_city"), rs.getString("pc.message"), rs.getString("pc.status"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return postCard;
	}


}
