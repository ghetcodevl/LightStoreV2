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
        String sql = "SELECT p.*, c.name as category_name FROM products p "
                + "LEFT JOIN categories c ON p.category_id = c.id "
                + "WHERE p.id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
    // Đếm số lượng sản phẩm theo bộ lọc

    public int countProductsFiltered(String keyword, String category) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword + "%");
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category_id = ?");
            params.add(Integer.parseInt(category));
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

    // Đếm tổng số sản phẩm
    public int countAll() throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

// Lấy sản phẩm có phân trang
    public List<Product> getProductsPaginated(int page, int pageSize, String keyword, String category)
            throws ClassNotFoundException, SQLException {
        List<Product> products = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword + "%");
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category_id = ?");
            params.add(Integer.parseInt(category));
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setTag(rs.getString("tag"));
                    p.setCategoryId(rs.getInt("category_id"));
                    products.add(p);
                }
            }
        }
        return products;
    }
    // Thêm sản phẩm

    public boolean insert(Product p) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO products (name, price, image, description, tag, category_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getTag());
            ps.setInt(6, p.getCategoryId());
            return ps.executeUpdate() > 0;
        }
    }

// Cập nhật sản phẩm
    public boolean update(Product p) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE products SET name = ?, price = ?, image = ?, description = ?, tag = ?, category_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getTag());
            ps.setInt(6, p.getCategoryId());
            ps.setInt(7, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

// Xóa sản phẩm
//    public boolean delete(int id) throws ClassNotFoundException, SQLException {
//        // Kiểm tra ràng buộc khóa ngoại
//        String checkSql = "SELECT COUNT(*) FROM order_items WHERE product_id = ?";
//        try (Connection conn = DBConnection.getConnection(); PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
//            psCheck.setInt(1, id);
//            try (ResultSet rs = psCheck.executeQuery()) {
//                if (rs.next() && rs.getInt(1) > 0) {
//                    return false; // Có đơn hàng chứa sản phẩm này, không thể xóa
//                }
//            }
//        }
//
//        String sql = "DELETE FROM products WHERE id = ?";
//        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, id);
//            return ps.executeUpdate() > 0;
//        }
//    }
    public boolean delete(int id) throws ClassNotFoundException, SQLException {
    System.out.println("ProductDAO.delete() called with ID: " + id);
    
    String sql = "DELETE FROM products WHERE id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        int result = ps.executeUpdate();
        System.out.println("Delete result: " + result);
        return result > 0;
    } catch (SQLException e) {
        System.out.println("SQL Error: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }
}

    // Lấy sản phẩm có phân trang và lọc
    public List<Product> getProductsWithPagination(int offset, int limit, String categoryId, String tag)
            throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND category_id = ?");
            params.add(Integer.parseInt(categoryId));
        }

        if (tag != null && !tag.isEmpty()) {
            sql.append(" AND tag = ?");
            params.add(tag);
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setTag(rs.getString("tag"));
                    p.setCategoryId(rs.getInt("category_id"));
                    list.add(p);
                }
            }
        }
        return list;
    }

// Đếm tổng số sản phẩm theo filter
    public int countProducts(String categoryId, String tag) throws ClassNotFoundException, SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND category_id = ?");
            params.add(Integer.parseInt(categoryId));
        }

        if (tag != null && !tag.isEmpty()) {
            sql.append(" AND tag = ?");
            params.add(tag);
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
    // Tìm kiếm sản phẩm thông minh (tìm theo từ khóa, tách từ)

//    public List<Product> searchProducts(String keyword, int offset, int limit)
//            throws ClassNotFoundException, SQLException {
//        List<Product> list = new ArrayList<>();
//
//        // Tách từ khóa thành các từ riêng biệt
//        String[] words = keyword.toLowerCase().trim().split("\\s+");
//
//        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE ");
//        List<Object> params = new ArrayList<>();
//
//        // Tìm kiếm theo từng từ
//        for (int i = 0; i < words.length; i++) {
//            if (i > 0) {
//                sql.append(" OR ");
//            }
//            sql.append("(LOWER(name) LIKE ? OR LOWER(description) LIKE ?)");
//            params.add("%" + words[i] + "%");
//            params.add("%" + words[i] + "%");
//        }
//
//        // Ưu tiên sắp xếp: tên chính xác lên đầu, sau đó theo độ dài tên
//        sql.append(" ORDER BY CASE WHEN LOWER(name) LIKE ? THEN 1 ELSE 2 END, LENGTH(name) ASC");
//        params.add("%" + keyword.toLowerCase() + "%");
//
//        sql.append(" LIMIT ? OFFSET ?");
//        params.add(limit);
//        params.add(offset);
//
//        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
//
//            for (int i = 0; i < params.size(); i++) {
//                ps.setObject(i + 1, params.get(i));
//            }
//
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Product p = new Product();
//                    p.setId(rs.getInt("id"));
//                    p.setName(rs.getString("name"));
//                    p.setPrice(rs.getDouble("price"));
//                    p.setImage(rs.getString("image"));
//                    p.setDescription(rs.getString("description"));
//                    p.setTag(rs.getString("tag"));
//                    p.setCategoryId(rs.getInt("category_id"));
//                    list.add(p);
//                }
//            }
//        }
//        return list;
//    }
// Tìm kiếm đơn giản nhưng hiệu quả
    public List<Product> searchProducts(String keyword, int offset, int limit)
            throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ? LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setInt(3, limit);
            ps.setInt(4, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setImage(rs.getString("image"));
                    p.setDescription(rs.getString("description"));
                    p.setTag(rs.getString("tag"));
                    p.setCategoryId(rs.getInt("category_id"));
                    list.add(p);
                }
            }
        }
        return list;
    }
// Đếm kết quả tìm kiếm thông minh

    public int countSearchProducts(String keyword) throws ClassNotFoundException, SQLException {
        String[] words = keyword.toLowerCase().trim().split("\\s+");

        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE ");
        List<Object> params = new ArrayList<>();

        for (int i = 0; i < words.length; i++) {
            if (i > 0) {
                sql.append(" OR ");
            }
            sql.append("(LOWER(name) LIKE ? OR LOWER(description) LIKE ?)");
            params.add("%" + words[i] + "%");
            params.add("%" + words[i] + "%");
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

// Tìm kiếm gợi ý (autocomplete)
    public List<String> getSearchSuggestions(String keyword) throws ClassNotFoundException, SQLException {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT DISTINCT name FROM products WHERE LOWER(name) LIKE ? LIMIT 5";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword.toLowerCase() + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    suggestions.add(rs.getString("name"));
                }
            }
        }
        return suggestions;
    }
}
