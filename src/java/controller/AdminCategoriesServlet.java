package controller;

import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.User;

@WebServlet(name = "AdminCategoriesServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoriesServlet extends HttpServlet {

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
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categoryList = categoryDAO.getAll();
            request.setAttribute("categoryList", categoryList);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
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
            CategoryDAO categoryDAO = new CategoryDAO();
            
            if ("add".equals(action)) {
                Category c = new Category();
                c.setName(request.getParameter("name"));
                boolean success = categoryDAO.insert(c);
                session.setAttribute(success ? "successMessage" : "errorMessage", 
                    success ? "Thêm danh mục thành công!" : "Thêm thất bại!");
                
            } else if ("edit".equals(action)) {
                Category c = new Category();
                c.setId(Integer.parseInt(request.getParameter("id")));
                c.setName(request.getParameter("name"));
                boolean success = categoryDAO.update(c);
                session.setAttribute(success ? "successMessage" : "errorMessage", 
                    success ? "Cập nhật danh mục thành công!" : "Cập nhật thất bại!");
                
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = categoryDAO.delete(id);
                session.setAttribute(success ? "successMessage" : "errorMessage", 
                    success ? "Xóa danh mục thành công!" : "Xóa thất bại!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}