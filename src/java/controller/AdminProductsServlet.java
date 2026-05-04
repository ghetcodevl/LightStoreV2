package controller;

import dao.ProductDAO;
import dao.CategoryDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Product;
import model.Category;
import model.User;

@WebServlet(name = "AdminProductsServlet", urlPatterns = {"/admin/products"})
public class AdminProductsServlet extends HttpServlet {

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // ===== XỬ LÝ XÓA SẢN PHẨM (GET) =====
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                ProductDAO productDAO = new ProductDAO();
                boolean success = productDAO.delete(id);
                if (success) {
                    session.setAttribute("successMessage", "Xóa sản phẩm thành công!");
                } else {
                    session.setAttribute("errorMessage", "Xóa sản phẩm thất bại! Sản phẩm có thể đã có trong đơn hàng.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        // ===== HIỂN THỊ DANH SÁCH SẢN PHẨM =====
        try {
            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            // Lấy danh sách danh mục cho dropdown
            List<Category> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);

            int page = 1;
            int pageSize = 20;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");

            List<Product> productList = productDAO.getProductsPaginated(page, pageSize, keyword, category);
            int totalProducts = productDAO.countProductsFiltered(keyword, category);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keywordFilter", keyword);
            request.setAttribute("categoryFilter", category);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String action = request.getParameter("action");

        try {
            ProductDAO productDAO = new ProductDAO();

            if ("add".equals(action)) {
                // Thêm sản phẩm mới
                Product p = new Product();
                p.setName(request.getParameter("name"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setImage(request.getParameter("image"));
                p.setDescription(request.getParameter("description"));
                p.setTag(request.getParameter("tag"));
                p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

                boolean success = productDAO.insert(p);
                if (success) {
                    session.setAttribute("successMessage", "Thêm sản phẩm thành công!");
                } else {
                    session.setAttribute("errorMessage", "Thêm sản phẩm thất bại!");
                }

            } else if ("edit".equals(action)) {
                // Sửa sản phẩm
                Product p = new Product();
                p.setId(Integer.parseInt(request.getParameter("id")));
                p.setName(request.getParameter("name"));
                p.setPrice(Double.parseDouble(request.getParameter("price")));
                p.setImage(request.getParameter("image"));
                p.setDescription(request.getParameter("description"));
                p.setTag(request.getParameter("tag"));
                p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

                boolean success = productDAO.update(p);
                if (success) {
                    session.setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
                } else {
                    session.setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("Đang xóa sản phẩm ID: " + id);  // Debug

                boolean success = productDAO.delete(id);
                if (success) {
                    session.setAttribute("successMessage", "Xóa sản phẩm thành công!");
                    System.out.println("Xóa thành công ID: " + id);
                } else {
                    session.setAttribute("errorMessage", "Xóa sản phẩm thất bại!");
                    System.out.println("Xóa thất bại ID: " + id);
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Dữ liệu không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
