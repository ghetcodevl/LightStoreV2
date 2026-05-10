package controller;

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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // XỬ LÝ XÓA QUA GET
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                UserDAO userDAO = new UserDAO();
                boolean success = userDAO.deleteUser(id);
                if (success) {
                    session.setAttribute("successMessage", "Xóa khách hàng thành công!");
                } else {
                    session.setAttribute("errorMessage", "Xóa khách hàng thất bại!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        // HIỂN THỊ DANH SÁCH
        try {
            UserDAO userDAO = new UserDAO();

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
}
