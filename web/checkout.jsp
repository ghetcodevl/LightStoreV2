<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Thanh toán - DecorLamp</title>
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

        /* Checkout */
        .checkout-container {
            display: flex;
            gap: 30px;
        }
        .checkout-info {
            flex: 1;
            background: var(--bg-gray);
            padding: 25px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }
        .checkout-info h3 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 20px;
        }
        .checkout-cart {
            flex: 1;
            background: var(--white);
            padding: 25px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }
        .checkout-cart h3 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 20px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
        }
        .form-group input:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(192,57,43,0.1);
        }
        .cart-item {
            display: flex;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid var(--border-color);
        }
        .cart-item img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }
        .total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid var(--primary-color);
        }
        .total strong {
            color: var(--primary-color);
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .btn-submit {
            flex: 2;
            background: var(--primary-color);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-submit:hover {
            background: var(--primary-dark);
        }
        .btn-cancel {
            flex: 1;
            background: #6c757d;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-cancel:hover {
            background: #5a6268;
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
            .checkout-container { flex-direction: column; }
            .footer-grid { grid-template-columns: repeat(2, 1fr); }
            .search-form input { width: 150px; }
            .button-group { flex-direction: column; }
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
                       <a href="${pageContext.request.contextPath}/profile" class="user-name"><i class="fas fa-user"></i> ${sessionScope.user.fullName}</a>
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
            <div class="content-title">THANH TOÁN</div>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <div class="checkout-container">
                <div class="checkout-info">
                    <h3>Thông tin giao hàng</h3>
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        <div class="form-group">
                            <label>Họ và tên *</label>
                            <input type="text" name="fullName" value="${sessionScope.user.fullName}" required>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại *</label>
                            <input type="tel" name="phone" value="${sessionScope.user.phone}" required>
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ giao hàng *</label>
                            <input type="text" name="address" value="${sessionScope.user.address}" required>
                        </div>
                        <div class="form-group">
                            <label>Ghi chú (tùy chọn)</label>
                            <textarea name="note" rows="3" placeholder="Ghi chú về đơn hàng..."></textarea>
                        </div>
                        <div class="button-group">
                            <button type="submit" class="btn-submit">Xác nhận đặt hàng</button>
                            <a href="${pageContext.request.contextPath}/cart" class="btn-cancel">Hủy bỏ</a>
                        </div>
                    </form>
                </div>

                <div class="checkout-cart">
                    <h3>Đơn hàng của bạn</h3>
                    <c:forEach items="${cartItems}" var="item">
                        <div class="cart-item">
                            <img src="${item.key.image}" onerror="this.src='https://via.placeholder.com/60'">
                            <div style="flex:1">
                                <strong>${item.key.name}</strong><br>
                                Số lượng: ${item.value}<br>
                                <fmt:formatNumber value="${item.key.price}" pattern="#,##0"/> VNĐ
                            </div>
                            <div>
                                <strong><fmt:formatNumber value="${item.key.price * item.value}" pattern="#,##0"/> VNĐ</strong>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="total">
                        Tổng cộng: <strong><fmt:formatNumber value="${total}" pattern="#,##0"/> VNĐ</strong>
                    </div>
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
</body>
</html>