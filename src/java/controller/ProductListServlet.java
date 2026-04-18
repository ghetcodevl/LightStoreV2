/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/ProductListServlet", "/products"})
public class ProductListServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//          ProductDAO dao = new ProductDAO();
//        String categoryId = request.getParameter("category");
//        String tag = request.getParameter("tag");
//        
//        try {
//            List<Product> list = null;
//            
//            if (categoryId != null && !categoryId.isEmpty()) {
//                // Lọc theo category
//                list = dao.getByCategory(Integer.parseInt(categoryId));
//                request.setAttribute("title", "Danh mục sản phẩm");
//            } else if (tag != null && !tag.isEmpty()) {
//                // Lọc theo tag
//                list = dao.getByTag(tag);
//                if (tag.equals("new")) {
//                    request.setAttribute("title", "Hàng mới");
//                } else if (tag.equals("bestseller")) {
//                    request.setAttribute("title", "Bán chạy");
//                } else if (tag.equals("sale")) {
//                    request.setAttribute("title", "Giảm giá");
//                }
//            } else {
//                // Tất cả sản phẩm
//                list = dao.getAll();
//                request.setAttribute("title", "Tất cả sản phẩm");
//            }
//            
//            request.setAttribute("listP", list);
//            request.getRequestDispatcher("products.jsp").forward(request, response);
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("index.jsp");
//        }
        
          try {
            ProductDAO dao = new ProductDAO();
            String categoryId = request.getParameter("category");
            String tag = request.getParameter("tag");
            
            List<Product> list = null;
            String title = "Tất cả sản phẩm";
            
            if (categoryId != null && !categoryId.isEmpty()) {
                list = dao.getByCategory(Integer.parseInt(categoryId));
                title = getCategoryName(Integer.parseInt(categoryId));
            } else if (tag != null && !tag.isEmpty()) {
                list = dao.getByTag(tag);
                switch(tag) {
                    case "new": title = "Hàng mới"; break;
                    case "bestseller": title = "Bán chạy"; break;
                    case "sale": title = "Giảm giá"; break;
                    default: title = "Sản phẩm nổi bật";
                }
            } else {
                list = dao.getAll();
            }
            
            request.setAttribute("listP", list);
            request.setAttribute("title", title);
            request.getRequestDispatcher("/products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Home");
        }
    
    }
     
    private String getCategoryName(int id) {
        switch(id) {
            case 1: return "Đèn Chùm Pha Lê";
            case 2: return "Đèn chùm cổ điển";
            case 3: return "Đèn chùm Đồng";
            case 4: return "Đèn chùm phòng khách";
            default: return "Sản phẩm";
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
