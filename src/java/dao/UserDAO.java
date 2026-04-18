/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;
import utils.DBConnection;

/**
 *
 * @author admin
 */
public class UserDAO {
    /*Đăng ký*/
      public static boolean ins(User u) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO users (full_name, email, password, role, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole());
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getAddress());
            
            return ps.executeUpdate() > 0;
        }
      }
    /*Login*/
    public static User checkLogin(String email, String pass) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRole(rs.getString("role"));
                    u.setPhone(rs.getString("phone"));
                    u.setAddress(rs.getString("address"));
                    return u;
                }
            }
        }
        return null;
    }
    /*tìm user theo email*/
    public User getUserByEmail(String email) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRole(rs.getString("role"));
                    u.setFullName(rs.getString("full_name"));
                    u.setPhone(rs.getString("phone"));
                    u.setAddress(rs.getString("address"));
                    return u;
                }
            }
        }
        return null;
    }

    
    /*Lấy tất cả user */
     public static List<User> getAll() throws ClassNotFoundException, SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(
                    rs.getInt("id"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("phone"),
                    rs.getString("address")));
            }
        }
        return list;
    }
    
    
    public boolean updatePassword(User u) throws ClassNotFoundException, SQLException {
        if (u == null || u.getEmail() == null || u.getPassword() == null) {
            return false;
        }
        
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getPassword());
            ps.setString(2, u.getEmail());
            
            return ps.executeUpdate() > 0;
        }
    
       
}
 public boolean updateUser(User u) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ? WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getPhone());
            ps.setString(3, u.getAddress());
            ps.setString(4, u.getEmail());
            
            return ps.executeUpdate() > 0;
        }
    }
}