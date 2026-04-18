/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import dao.ProductDAO;
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

/**
 *
 * @author admin
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet" , "/checkout"})
public class CheckoutServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
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
        
        // Kiểm tra đăng nhập
        if (session.getAttribute("user") == null) {
            session.setAttribute("redirectAfterLogin", "/checkout");
            session.setAttribute("loginMessage", "Vui lòng đăng nhập để thanh toán!");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        
        // Kiểm tra giỏ hàng
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("cartMessage", "Giỏ hàng trống!");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Lấy thông tin giỏ hàng
        try {
            ProductDAO productDAO = new ProductDAO();
            Map<Product, Integer> cartItems = new HashMap<>();
            double total = 0;
            
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productDAO.getById(entry.getKey());
                if (product != null) {
                    cartItems.put(product, entry.getValue());
                    total += product.getPrice() * entry.getValue();
                }
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
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
        
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        
        // Validate
        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin giao hàng!");
            doGet(request, response);
            return;
        }
        
        try {
            OrderDAO orderDAO = new OrderDAO();
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            
            boolean success = orderDAO.createOrder(
                user.getId(), cart, fullName, phone, address, note
            );
            
            if (success) {
                session.removeAttribute("cart");
                session.setAttribute("orderSuccess", "Đặt hàng thành công!");
                response.sendRedirect(request.getContextPath() + "/order-success.jsp");
            } else {
                request.setAttribute("error", "Đặt hàng thất bại!");
                doGet(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            doGet(request, response);
        }
    }
    }

    