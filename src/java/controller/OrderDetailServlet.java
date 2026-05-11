package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.OrderItem;
import model.User;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            OrderDAO orderDAO = new OrderDAO();
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            
            // Kiểm tra đơn hàng có thuộc về user này không
            if (order == null || (order.getUserId() != user.getId() && !"admin".equals(user.getRole()))) {
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Lấy danh sách sản phẩm trong đơn hàng
            List<OrderItem> orderItems = orderDAO.getOrderItems(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
    }
}