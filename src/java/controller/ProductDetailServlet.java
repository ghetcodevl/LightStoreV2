package controller;

import dao.ProductDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.Review;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            // Lấy id từ request parameter
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            int productId = Integer.parseInt(idParam);  // ← Khai báo productId ở đây

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getById(productId);

            if (product != null) {
                request.setAttribute("product", product);

                // Lấy sản phẩm liên quan
                List<Product> relatedProducts = productDAO.getRelatedProducts(product.getCategoryId(), product.getId(), 8);
                request.setAttribute("relatedProducts", relatedProducts);

                // Lấy đánh giá sản phẩm - DÙNG productId ĐÃ KHAI BÁO
                ReviewDAO reviewDAO = new ReviewDAO();
                List<Review> reviews = reviewDAO.getReviewsByProduct(productId, 5, 0);
                int totalReviews = reviewDAO.countReviewsByProduct(productId);
                double avgRating = reviewDAO.getAverageRating(productId);

                request.setAttribute("reviews", reviews);
                request.setAttribute("totalReviews", totalReviews);
                request.setAttribute("avgRating", avgRating);

                request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/products");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}
