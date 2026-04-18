/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.DBConnection;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.Product;

/**
 *
 * @author lttru
 */
public class ProductDAO {

    public static List<Product> getAll() throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price")));
                        
            }
        }
        return list;
    }
    // Lấy sản phẩm theo ID

    public Product getById(int id) throws ClassNotFoundException, SQLException {
         String sql = "SELECT p.*, c.name as category_name FROM products p " +
                 "LEFT JOIN categories c ON p.category_id = c.id " +
                 "WHERE p.id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("image"));
                product.setDescription(rs.getString("description"));
                product.setTag(rs.getString("tag"));
                product.setCategoryId(rs.getInt("category_id"));
                return product;
            }
        }
    }
    return null;
    }

// Lấy sản phẩm theo category
    public List<Product> getByCategory(int categoryId) throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price")));
                }
            }
        }
        return list;
    }

// Lấy sản phẩm theo tag
    public List<Product> getByTag(String tag) throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE tag = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tag);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setTag(rs.getString("tag"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    
}
