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
import model.User;

@WebServlet(name = "AdminOrdersServlet", urlPatterns = {"/admin/orders"})
public class AdminOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        try {
            OrderDAO orderDAO = new OrderDAO();
            
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            String keyword = request.getParameter("keyword");
            
            // Lấy danh sách đơn hàng (không lọc theo status)
            List<Order> orderList = orderDAO.getOrdersPaginated(page, pageSize, keyword);
            int totalOrders = orderDAO.countOrdersFiltered(keyword);
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            
            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keywordFilter", keyword);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }
}