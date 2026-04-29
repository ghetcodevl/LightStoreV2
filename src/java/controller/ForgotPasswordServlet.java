package controller;

import dao.UserDAO;
import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/reset-password".equals(action)) {
            String token = request.getParameter("token");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        
        if ("/forgot-password".equals(action)) {
            String email = request.getParameter("email");
            
            try {
                UserDAO dao = new UserDAO();
                User user = dao.getUserByEmail(email);
                
                if (user == null) {
                    request.setAttribute("error", "Email không tồn tại trong hệ thống!");
                    request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                    return;
                }
                
                // Tạo token reset
                String token = generateToken();
                HttpSession session = request.getSession();
                session.setAttribute("reset_token", token);
                session.setAttribute("reset_email", email);
                session.setMaxInactiveInterval(15 * 60); // 15 phút
                
                // Tạo link reset
                String resetLink = request.getRequestURL().toString()
                        .replace("/forgot-password", "/reset-password")
                        + "?token=" + token;
                
                // HIỂN THỊ LINK TRỰC TIẾP (không gửi email)
                request.setAttribute("resetLink", resetLink);
                request.setAttribute("message", "Yêu cầu đặt lại mật khẩu thành công! Click vào link bên dưới để đặt lại mật khẩu.");
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            }
            
        } else if ("/reset-password".equals(action)) {
            String token = request.getParameter("token");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            
            HttpSession session = request.getSession();
            String sessionToken = (String) session.getAttribute("reset_token");
            String email = (String) session.getAttribute("reset_email");
            
            if (sessionToken == null || !sessionToken.equals(token)) {
                request.setAttribute("error", "Token không hợp lệ hoặc đã hết hạn!");
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }
            
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.setAttribute("token", token);
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }
            
            if (password.length() < 6) {
                request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
                request.setAttribute("token", token);
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                return;
            }
            
            try {
                UserDAO dao = new UserDAO();
                User user = dao.getUserByEmail(email);
                user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                
                boolean success = dao.updatePassword(user);
                
                if (success) {
                    session.removeAttribute("reset_token");
                    session.removeAttribute("reset_email");
                    response.sendRedirect(request.getContextPath() + "/LoginServlet?reset=success");
                } else {
                    request.setAttribute("error", "Đặt lại mật khẩu thất bại!");
                    request.setAttribute("token", token);
                    request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                request.setAttribute("token", token);
                request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            }
        }
    }
    
    private String generateToken() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder token = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 32; i++) {
            token.append(chars.charAt(random.nextInt(chars.length())));
        }
        return token.toString();
    }
}