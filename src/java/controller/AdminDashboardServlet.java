/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.mysql.cj.x.protobuf.MysqlxCrud.Order;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"dashboards.jsp"})
public class AdminDashboardServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminDashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashboardServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
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

            // Lấy danh sách đơn hàng gần đây (có phân trang)
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");

            List<model.Order> orderList = orderDAO.getOrdersPaginated(page, pageSize, status, keyword);
            int totalOrdersFiltered = orderDAO.countOrdersFiltered(status, keyword);
            int totalPages = (int) Math.ceil((double) totalOrdersFiltered / pageSize);

            // Dữ liệu cho biểu đồ
            List<Object[]> weeklyStats = orderDAO.getWeeklyStats();
            List<Object[]> monthlyStats = orderDAO.getMonthlyStats();
            List<Object[]> yearlyStats = orderDAO.getYearlyStats();
            List<Object[]> topProducts = orderDAO.getTopProducts(5);

            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("deliveredOrders", deliveredOrders);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Chuyển dữ liệu biểu đồ thành JSON
            request.setAttribute("weeklyStats", weeklyStats);
            request.setAttribute("monthlyStats", monthlyStats);
            request.setAttribute("yearlyStats", yearlyStats);
            request.setAttribute("topProducts", topProducts);

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
