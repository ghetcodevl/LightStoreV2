package dao;

import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactDAO {
    
    public boolean insertContact(String name, String email, String message) 
            throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, message);
            
            return ps.executeUpdate() > 0;
        }
    }
}