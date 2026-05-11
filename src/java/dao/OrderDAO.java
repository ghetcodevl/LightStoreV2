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
import model.Order;
import model.OrderItem;
import model.Product;
import utils.DBConnection;

/**
 *
 * @author admin
 */
public class OrderDAO {

    // ==================== THỐNG KÊ ====================
    // Thống kê theo tuần (7 ngày gần nhất)
    public List<Object[]> getWeeklyStats() throws ClassNotFoundException, SQLException {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(created_at, '%a') as day, COUNT(*) as count, COALESCE(SUM(total), 0) as revenue "
                + "FROM orders "
                + "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY) "
                + "GROUP BY DATE(created_at) "
                + "ORDER BY created_at ASC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Object[] row = {rs.getString("day"), rs.getInt("count"), rs.getDouble("revenue")};
                stats.add(row);
            }
        }
        return stats;
    }
    // Lấy danh sách đơn hàng theo user_id

    public List<Order> getOrdersByUserId(int userId) throws ClassNotFoundException, SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, COALESCE(u.full_name, o.name) as customer_name FROM orders o "
                + "LEFT JOIN users u ON o.user_id = u.id WHERE o.user_id = ? "
                + "ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setNote(rs.getString("note"));
                    order.setTotal(rs.getDouble("total"));
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // Thống kê theo tháng (12 tháng gần nhất)
    public List<Object[]> getMonthlyStats() throws ClassNotFoundException, SQLException {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(created_at, '%M') as month, COUNT(*) as count, COALESCE(SUM(total), 0) as revenue "
                + "FROM orders "
                + "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 12 MONTH) "
                + "GROUP BY MONTH(created_at) "
                + "ORDER BY MONTH(created_at) ASC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Object[] row = {rs.getString("month"), rs.getInt("count"), rs.getDouble("revenue")};
                stats.add(row);
            }
        }
        return stats;
    }

    // Thống kê theo năm (5 năm gần nhất)
    public List<Object[]> getYearlyStats() throws ClassNotFoundException, SQLException {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT YEAR(created_at) as year, COUNT(*) as count, COALESCE(SUM(total), 0) as revenue "
                + "FROM orders "
                + "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 5 YEAR) "
                + "GROUP BY YEAR(created_at) "
                + "ORDER BY YEAR(created_at) ASC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Object[] row = {rs.getInt("year"), rs.getInt("count"), rs.getDouble("revenue")};
                stats.add(row);
            }
        }
        return stats;
    }

    // Thống kê doanh thu theo tháng trong năm (không cần status)
    public List<Object[]> getRevenueByMonth(int year) throws ClassNotFoundException, SQLException {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT MONTH(created_at) as month, COALESCE(SUM(total), 0) as revenue "
                + "FROM orders "
                + "WHERE YEAR(created_at) = ? "
                + "GROUP BY MONTH(created_at) "
                + "ORDER BY MONTH(created_at) ASC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Object[] row = {rs.getInt("month"), rs.getDouble("revenue")};
                    stats.add(row);
                }
            }
        }
        return stats;
    }

    // Top sản phẩm bán chạy
    public List<Object[]> getTopProducts(int limit) throws ClassNotFoundException, SQLException {
        List<Object[]> stats = new ArrayList<>();
        String sql = "SELECT p.id, p.name, COALESCE(SUM(oi.quantity), 0) as total_sold, COALESCE(SUM(oi.quantity * oi.price), 0) as revenue "
                + "FROM order_items oi "
                + "RIGHT JOIN products p ON oi.product_id = p.id "
                + "LEFT JOIN orders o ON oi.order_id = o.id AND o.status = 'delivered' "
                + "GROUP BY p.id, p.name "
                + "ORDER BY total_sold DESC "
                + "LIMIT ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Object[] row = {rs.getInt("id"), rs.getString("name"), rs.getInt("total_sold"), rs.getDouble("revenue")};
                    stats.add(row);
                }
            }
        }
        return stats;
    }

    // ==================== ĐƠN HÀNG ====================
    // Đếm tổng số đơn hàng
    public int countAllOrders() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Tính tổng doanh thu (tất cả đơn hàng)
    public double getTotalRevenue() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COALESCE(SUM(total), 0) FROM orders";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        }
        return 0;
    }

    // Đếm đơn hàng theo trạng thái
    public int countOrdersByStatus(String status) throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Đếm số lượng đơn hàng theo bộ lọc
    public int countOrdersFiltered(String status, String keyword) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM orders o "
                + "LEFT JOIN users u ON o.user_id = u.id WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.status = ?");
            params.add(status);
        }

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (o.id LIKE ? OR u.full_name LIKE ? OR o.phone LIKE ?)");
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

// Lấy danh sách đơn hàng có phân trang (KHÔNG DÙNG STATUS)
    public List<Order> getOrdersPaginated(int page, int pageSize, String keyword)
            throws ClassNotFoundException, SQLException {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder(
                "SELECT o.*, COALESCE(u.full_name, o.name) as customer_name FROM orders o "
                + "LEFT JOIN users u ON o.user_id = u.id WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (o.id LIKE ? OR COALESCE(u.full_name, o.name) LIKE ? OR o.phone LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        sql.append(" ORDER BY o.created_at DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setNote(rs.getString("note"));
                    order.setTotal(rs.getDouble("total"));
                    // KHÔNG set status
                    order.setOrderDate(rs.getTimestamp("created_at"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

// Đếm số lượng đơn hàng theo bộ lọc (KHÔNG DÙNG STATUS)
    public int countOrdersFiltered(String keyword) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM orders o "
                + "LEFT JOIN users u ON o.user_id = u.id WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (o.id LIKE ? OR COALESCE(u.full_name, o.name) LIKE ? OR o.phone LIKE ?)");
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

    // Lấy chi tiết đơn hàng theo ID
    public Order getOrderById(int orderId) throws ClassNotFoundException, SQLException {
        Order order = null;
        String sql = "SELECT o.*, u.full_name as customer_name FROM orders o "
                + "LEFT JOIN users u ON o.user_id = u.id WHERE o.id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setNote(rs.getString("note"));
                    order.setTotal(rs.getDouble("total"));
//                    order.setStatus(rs.getString("status"));
                    order.setOrderDate(rs.getTimestamp("created_at"));
                }
            }
        }
        return order;
    }

    // Lấy danh sách sản phẩm trong đơn hàng (có ảnh)
    public List<OrderItem> getOrderItems(int orderId) throws ClassNotFoundException, SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.name as product_name, p.image as product_image FROM order_items oi "
                + "JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductImage(rs.getString("product_image"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    // Tạo đơn hàng mới
    public boolean createOrder(int userId, java.util.Map<Integer, Integer> cart, String fullName,
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
            for (java.util.Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productDAO.getById(entry.getKey());
                if (product != null) {
                    total += product.getPrice() * entry.getValue();
                }
            }

            String sqlOrder = "INSERT INTO orders (user_id, total, name, phone, address, note, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
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

            for (java.util.Map.Entry<Integer, Integer> entry : cart.entrySet()) {
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
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (psItem != null) {
                psItem.close();
            }
            if (psOrder != null) {
                psOrder.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
