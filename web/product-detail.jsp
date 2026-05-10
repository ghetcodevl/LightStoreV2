<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>${product.name} - DecorLamp</title>
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

        /* Reset */
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

        /* Container */
        .container {
            margin-top: 65px;
            max-width: 95%;
            margin-left: auto;
            margin-right: auto;
            background: var(--white);
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        /* Search Form */
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

        /* Left Menu */
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

        /* Product Detail */
        .product-detail-container {
            display: flex;
            gap: 40px;
            padding: 20px;
            background: var(--white);
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }
        .product-detail-image {
            flex: 1;
            text-align: center;
        }
        .product-detail-image img {
            max-width: 100%;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .product-detail-info {
            flex: 1;
        }
        .product-detail-info h1 {
            font-size: 28px;
            color: var(--text-dark);
            margin-bottom: 15px;
        }
        .product-price {
            font-size: 28px;
            color: var(--primary-color);
            font-weight: bold;
            margin: 20px 0;
            padding: 10px 0;
            border-top: 1px solid var(--border-color);
            border-bottom: 1px solid var(--border-color);
        }
        .product-description {
            margin: 20px 0;
            line-height: 1.8;
            color: var(--text-gray);
        }
        .product-description h3 {
            color: var(--text-dark);
            margin-bottom: 10px;
        }
        .product-meta {
            margin: 20px 0;
            padding: 15px;
            background: var(--bg-gray);
            border-radius: 8px;
        }
        .quantity-box {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 20px 0;
        }
        .quantity-box label {
            font-weight: bold;
        }
        .quantity-box input {
            width: 70px;
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            text-align: center;
        }
        .btn-add-to-cart {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            transition: background 0.3s;
        }
        .btn-add-to-cart:hover {
            background: var(--primary-dark);
        }
        .btn-buy-now {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 8px;
            margin-left: 10px;
            transition: background 0.3s;
        }
        .btn-buy-now:hover {
            background: #218838;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--primary-color);
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
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

        @media (max-width: 768px) {
            .main-content { flex-direction: column; }
            .left-menu { width: 100%; }
            .product-detail-container { flex-direction: column; }
            .footer-grid { grid-template-columns: repeat(2, 1fr); }
            .search-form input { width: 150px; }
        }
        @media (max-width: 480px) {
            .footer-grid { grid-template-columns: 1fr; text-align: center; }
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
        <!-- Left Sidebar -->
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

        <!-- Content -->
        <div class="content">
            <div class="content-title">CHI TIẾT SẢN PHẨM</div>

            <c:if test="${not empty sessionScope.cartMessage}">
                <div class="message message-success">
                    ${sessionScope.cartMessage}
                    <c:remove var="cartMessage" scope="session"/>
                </div>
            </c:if>

            <div class="product-detail-container">
                <div class="product-detail-image">
                    <img src="${product.image}" alt="${product.name}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                </div>
                <div class="product-detail-info">
                    <h1>${product.name}</h1>
                    <div class="product-price">
                        <fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ
                    </div>
                    <div class="product-description">
                        <h3>Mô tả sản phẩm:</h3>
                        <p>${product.description != null ? product.description : 'Chưa có mô tả cho sản phẩm này.'}</p>
                    </div>
                    <div class="product-meta">
                        <p><strong>Mã sản phẩm:</strong> #${product.id}</p>
                        <c:if test="${not empty product.tag}">
                            <p><strong>Danh mục:</strong> 
                                <c:choose>
                                    <c:when test="${product.tag == 'new'}">Hàng mới</c:when>
                                    <c:when test="${product.tag == 'bestseller'}">Bán chạy</c:when>
                                    <c:when test="${product.tag == 'sale'}">Giảm giá</c:when>
                                    <c:otherwise>${product.tag}</c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>
                    </div>
                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${product.id}">
                        <div class="quantity-box">
                            <label>Số lượng:</label>
                            <input type="number" name="quantity" value="1" min="1" max="99">
                        </div>
                        <div>
                            <button type="submit" class="btn-add-to-cart">🛒 Thêm vào giỏ hàng</button>
                            <button type="button" class="btn-buy-now" onclick="buyNow()">💳 Mua ngay</button>
                        </div>
                    </form>
                    <a href="${pageContext.request.contextPath}/products" class="back-link">← Quay lại danh sách sản phẩm</a>
                </div>
            </div>
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

<script>
    function buyNow() {
        var quantity = document.querySelector('input[name="quantity"]').value;
        var productId = ${product.id};
        window.location.href = '${pageContext.request.contextPath}/buy-now?id=' + productId + '&quantity=' + quantity;
    }
</script>

<!-- Include Chatbot -->
<jsp:include page="chatbot.jsp" />
</body>
</html>