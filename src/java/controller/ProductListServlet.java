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
             response.setContentType("text/html;charset=UTF-8");
             request.setCharacterEncoding("UTF-8");
          try {
            ProductDAO dao = new ProductDAO();
            String categoryId = request.getParameter("category");
            String tag = request.getParameter("tag");
            String keyword = request.getParameter("keyword");
            
            // Xử lý phân trang
            int page = 1;
            int pageSize = 12;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {}
            }
            int offset = (page - 1) * pageSize;
            
            List<Product> list;
            int totalProducts;
            String title = "Tất cả sản phẩm";
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm thông minh
                keyword = keyword.trim();
                list = dao.searchProducts(keyword, offset, pageSize);
                totalProducts = dao.countSearchProducts(keyword);
                title = "Kết quả tìm kiếm: " + keyword;
                
                // Lấy gợi ý nếu không có kết quả
                if (list.isEmpty()) {
                    List<String> suggestions = dao.getSearchSuggestions(keyword);
                    request.setAttribute("suggestions", suggestions);
                }
                
                request.setAttribute("keyword", keyword);
                
            } else if (categoryId != null && !categoryId.isEmpty()) {
                list = dao.getProductsWithPagination(offset, pageSize, categoryId, null);
                totalProducts = dao.countProducts(categoryId, null);
                title = getCategoryName(Integer.parseInt(categoryId));
                
            } else if (tag != null && !tag.isEmpty()) {
                list = dao.getProductsWithPagination(offset, pageSize, null, tag);
                totalProducts = dao.countProducts(null, tag);
                switch (tag) {
                    case "new": title = "Hàng mới"; break;
                    case "bestseller": title = "Bán chạy"; break;
                    case "sale": title = "Giảm giá"; break;
                }
            } else {
                list = dao.getProductsWithPagination(offset, pageSize, null, null);
                totalProducts = dao.countProducts(null, null);
            }
            
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            
            request.setAttribute("listP", list);
            request.setAttribute("title", title);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("categoryFilter", categoryId);
            request.setAttribute("tagFilter", tag);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Home");
        }
        
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }

    private String getCategoryName(int id) {
        switch (id) {
            case 1:
                return "Đèn Chùm Pha Lê";
            case 2:
                return "Đèn Chùm Cổ Điển";
            case 3:
                return "Đèn Chùm Đồng";
            case 4:
                return "Đèn Thả Trần";
            default:
                return "Sản phẩm";
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
