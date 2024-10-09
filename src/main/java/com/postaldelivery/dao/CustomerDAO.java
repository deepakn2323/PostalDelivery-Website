package com.postaldelivery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.postaldelivery.db.DatabaseUtil;
import com.postaldelivery.model.core.Customer;

public class CustomerDAO {
    private Connection connection;

    public CustomerDAO() {
        connection = DatabaseUtil.getConnection();
    }

    public boolean registerCustomer(Customer customer) {
    	boolean success = false;
        String query = "INSERT INTO customers (name, aadhar_number, address, city_id, password) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAadharNumber());
            ps.setString(3, customer.getAddress());
            ps.setInt(4, customer.getCityId());
            ps.setString(5, customer.getPassword());
            System.out.println(1);
            ps.executeUpdate();
            success = true;
            System.out.println(2);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public Customer loginCustomer(String aadharNumber, String password) {
    	String query = "SELECT c.*, ct.city_name " +
                "FROM customers c " +
                "JOIN cities ct ON c.city_id = ct.id " +
                "WHERE c.aadhar_number = ? AND c.password = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, aadharNumber);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
            	return new Customer(
            			rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("aadhar_number"),
                        rs.getString("address"),
                        rs.getString("city_name"),
                        rs.getString("password")
                    );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; 
    }
    
    public Customer getCustomerByNameAndAddress(String name, String address) {
    	String query = "SELECT c.*, ct.city_name " +
                "FROM customers c " +
                "JOIN cities ct ON c.city_id = ct.id " +
                "WHERE c.name = ? AND c.address = ?";
        Customer customer = null;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, name);  
            ps.setString(2, address); 
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer(
                    rs.getInt("id"),               
                    rs.getString("name"),         
                    rs.getString("aadhar_number"), 
                    rs.getString("address"),  
                    rs.getString("city_name"),
                    rs.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customer;
    }

}
