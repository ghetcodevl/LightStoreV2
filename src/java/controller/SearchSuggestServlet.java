package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchSuggestServlet", urlPatterns = {"/api/suggest"})
public class SearchSuggestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        
        if (keyword != null && keyword.length() > 1) {
            try {
                ProductDAO dao = new ProductDAO();
                List<String> suggestions = dao.getSearchSuggestions(keyword);
                
                // Tạo JSON thủ công
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < suggestions.size(); i++) {
                    if (i > 0) json.append(",");
                    json.append("\"").append(escapeJson(suggestions.get(i))).append("\"");
                }
                json.append("]");
                
                out.print(json.toString());
                
            } catch (Exception e) {
                e.printStackTrace();
                out.print("[]");
            }
        } else {
            out.print("[]");
        }
        out.flush();
    }
    
    private String escapeJson(String s) {
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}