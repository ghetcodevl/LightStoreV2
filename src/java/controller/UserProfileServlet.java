package controller;

import dao.OrderDAO;
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

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/profile"})
public class UserProfileServlet extends HttpServlet {

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
            OrderDAO orderDAO = new OrderDAO();
            // Lấy danh sách đơn hàng của user
            List<Order> orderList = orderDAO.getOrdersByUserId(user.getId());
            request.setAttribute("orderList", orderList);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);
            
            try {
                UserDAO userDAO = new UserDAO();
                boolean success = userDAO.updateUser(user);
                
                if (success) {
                    session.setAttribute("user", user);
                    session.setAttribute("successMessage", "Cập nhật thông tin thành công!");
                } else {
                    session.setAttribute("errorMessage", "Cập nhật thất bại!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            }
            
            response.sendRedirect(request.getContextPath() + "/profile");
            
        } else if ("change-password".equals(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            if (newPassword.length() < 6) {
                session.setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            try {
                UserDAO userDAO = new UserDAO();
                // Kiểm tra mật khẩu cũ
                User dbUser = userDAO.getUserByEmail(user.getEmail());
                
                if (org.mindrot.jbcrypt.BCrypt.checkpw(oldPassword, dbUser.getPassword())) {
                    String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(newPassword, org.mindrot.jbcrypt.BCrypt.gensalt());
                    user.setPassword(hashedPassword);
                    
                    boolean success = userDAO.updatePassword(user);
                    if (success) {
                        session.setAttribute("successMessage", "Đổi mật khẩu thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Đổi mật khẩu thất bại!");
                    }
                } else {
                    session.setAttribute("errorMessage", "Mật khẩu cũ không đúng!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            }
            
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}