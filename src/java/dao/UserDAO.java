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

    /* Đăng ký user mới */
    public static boolean ins(User u) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO users (full_name, email, password, role, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole());
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getAddress());
            return ps.executeUpdate() > 0;
        }
    }

    /* Kiểm tra đăng nhập (lấy user theo email) */
    public static User checkLogin(String email, String pass) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    /* Tìm user theo email */
    public User getUserByEmail(String email) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    /* Lấy tất cả user (không phân biệt role) */
    public static List<User> getAll() throws ClassNotFoundException, SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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

    /* Lấy tất cả user (chỉ user thường, không lấy admin) */
    public static List<User> getAllCustomers() throws ClassNotFoundException, SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'user' ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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

    /* Cập nhật mật khẩu */
    public boolean updatePassword(User u) throws ClassNotFoundException, SQLException {
        if (u == null || u.getEmail() == null || u.getPassword() == null) {
            return false;
        }
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getPassword());
            ps.setString(2, u.getEmail());
            return ps.executeUpdate() > 0;
        }
    }

    /* Cập nhật thông tin user */
    public boolean updateUser(User u) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ? WHERE email = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getPhone());
            ps.setString(3, u.getAddress());
            ps.setString(4, u.getEmail());
            return ps.executeUpdate() > 0;
        }
    }

    /* Đếm tổng số user (không tính admin) */
    public int countAll() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'user'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    /* Đếm tổng số user (tất cả) */
    public int countAllUsers() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Xóa user theo ID (xóa cả đơn hàng liên quan)
public boolean deleteUser(int userId) throws ClassNotFoundException, SQLException {
    Connection conn = null;
    PreparedStatement psCheck = null;
    PreparedStatement psDeleteOrders = null;
    PreparedStatement psDeleteItems = null;
    PreparedStatement psDeleteUser = null;
    ResultSet rs = null;
    
    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // Bắt đầu transaction
        
        // Kiểm tra user có tồn tại và không phải admin
        String checkSql = "SELECT role FROM users WHERE id = ?";
        psCheck = conn.prepareStatement(checkSql);
        psCheck.setInt(1, userId);
        rs = psCheck.executeQuery();
        
        if (rs.next()) {
            String role = rs.getString("role");
            if ("admin".equals(role)) {
                return false; // Không xóa được admin
            }
        } else {
            return false; // Không tìm thấy user
        }
        
        // 1. Xóa order_items (chi tiết đơn hàng) trước
        String deleteItemsSql = "DELETE oi FROM order_items oi " +
                                "INNER JOIN orders o ON oi.order_id = o.id " +
                                "WHERE o.user_id = ?";
        psDeleteItems = conn.prepareStatement(deleteItemsSql);
        psDeleteItems.setInt(1, userId);
        psDeleteItems.executeUpdate();
        
        // 2. Xóa orders (đơn hàng)
        String deleteOrdersSql = "DELETE FROM orders WHERE user_id = ?";
        psDeleteOrders = conn.prepareStatement(deleteOrdersSql);
        psDeleteOrders.setInt(1, userId);
        psDeleteOrders.executeUpdate();
        
        // 3. Xóa user
        String deleteUserSql = "DELETE FROM users WHERE id = ? AND role = 'user'";
        psDeleteUser = conn.prepareStatement(deleteUserSql);
        psDeleteUser.setInt(1, userId);
        int result = psDeleteUser.executeUpdate();
        
        conn.commit(); // Commit transaction
        return result > 0;
        
    } catch (SQLException e) {
        if (conn != null) {
            try { conn.rollback(); } catch (SQLException ex) {}
        }
        throw e;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (psCheck != null) try { psCheck.close(); } catch (SQLException e) {}
        if (psDeleteItems != null) try { psDeleteItems.close(); } catch (SQLException e) {}
        if (psDeleteOrders != null) try { psDeleteOrders.close(); } catch (SQLException e) {}
        if (psDeleteUser != null) try { psDeleteUser.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
}

    /* Tìm user theo ID */
    public User getUserById(int userId) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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
    // Lấy danh sách khách hàng có phân trang

    // Lấy danh sách khách hàng có phân trang
    public List<User> getCustomersPaginated(int page, int pageSize, String keyword)
            throws ClassNotFoundException, SQLException {
        List<User> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE role = 'user'");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (full_name LIKE ? OR email LIKE ? OR phone LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        sql.append(" ORDER BY id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setRole(rs.getString("role"));
                    u.setPhone(rs.getString("phone"));
                    u.setAddress(rs.getString("address"));
                    list.add(u);
                }
            }
        }
        return list;
    }

// Đếm số lượng khách hàng theo filter
    public int countCustomersFiltered(String keyword) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users WHERE role = 'user'");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (full_name LIKE ? OR email LIKE ? OR phone LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

}
