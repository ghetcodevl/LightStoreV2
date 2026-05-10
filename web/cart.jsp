<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Giỏ hàng - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #c0392b;
            --primary-dark: #a93226;
            --text-dark: #1a1a1a;
            --text-gray: #555;
            --bg-gray: #f8f8f8;
            --border-color: #e0e0e0;
            --white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f0;
            color: var(--text-dark);
            margin: 0;
            padding: 0;
        }

        /* Main Menu Fixed */
        .main-menu {
            background: var(--text-dark);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }
        .main-menu ul {
            list-style: none;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 25px;
            margin: 0;
            flex-wrap: wrap;
            max-width: 1400px;
            margin: 0 auto;
        }
        .main-menu li a {
            display: block;
            color: var(--white);
            padding: 15px 25px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            transition: 0.3s;
        }
        .main-menu li a:hover {
            background: var(--primary-color);
        }

        .container {
            margin-top: 65px;
            max-width: 95%;
            margin-left: auto;
            margin-right: auto;
            background: var(--white);
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .search-form {
            display: flex;
            align-items: center;
            margin-left: auto;
        }
        .search-form input {
            padding: 8px 12px;
            border: none;
            border-radius: 25px 0 0 25px;
            outline: none;
            width: 250px;
        }
        .search-form button {
            padding: 8px 15px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 0 25px 25px 0;
            cursor: pointer;
        }
        .cart-info {
            display: flex;
            align-items: center;
            margin-left: 15px;
        }
        .cart-info a {
            color: white;
            text-decoration: none;
            margin: 0 5px;
            padding: 8px 16px;
            border-radius: 20px;
        }
        .cart-info .user-name {
            background: var(--primary-color);
        }
        .cart-info .logout-btn {
            background: #555;
        }
        .cart-info .logout-btn:hover {
            background: var(--primary-color);
        }

        .main-content {
            display: flex;
            gap: 30px;
            padding: 30px;
        }
        .left-menu {
            width: 260px;
            background: var(--bg-gray);
            padding: 15px;
            border-radius: 10px;
        }
        .menu-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-dark);
            padding: 10px 0;
            margin-bottom: 15px;
            border-bottom: 2px solid var(--primary-color);
            display: inline-block;
        }
        .left-menu ul {
            list-style: none;
            margin-bottom: 20px;
        }
        .left-menu li a {
            display: block;
            padding: 8px 0;
            color: var(--text-gray);
            text-decoration: none;
            transition: all 0.3s;
        }
        .left-menu li a:hover {
            color: var(--primary-color);
            padding-left: 8px;
        }
        .content {
            flex: 1;
        }
        .content-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-dark);
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-color);
        }

        /* Messages */
        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .message-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 60px;
            background: var(--bg-gray);
            border-radius: 12px;
        }
        .empty-cart p {
            margin: 10px 0;
            color: var(--text-gray);
        }
        .empty-cart a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        /* Cart Table - Improved */
        .cart-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: var(--white);
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px;
        }
        .cart-table th {
            background: var(--bg-gray);
            padding: 15px 12px;
            text-align: center;
            font-weight: 600;
            color: var(--text-dark);
            border-bottom: 2px solid var(--border-color);
        }
        .cart-table td {
            padding: 15px 12px;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }
        .cart-table .product-cell {
            display: flex;
            align-items: center;
            gap: 15px;
            text-align: left;
        }
        .cart-table .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .cart-table .product-name {
            font-weight: 500;
            color: var(--text-dark);
            text-decoration: none;
        }
        .cart-table .product-name:hover {
            color: var(--primary-color);
        }
        .cart-table .price {
            color: var(--primary-color);
            font-weight: 600;
        }
        .cart-table .quantity-input {
            width: 70px;
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            text-align: center;
            font-size: 14px;
        }
        .cart-table .quantity-input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        .cart-table .subtotal {
            font-weight: 600;
            color: var(--primary-color);
        }
        .cart-table .remove-link {
            color: #dc3545;
            text-decoration: none;
            font-size: 20px;
            transition: all 0.3s;
            display: inline-block;
        }
        .cart-table .remove-link:hover {
            transform: scale(1.1);
            color: #a71d2a;
        }

        /* Cart Summary */
        .cart-summary {
            margin-top: 30px;
            background: var(--bg-gray);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .cart-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .btn-update {
            background: var(--primary-color);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.3s;
        }
        .btn-update:hover {
            background: var(--primary-dark);
        }
        .btn-clear {
            background: #6c757d;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: background 0.3s;
            display: inline-block;
        }
        .btn-clear:hover {
            background: #5a6268;
        }
        .cart-total {
            text-align: right;
        }
        .cart-total span {
            font-size: 14px;
            color: var(--text-gray);
        }
        .cart-total .total-amount {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
        }
        .btn-checkout {
            background: #28a745;
            color: white;
            padding: 12px 35px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: background 0.3s;
            display: inline-block;
        }
        .btn-checkout:hover {
            background: #218838;
        }

        /* Footer */
        .footer {
            background: var(--text-dark);
            color: var(--text-gray);
            padding: 40px 30px 20px;
            margin-top: 30px;
        }
        .footer-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            margin-bottom: 30px;
        }
        .footer-col h4 {
            color: var(--white);
            font-size: 16px;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid var(--primary-color);
            display: inline-block;
        }
        .footer-col ul {
            list-style: none;
        }
        .footer-col ul li {
            margin-bottom: 8px;
        }
        .footer-col ul li a {
            color: var(--text-gray);
            text-decoration: none;
            transition: 0.3s;
        }
        .footer-col ul li a:hover {
            color: var(--primary-color);
            padding-left: 5px;
        }
        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #333;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content { flex-direction: column; }
            .left-menu { width: 100%; }
            .cart-summary { flex-direction: column; text-align: center; }
            .cart-actions { justify-content: center; }
            .cart-total { text-align: center; }
            .footer-grid { grid-template-columns: repeat(2, 1fr); }
            .search-form input { width: 150px; }
            .cart-table .product-cell { flex-direction: column; text-align: center; }
            .cart-table td { text-align: center; }
        }
        @media (max-width: 480px) {
            .footer-grid { grid-template-columns: 1fr; text-align: center; }
            .empty-cart { padding: 40px 20px; }
            .btn-update, .btn-clear, .btn-checkout { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Main Menu -->
    <div class="main-menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/Home">TRANG CHỦ</a></li>
            <li><a href="${pageContext.request.contextPath}/products">SẢN PHẨM</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">LIÊN HỆ</a></li>
            <li><a href="${pageContext.request.contextPath}/cart">GIỎ HÀNG</a></li>
            <li class="search-form">
                <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex;">
                    <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </form>
            </li>
            <div class="cart-info">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard">DASHBOARD</a>
                        </c:if>
                        <a href="#" class="user-name"><i class="fas fa-user"></i> ${sessionScope.user.fullName}</a>
                        <a href="#" onclick="confirmLogout(event)" class="logout-btn">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/LoginServlet">Đăng nhập</a>
                        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </ul>
    </div>

    <script>
        function confirmLogout(event) {
            event.preventDefault();
            if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                window.location.href = '${pageContext.request.contextPath}/logout';
            }
        }
    </script>

    <!-- Main Content -->
    <div class="main-content">
        <div class="left-menu">
            <div class="menu-title">DANH MỤC SẢN PHẨM</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
            </ul>
            <div class="menu-title">SẢN PHẨM NỔI BẬT</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
            </ul>
        </div>

        <div class="content">
            <div class="content-title">🛒 GIỎ HÀNG CỦA BẠN</div>

            <c:if test="${not empty sessionScope.cartMessage}">
                <div class="message message-success">${sessionScope.cartMessage}</div>
                <c:remove var="cartMessage" scope="session"/>
            </c:if>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="empty-cart">
                        <p>🛒 Giỏ hàng của bạn đang trống!</p>
                        <p><a href="${pageContext.request.contextPath}/products">→ Tiếp tục mua sắm</a></p>
                    </div>
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="update">
                        
                        <div class="cart-wrapper">
                            <table class="cart-table">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th></th>
                                     </thead>
                                <tbody>
                                    <c:forEach items="${cartItems}" var="item">
                                        <c:set var="product" value="${item.key}"/>
                                        <c:set var="quantity" value="${item.value}"/>
                                        <c:set var="subtotal" value="${product.price * quantity}"/>
                                        <tr>
                                            <td>
                                                <div class="product-cell">
                                                    <img class="product-img" src="${product.image}" alt="${product.name}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}" class="product-name">${product.name}</a>
                                                </div>
                                            </td>
                                            <td class="price"><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</td>
                                            <td>
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input class="quantity-input" type="number" name="quantity" value="${quantity}" min="0" max="99">
                                            </td>
                                            <td class="subtotal"><fmt:formatNumber value="${subtotal}" pattern="#,##0"/> VNĐ</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${product.id}" 
                                                   class="remove-link" 
                                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="cart-summary">
                            <div class="cart-actions">
                                <button type="submit" class="btn-update"><i class="fas fa-sync-alt"></i> Cập nhật giỏ hàng</button>
                                <a href="${pageContext.request.contextPath}/cart?action=clear" 
                                   class="btn-clear"
                                   onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                    <i class="fas fa-trash-alt"></i> Xóa tất cả
                                </a>
                            </div>
                            <div class="cart-total">
                                <span>Tổng cộng:</span>
                                <div class="total-amount"><fmt:formatNumber value="${total}" pattern="#,##0"/> VNĐ</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout"><i class="fas fa-credit-card"></i> Thanh toán →</a>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-grid">
            <div class="footer-col">
                <h4>DECORLAMP</h4>
                <p style="margin-top: 10px;">Chuyên cung cấp đèn trang trí cao cấp, đèn chùm pha lê, đèn cổ điển, đèn đồng.</p>
            </div>
            <div class="footer-col">
                <h4>SẢN PHẨM</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>HỖ TRỢ</h4>
                <ul>
                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                    <li><a href="#">Chính sách vận chuyển</a></li>
                    <li><a href="#">Chính sách bảo hành</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>LIÊN HỆ</h4>
                <ul>
                    <li><i class="fas fa-phone"></i> 0868.506.503</li>
                    <li><i class="fas fa-phone"></i> 0981.983.003</li>
                    <li><i class="fas fa-envelope"></i> decorlamp@gmail.com</li>
                    <li><i class="fas fa-map-marker-alt"></i> Số 8A Phạm Hùng, Hà Nội</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2024 DecorLamp. All rights reserved.</p>
            <p>Nhóm thực hiện: Đặng Minh Quốc, Lại Thế Trường, Lê Anh Tuấn</p>
        </div>
    </footer>
</div>

<!-- Include Chatbot -->
<jsp:include page="chatbot.jsp" />
</body>
</html>