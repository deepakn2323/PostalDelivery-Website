package com.postaldelivery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.postaldelivery.db.DatabaseUtil;
import com.postaldelivery.model.core.PostCard;
import com.postaldelivery.model.core.PostMan;

public class PostManDAO {
    private Connection connection;
    private PostOfficeDAO postOfficeDAO;
    private PostCardDAO postCardDAO;

    public PostManDAO() {
        connection = DatabaseUtil.getConnection();
        postOfficeDAO = new PostOfficeDAO();
        postCardDAO = new PostCardDAO();
    }
    
    public void assignPostManToCity(String city) {
        String query = "INSERT INTO postmen (name, city, password, post_office_id) VALUES (?, ?, ?, ?)";
        String postManName = "Postman " + city; 
        int post_office_id = postOfficeDAO.getPostOfficeIdOfAPostOffice(city);
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, postManName); 
            ps.setString(2, city); 
            ps.setString(3, "postman123"); 
            ps.setInt(4, post_office_id); 
            ps.executeUpdate(); 
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
    }

    
    public PostMan authenticatePostMan(String name, String password) {
    	String query = "SELECT pm.*, c.city_name \r\n"
    			+ "FROM postmen pm \r\n"
    			+ "JOIN post_offices po ON pm.post_office_id = po.id \r\n"
    			+ "JOIN cities c ON po.city_id = c.id \r\n"
    			+ "WHERE pm.name = ? AND pm.password = ?;\r\n"
    			+ "";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, password);
            System.out.println(1);
            ResultSet rs = ps.executeQuery();
            System.out.println(2);
            if (rs.next()) {
                return new PostMan(rs.getInt("id"), rs.getString("name"), rs.getString("city_name"), rs.getString("password"), rs.getInt("post_office_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PostCard> getPostCardsForPostManCity(String city) {
        int post_office_id = postOfficeDAO.getPostOfficeIdOfAPostOffice(city);
        List<PostCard> postCards = postCardDAO.getUndeliveredPostcardsForPostOffice(post_office_id);
        return postCards;
    }
   
}
