package controller.admin;

import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "AdminReportsServlet", urlPatterns = {"/admin/reports"})
public class AdminReportsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        try {
            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();
            
            String type = request.getParameter("type");
            if (type == null) type = "revenue";
            
            if ("revenue".equals(type)) {
                int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                String yearParam = request.getParameter("year");
                if (yearParam != null && !yearParam.isEmpty()) {
                    year = Integer.parseInt(yearParam);
                }
                List<Object[]> revenueByMonth = orderDAO.getRevenueByMonth(year);
                if (revenueByMonth == null) revenueByMonth = new ArrayList<>();
                request.setAttribute("revenueData", revenueByMonth);
                request.setAttribute("selectedYear", year);
                
            } else if ("topProducts".equals(type)) {
                int limit = 10;
                String limitParam = request.getParameter("limit");
                if (limitParam != null && !limitParam.isEmpty()) {
                    limit = Integer.parseInt(limitParam);
                }
                List<Object[]> topProducts = orderDAO.getTopProducts(limit);
                if (topProducts == null) topProducts = new ArrayList<>();
                request.setAttribute("topProducts", topProducts);
                
            } else if ("orderStats".equals(type)) {
                int totalOrders = orderDAO.countAllOrders();
                int pending = orderDAO.countOrdersByStatus("pending");
                int confirmed = orderDAO.countOrdersByStatus("confirmed");
                int shipped = orderDAO.countOrdersByStatus("shipped");
                int delivered = orderDAO.countOrdersByStatus("delivered");
                int cancelled = orderDAO.countOrdersByStatus("cancelled");
                
                request.setAttribute("totalOrders", totalOrders);
                request.setAttribute("pending", pending);
                request.setAttribute("confirmed", confirmed);
                request.setAttribute("shipped", shipped);
                request.setAttribute("delivered", delivered);
                request.setAttribute("cancelled", cancelled);
            }
            
            request.setAttribute("reportType", type);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}