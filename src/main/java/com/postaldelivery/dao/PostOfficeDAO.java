package com.postaldelivery.dao;

import com.postaldelivery.db.DatabaseUtil;
import com.postaldelivery.model.core.PostCard;
import com.postaldelivery.model.core.PostOffice;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostOfficeDAO {
    private Connection connection;

    public PostOfficeDAO() {
        connection = DatabaseUtil.getConnection(); // Get connection from DatabaseUtil
    }

    // Method to add a new post office to the database and assign a postman
    public boolean addPostOffice(String city) {
    	boolean added = false;;
        String query = "INSERT INTO cities (city_name) VALUES (?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, city); // Set the city parameter
            ps.executeUpdate();
            added = true;// Execute the update
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }
        return added;
    }

    // Method to retrieve all post offices from the database
    public List<PostOffice> getAllPostOffices() {
        List<PostOffice> postOffices = new ArrayList<>();
        String query = "SELECT p.id, p.city_id, c.city_name\r\n"
        		+ "FROM post_offices p\r\n"
        		+ "JOIN cities c ON p.city_id = c.id;"; // SQL query to select all post offices
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Create a new PostOffice object for each row in the result set
                PostOffice postOffice = new PostOffice(rs.getInt("id"),rs.getInt("city_id"), rs.getString("city_name"));
                postOffices.add(postOffice); // Add the post office to the list
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }
        return postOffices; // Return the list of post offices
    }

    // Method to remove a post office from the database by city
    public void removePostOffice(String city) {
        String query = "DELETE FROM cities WHERE city_name = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, city); // Set the city parameter
            int rowsAffected = ps.executeUpdate(); // Execute the update
            if (rowsAffected > 0) {
                System.out.println("Post office removed successfully."); // Success message
            } else {
                System.out.println("No post office found for the specified city."); // Inform if no rows were deleted
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }
    }
    public PostOffice getPostOfficeOfACity(String city) {
    	String query = "SELECT * FROM post_offices p " +
                "JOIN cities c ON p.city_id = c.id " +
                "WHERE c.city_name = ?";
        PostOffice postOffice = null;
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, city);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                postOffice = new PostOffice(rs.getInt("id"),rs.getInt("city_id"), rs.getString("city_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postOffice;
    }
    
    public int getPostOfficeIdOfAPostOffice(String cityName) {
        String query = "SELECT id FROM post_offices WHERE city_id = (SELECT id FROM cities WHERE city_name = ?)";
        int postOfficeId = -1; // Default to -1 if not found

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, cityName);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                postOfficeId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return postOfficeId; // Return the found post office ID or -1 if not found
    }

   

	
}
