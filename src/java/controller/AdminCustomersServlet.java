package controller.admin;

import dao.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "AdminCustomersServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomersServlet extends HttpServlet {

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
            UserDAO userDAO = new UserDAO();
            
            // Phân trang
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            
            String keyword = request.getParameter("keyword");
            
            List<User> customerList = userDAO.getCustomersPaginated(page, pageSize, keyword);
            int totalCustomers = userDAO.countCustomersFiltered(keyword);
            int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);
            
            request.setAttribute("customerList", customerList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keywordFilter", keyword);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/admin/customers.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            UserDAO userDAO = new UserDAO();
            
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = userDAO.deleteUser(id);
                session.setAttribute(success ? "successMessage" : "errorMessage", 
                    success ? "Đã xóa khách hàng!" : "Xóa thất bại!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/customers");
    }
}