package com.postaldelivery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.postaldelivery.db.DatabaseUtil;
import com.postaldelivery.model.core.Admin;

public class AdminDAO {
    private Connection connection;

    public AdminDAO() {
        connection = DatabaseUtil.getConnection();
    }

    public Admin authenticateAdmin(String name, String password) {
        String query = "SELECT * FROM admins WHERE name = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Admin(rs.getString("name"), rs.getString("password"));
            }	
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
