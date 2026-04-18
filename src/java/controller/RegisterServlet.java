/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet" , "/register"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
          if (request.getSession().getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        
        // Xử lý null và trim
        fullname = (fullname == null) ? "" : fullname.trim();
        email = (email == null) ? "" : email.trim();
        phone = (phone == null) ? "" : phone.trim();
        address = (address == null) ? "" : address.trim();
        password = (password == null) ? "" : password.trim();
        repassword = (repassword == null) ? "" : repassword.trim();
        
        // Validate dữ liệu
        if (fullname.isEmpty()) {
            request.setAttribute("mess", "Vui lòng nhập họ tên");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (email.isEmpty()) {
            request.setAttribute("mess", "Vui lòng nhập email");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("mess", "Email không đúng định dạng (ví dụ: name@example.com)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (password.isEmpty()) {
            request.setAttribute("mess", "Vui lòng nhập mật khẩu");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 6) {
            request.setAttribute("mess", "Mật khẩu phải có ít nhất 6 ký tự");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(repassword)) {
            request.setAttribute("mess", "Mật khẩu xác nhận không khớp");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Validate phone (nếu có nhập)
        if (!phone.isEmpty() && !phone.matches("^[0-9]{10,11}$")) {
            request.setAttribute("mess", "Số điện thoại không hợp lệ (phải 10-11 chữ số)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        try {
            UserDAO dao = new UserDAO();
            
            // Kiểm tra email đã tồn tại chưa
            User existingUser = dao.getUserByEmail(email);
            if (existingUser != null) {
                request.setAttribute("mess", "Email đã được đăng ký. Vui lòng sử dụng email khác!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }
            
            // Tạo user mới
            User newUser = new User();
            newUser.setFullName(fullname);
            newUser.setEmail(email);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            
            // Mã hóa mật khẩu bằng BCrypt
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            newUser.setPassword(hashedPassword);
            newUser.setRole("user"); // Mặc định là user thường
            
            // Lưu vào database
            boolean success = dao.ins(newUser);
            
            if (success) {
                // Đăng ký thành công, chuyển về trang đăng nhập
                request.getSession().setAttribute("successMess", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
            } else {
                request.setAttribute("mess", "Đăng ký thất bại, vui lòng thử lại sau!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mess", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    
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
