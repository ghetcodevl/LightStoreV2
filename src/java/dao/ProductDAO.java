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
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setImage(rs.getString("image"));
                p.setPrice(rs.getDouble("price"));
                p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
                p.setDescription(rs.getString("description"));
                p.setTag(rs.getString("tag"));
                p.setCategoryId(rs.getInt("category_id"));
                list.add(p);
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
                    product.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    product.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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
                    p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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

    // Lấy sản phẩm có phân trang (cho admin)
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

        sql.append(" ORDER BY id DESC LIMIT ? OFFSET ?");
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
                    p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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
        String sql = "INSERT INTO products (name, price, old_price, discount_percent, image, description, tag, category_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setDouble(3, p.getOldPrice());
            ps.setInt(4, p.getDiscountPercent());
            ps.setString(5, p.getImage());
            ps.setString(6, p.getDescription());
            ps.setString(7, p.getTag());
            ps.setInt(8, p.getCategoryId());
            return ps.executeUpdate() > 0;
        }
    }

    // Cập nhật sản phẩm
    public boolean update(Product p) throws ClassNotFoundException, SQLException {
        String sql = "UPDATE products SET name = ?, price = ?, old_price = ?, discount_percent = ?, image = ?, description = ?, tag = ?, category_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setDouble(3, p.getOldPrice());
            ps.setInt(4, p.getDiscountPercent());
            ps.setString(5, p.getImage());
            ps.setString(6, p.getDescription());
            ps.setString(7, p.getTag());
            ps.setInt(8, p.getCategoryId());
            ps.setInt(9, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // Xóa sản phẩm
    public boolean delete(int id) throws ClassNotFoundException, SQLException {
        System.out.println("ProductDAO.delete() called with ID: " + id);

        // Kiểm tra ràng buộc khóa ngoại với order_items
        String checkSql = "SELECT COUNT(*) FROM order_items WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
            psCheck.setInt(1, id);
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    System.out.println("Cannot delete product ID=" + id + " because it exists in order_items");
                    return false;
                }
            }
        }

        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    // Lấy sản phẩm có phân trang và lọc (cho user)
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

        sql.append(" ORDER BY id DESC LIMIT ? OFFSET ?");
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
                    p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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

    // Đếm tổng số sản phẩm theo filter (cho user)
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

    // Tìm kiếm sản phẩm đơn giản
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
                    p.setOldPrice(rs.getDouble("old_price"));      // Thêm
                    p.setDiscountPercent(rs.getInt("discount_percent")); // Thêm
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

    // Đếm kết quả tìm kiếm
    public int countSearchProducts(String keyword) throws ClassNotFoundException, SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE name LIKE ? OR description LIKE ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    // Lấy sản phẩm liên quan (cùng category, không bao gồm sản phẩm hiện tại)

    // Lấy sản phẩm liên quan cùng danh mục
    public List<Product> getRelatedProducts(int categoryId, int currentProductId, int limit)
            throws ClassNotFoundException, SQLException {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ? AND id != ? LIMIT ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, currentProductId);
            ps.setInt(3, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getDouble("price"));
                    p.setOldPrice(rs.getDouble("old_price"));
                    p.setDiscountPercent(rs.getInt("discount_percent"));
                    p.setImage(rs.getString("image"));
                    p.setTag(rs.getString("tag"));
                    list.add(p);
                }
            }
        }
        return list;
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
