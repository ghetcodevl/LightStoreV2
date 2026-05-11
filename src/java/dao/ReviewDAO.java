package dao;

import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Review;

public class ReviewDAO {
    
    // Lấy danh sách đánh giá theo product_id
    public List<Review> getReviewsByProduct(int productId, int limit, int offset) 
            throws ClassNotFoundException, SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE product_id = ? AND status = 1 ORDER BY created_at DESC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUserName(rs.getString("user_name"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("created_at"));
                    review.setStatus(rs.getInt("status"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }
    
    // Đếm tổng số đánh giá của sản phẩm
    public int countReviewsByProduct(int productId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM reviews WHERE product_id = ? AND status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }
    
    // Tính rating trung bình
    public double getAverageRating(int productId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT AVG(rating) FROM reviews WHERE product_id = ? AND status = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        }
        return 0;
    }
    
    // Thêm đánh giá mới
    public boolean addReview(Review review) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO reviews (product_id, user_id, user_name, rating, comment) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getUserId());
            ps.setString(3, review.getUserName());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getComment());
            return ps.executeUpdate() > 0;
        }
    }
}