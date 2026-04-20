/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import java.util.HashMap;
import java.util.Map;
import model.Product;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author admin
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet", "/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì chuyển về home
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            // Chưa đăng nhập, chuyển đến trang đăng nhập với thông báo
//            session = request.getSession();
//            // THÊM CONTEXT PATH VÀO redirect
//            session.setAttribute("redirectAfterLogin", request.getContextPath() + "/cart");
//            session.setAttribute("loginMessage", "Vui lòng đăng nhập để xem giỏ hàng!");
//            response.sendRedirect(request.getContextPath() + "/LoginServlet");
//            return;
//        }
//        request.getRequestDispatcher("/login.jsp").forward(request, response);
        // Kiểm tra nếu đã đăng nhập thì chuyển về home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (email == null) email = "";
    if (password == null) password = "";
    
    email = email.trim();
    password = password.trim();
    
    if (email.isEmpty() || password.isEmpty()) {
        request.setAttribute("mess", "Vui lòng nhập email và mật khẩu");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
        return;
    }
    
    try {
        UserDAO dao = new UserDAO();
        User u = dao.getUserByEmail(email);
        
        if (u == null) {
            request.setAttribute("mess", "Email hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        boolean match = BCrypt.checkpw(password, u.getPassword());
        
        if (match) {
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            session.setMaxInactiveInterval(30 * 60);
            
            // Kiểm tra có sản phẩm đang chờ thêm vào giỏ không
            String pendingProductId = (String) session.getAttribute("pendingProductId");
            String pendingQuantity = (String) session.getAttribute("pendingQuantity");
            String pendingAction = (String) session.getAttribute("pendingAction");
            
            // Xóa pending attributes
            session.removeAttribute("pendingProductId");
            session.removeAttribute("pendingQuantity");
            session.removeAttribute("pendingAction");
            
            // Nếu có sản phẩm đang chờ, thêm vào giỏ hàng
            if (pendingProductId != null && "add".equals(pendingAction)) {
                try {
                    int productId = Integer.parseInt(pendingProductId);
                    int quantity = 1;
                    if (pendingQuantity != null && !pendingQuantity.isEmpty()) {
                        quantity = Integer.parseInt(pendingQuantity);
                    }
                    
                    // Lấy giỏ hàng từ session
                    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
                    if (cart == null) {
                        cart = new HashMap<>();
                    }
                    
                    // Thêm sản phẩm vào giỏ
                    if (cart.containsKey(productId)) {
                        cart.put(productId, cart.get(productId) + quantity);
                    } else {
                        cart.put(productId, quantity);
                    }
                    
                    session.setAttribute("cart", cart);
                    
                    // Lấy tên sản phẩm để thông báo
                    ProductDAO productDAO = new ProductDAO();
                    Product product = productDAO.getById(productId);
                    if (product != null) {
                        session.setAttribute("cartMessage", "Đã thêm " + product.getName() + " vào giỏ hàng!");
                    } else {
                        session.setAttribute("cartMessage", "Đã thêm sản phẩm vào giỏ hàng!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
            // Kiểm tra có redirect sau đăng nhập không
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            String loginMessage = (String) session.getAttribute("loginMessage");
            
            // Xóa các attribute tạm thời
            session.removeAttribute("redirectAfterLogin");
            session.removeAttribute("loginMessage");
            
            // Nếu có message thì hiển thị (nhưng nếu đã thêm sản phẩm thì không ghi đè)
            if (loginMessage != null && !loginMessage.isEmpty() && session.getAttribute("cartMessage") == null) {
                session.setAttribute("cartMessage", loginMessage);
            }
            
            // Chuyển hướng
            if ("admin".equals(u.getRole())) {
                response.sendRedirect("dashboard.jsp");
            } else if (redirectUrl != null && !redirectUrl.isEmpty()) {
                // Đảm bảo redirectUrl có context path
                if (!redirectUrl.startsWith(request.getContextPath()) && !redirectUrl.startsWith("/")) {
                    redirectUrl = request.getContextPath() + "/" + redirectUrl;
                }
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/Home");
            }
            return;
        } else {
            request.setAttribute("mess", "Email hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("mess", "Lỗi hệ thống, vui lòng thử lại sau");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
}
