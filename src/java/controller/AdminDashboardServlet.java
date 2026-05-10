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
            int totalProducts = productDAO.countAll();
            int totalUsers = userDAO.countAll();
            
            System.out.println("=== DEBUG DASHBOARD ===");
            System.out.println("totalOrders: " + totalOrders);
            System.out.println("totalRevenue: " + totalRevenue);
            System.out.println("totalProducts: " + totalProducts);
            System.out.println("totalUsers: " + totalUsers);
            
            // Lấy danh sách đơn hàng gần đây (5 đơn gần nhất)
            String keyword = request.getParameter("keyword");
            List<Order> orderList = orderDAO.getOrdersPaginated(1, 5, keyword);
            System.out.println("orderList size: " + (orderList != null ? orderList.size() : 0));
            
            // Dữ liệu cho biểu đồ
            List<Object[]> weeklyStats = orderDAO.getWeeklyStats();
            List<Object[]> monthlyStats = orderDAO.getMonthlyStats();
            List<Object[]> yearlyStats = orderDAO.getYearlyStats();
            
            // Tạo JSON cho biểu đồ
            String chartDataJson = createChartDataJson(weeklyStats, monthlyStats, yearlyStats);
            
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("orderList", orderList);
            request.setAttribute("chartDataJson", chartDataJson);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải dữ liệu: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
    
    private String createChartDataJson(List<Object[]> weeklyStats, List<Object[]> monthlyStats, List<Object[]> yearlyStats) {
        // Dữ liệu tuần (mặc định 7 ngày)
        String[] weekLabels = {"Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN"};
        int[] weekData = new int[7];
        for (Object[] stat : weeklyStats) {
            if (stat != null && stat.length >= 2) {
                String day = (String) stat[0];
                int count = ((Number) stat[1]).intValue();
                for (int i = 0; i < weekLabels.length; i++) {
                    if (weekLabels[i].equalsIgnoreCase(day)) {
                        weekData[i] = count;
                        break;
                    }
                }
            }
        }
        
        // Dữ liệu tháng (4 tuần)
        String[] monthLabels = {"Tuần 1", "Tuần 2", "Tuần 3", "Tuần 4"};
        int[] monthData = new int[4];
        for (int i = 0; i < monthlyStats.size() && i < 4; i++) {
            if (monthlyStats.get(i) != null && monthlyStats.get(i).length >= 2) {
                monthData[i] = ((Number) monthlyStats.get(i)[1]).intValue();
            }
        }
        
        // Dữ liệu năm (12 tháng)
        String[] yearLabels = {"T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8", "T9", "T10", "T11", "T12"};
        int[] yearData = new int[12];
        for (Object[] stat : yearlyStats) {
            if (stat != null && stat.length >= 2) {
                int month = ((Number) stat[0]).intValue();
                int count = ((Number) stat[1]).intValue();
                if (month >= 1 && month <= 12) {
                    yearData[month - 1] = count;
                }
            }
        }
        
        return "{week:{labels:" + arrayToJson(weekLabels) + ", data:" + arrayToJson(weekData) + "}, " +
               "month:{labels:" + arrayToJson(monthLabels) + ", data:" + arrayToJson(monthData) + "}, " +
               "year:{labels:" + arrayToJson(yearLabels) + ", data:" + arrayToJson(yearData) + "}}";
    }
    
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