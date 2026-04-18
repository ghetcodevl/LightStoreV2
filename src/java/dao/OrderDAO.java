package dao;

import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import model.Product;

public class OrderDAO {
    
    public boolean createOrder(int userId, Map<Integer, Integer> cart, String fullName, 
                                String phone, String address, String note) 
            throws ClassNotFoundException, SQLException {
        
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            ProductDAO productDAO = new ProductDAO();
            double total = 0;
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productDAO.getById(entry.getKey());
                if (product != null) {
                    total += product.getPrice() * entry.getValue();
                }
            }
            
            String sqlOrder = "INSERT INTO orders (user_id, total, name, phone, address, note, status, created_at) VALUES (?, ?, ?, ?, ?, ?, 'pending', NOW())";
            psOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, total);
            psOrder.setString(3, fullName);
            psOrder.setString(4, phone);
            psOrder.setString(5, address);
            psOrder.setString(6, note);
            
            psOrder.executeUpdate();
            
            rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            
            String sqlItem = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            psItem = conn.prepareStatement(sqlItem);
            
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();
                Product product = productDAO.getById(productId);
                
                psItem.setInt(1, orderId);
                psItem.setInt(2, productId);
                psItem.setInt(3, quantity);
                psItem.setDouble(4, product.getPrice());
                psItem.addBatch();
            }
            
            psItem.executeBatch();
            conn.commit();
            return true;
            
        } catch (Exception e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (psItem != null) psItem.close();
            if (psOrder != null) psOrder.close();
            if (conn != null) conn.close();
        }
    }
}