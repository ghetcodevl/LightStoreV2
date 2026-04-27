package controller.admin;

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
        
        // Kiểm tra đăng nhập admin
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
            
            // ========== LẤY SỐ LIỆU THỰC TẾ ==========
            
            // 1. Tổng số đơn hàng
            int totalOrders = orderDAO.countAllOrders();
            
            // 2. Tổng doanh thu
            double totalRevenue = orderDAO.getTotalRevenue();
            
            // 3. Đơn hàng chờ xác nhận
            int pendingOrders = orderDAO.countOrdersByStatus("pending");
            
            // 4. Đơn hàng đã giao
            int deliveredOrders = orderDAO.countOrdersByStatus("delivered");
            
            // 5. Thống kê theo tuần (cho biểu đồ)
            List<Object[]> weeklyStats = orderDAO.getWeeklyStats();
            List<Object[]> monthlyStats = orderDAO.getMonthlyStats();
            List<Object[]> yearlyStats = orderDAO.getYearlyStats();
            
            // 6. Lấy danh sách đơn hàng (phân trang)
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            
            List<Order> orderList = orderDAO.getOrdersPaginated(page, pageSize, status, keyword);
            int totalOrdersFiltered = orderDAO.countOrdersFiltered(status, keyword);
            int totalPages = (int) Math.ceil((double) totalOrdersFiltered / pageSize);
            
            // ========== TẠO DỮ LIỆU JSON CHO BIỂU ĐỒ ==========
            // Chuyển đổi dữ liệu từ database sang định dạng chartData
            
            // Dữ liệu tuần (mặc định 7 ngày)
            String[] weekLabels = {"Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN"};
            int[] weekData = new int[7];
            for (Object[] stat : weeklyStats) {
                String day = (String) stat[0];
                int count = (int) stat[1];
                // Map ngày từ database sang thứ
                for (int i = 0; i < weekLabels.length; i++) {
                    if (weekLabels[i].equalsIgnoreCase(day)) {
                        weekData[i] = count;
                        break;
                    }
                }
            }
            
            // Dữ liệu tháng (4 tuần)
            String[] monthLabels = {"Tuần 1", "Tuần 2", "Tuần 3", "Tuần 4"};
            int[] monthData = new int[4];
            for (int i = 0; i < monthlyStats.size() && i < 4; i++) {
                monthData[i] = (int) monthlyStats.get(i)[1];
            }
            
            // Dữ liệu năm (12 tháng)
            String[] yearLabels = {"T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"};
            int[] yearData = new int[12];
            for (Object[] stat : yearlyStats) {
                int month = (int) stat[0]; // Tháng 1-12
                int count = (int) stat[1];
                if (month >= 1 && month <= 12) {
                    yearData[month - 1] = count;
                }
            }
            
            // Tạo JSON string cho biểu đồ
            String chartDataJson = String.format(
                "{week:{labels:%s, data:%s}, month:{labels:%s, data:%s}, year:{labels:%s, data:%s}}",
                arrayToJson(weekLabels), arrayToJson(weekData),
                arrayToJson(monthLabels), arrayToJson(monthData),
                arrayToJson(yearLabels), arrayToJson(yearData)
            );
            
            // ========== SET ATTRIBUTES ==========
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("deliveredOrders", deliveredOrders);
            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("chartDataJson", chartDataJson);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
        }
        
        // Forward đến dashboard.jsp (giữ nguyên form của bạn)
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