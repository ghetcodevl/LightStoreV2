package controller;

import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import model.Product;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet", "/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập trước khi xem giỏ hàng
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Chưa đăng nhập, chuyển đến trang đăng nhập với thông báo
            session = request.getSession();
            session.setAttribute("redirectAfterLogin", "/cart");
            session.setAttribute("loginMessage", "Vui lòng đăng nhập để xem giỏ hàng!");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "remove":
                    removeFromCart(request, response);
                    return;
                case "update":
                    updateCart(request, response);
                    return;
                case "clear":
                    clearCart(request, response);
                    return;
            }
        }

        // Hiển thị giỏ hàng
        displayCart(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra đăng nhập trước khi thêm vào giỏ
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            session = request.getSession();

            // Lưu URL đầy đủ để redirect sau khi đăng nhập
            String referer = request.getHeader("Referer");
            if (referer == null || referer.isEmpty()) {
                referer = request.getContextPath() + "/products";
            }

            // Lưu cả productId để sau khi đăng nhập có thể thêm vào giỏ
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");
            String action = request.getParameter("action");

            // Tạo URL redirect với đầy đủ tham số
            String redirectUrl = referer;
            if (productId != null && action != null) {
                // Nếu đang thêm sản phẩm, redirect về trang chi tiết sản phẩm
                redirectUrl = request.getContextPath() + "/product-detail?id=" + productId;
            }

            session.setAttribute("redirectAfterLogin", redirectUrl);
            session.setAttribute("loginMessage", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!");

            // Lưu lại thông tin sản phẩm để thêm sau khi đăng nhập
            session.setAttribute("pendingProductId", productId);
            session.setAttribute("pendingQuantity", quantity);
            session.setAttribute("pendingAction", action);

            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("update".equals(action)) {
            updateCart(request, response);
        } else {
            doGet(request, response);
        }
    }

    // Sửa lại method addToCart, thêm context path
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1;

            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null && !quantityParam.isEmpty()) {
                quantity = Integer.parseInt(quantityParam);
                if (quantity < 1) {
                    quantity = 1;
                }
            }

            // Lấy giỏ hàng từ session
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }

            // Thêm hoặc cập nhật sản phẩm
            if (cart.containsKey(productId)) {
                cart.put(productId, cart.get(productId) + quantity);
            } else {
                cart.put(productId, quantity);
            }

            session.setAttribute("cart", cart);

            // Lấy thông báo thành công
            ProductDAO dao = new ProductDAO();
            Product product = dao.getById(productId);
            String productName = (product != null) ? product.getName() : "Sản phẩm";

            session.setAttribute("cartMessage", "Đã thêm " + productName + " vào giỏ hàng!");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cartError", "Có lỗi xảy ra khi thêm vào giỏ hàng!");
        }

        // Chuyển về trang trước đó
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.remove(productId);
            session.setAttribute("cart", cart);
            session.setAttribute("cartMessage", "Đã xóa sản phẩm khỏi giỏ hàng!");
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null) {
            String[] productIds = request.getParameterValues("productId");
            String[] quantities = request.getParameterValues("quantity");

            if (productIds != null && quantities != null) {
                for (int i = 0; i < productIds.length; i++) {
                    int productId = Integer.parseInt(productIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    if (quantity <= 0) {
                        cart.remove(productId);
                    } else {
                        cart.put(productId, quantity);
                    }
                }
            }

            session.setAttribute("cart", cart);
            session.setAttribute("cartMessage", "Đã cập nhật giỏ hàng!");
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        session.setAttribute("cartMessage", "Đã xóa toàn bộ giỏ hàng!");

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void displayCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null && !cart.isEmpty()) {
            try {
                ProductDAO dao = new ProductDAO();
                Map<Product, Integer> cartItems = new HashMap<>();
                double total = 0;

                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    Product product = dao.getById(entry.getKey());
                    if (product != null) {
                        cartItems.put(product, entry.getValue());
                        total += product.getPrice() * entry.getValue();
                    }
                }

                request.setAttribute("cartItems", cartItems);
                request.setAttribute("total", total);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("cartError", "Lỗi tải dữ liệu giỏ hàng!");
            }
        }

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
