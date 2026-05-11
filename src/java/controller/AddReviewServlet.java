package controller;

import dao.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Review;
import model.User;

@WebServlet(name = "AddReviewServlet", urlPatterns = {"/add-review"})
public class AddReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            
            Review review = new Review();
            review.setProductId(productId);
            review.setUserId(user.getId());
            review.setUserName(user.getFullName());
            review.setRating(rating);
            review.setComment(comment);
            
            ReviewDAO reviewDAO = new ReviewDAO();
            boolean success = reviewDAO.addReview(review);
            
            if (success) {
                session.setAttribute("reviewMessage", "Cảm ơn bạn đã đánh giá sản phẩm!");
            } else {
                session.setAttribute("reviewError", "Gửi đánh giá thất bại!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("reviewError", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/product-detail?id=" + request.getParameter("productId"));
    }
}