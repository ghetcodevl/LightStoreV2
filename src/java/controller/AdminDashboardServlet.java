package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }
        
        try {
            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();
            UserDAO userDAO = new UserDAO();
            
            // Thống kê số lượng
            int totalOrders = orderDAO.countAllOrders();
            double totalRevenue = orderDAO.getTotalRevenue();
            int pendingOrders = orderDAO.countOrdersByStatus("pending");
            int deliveredOrders = orderDAO.countOrdersByStatus("delivered");
            int totalProducts = productDAO.countAll();
            int totalUsers = userDAO.countAll();
            
            // ===== QUAN TRỌNG: Lấy danh sách đơn hàng gần đây =====
            int page = 1;
            int pageSize = 10;
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            
            List<Order> orderList = orderDAO.getOrdersPaginated(page, pageSize, status, keyword);
            int totalOrdersFiltered = orderDAO.countOrdersFiltered(status, keyword);
            int totalPages = (int) Math.ceil((double) totalOrdersFiltered / pageSize);
            
            // Set attributes để JSP nhận
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("deliveredOrders", deliveredOrders);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("orderList", orderList);      // ← QUAN TRỌNG
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            // Dữ liệu cho biểu đồ
            List<Object[]> weeklyStats = orderDAO.getWeeklyStats();
            List<Object[]> monthlyStats = orderDAO.getMonthlyStats();
            List<Object[]> yearlyStats = orderDAO.getYearlyStats();
            
            request.setAttribute("weeklyStats", weeklyStats);
            request.setAttribute("monthlyStats", monthlyStats);
            request.setAttribute("yearlyStats", yearlyStats);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
    
    // Helper method chuyển mảng thành JSON
    private String arrayToJson(Object[] arr) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] instanceof String) {
                sb.append("\"").append(arr[i]).append("\"");
            } else {
                sb.append(arr[i]);
            }
            if (i < arr.length - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String arrayToJson(int[] arr) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < arr.length; i++) {
            sb.append(arr[i]);
            if (i < arr.length - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}