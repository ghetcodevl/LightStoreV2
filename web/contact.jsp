<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Liên hệ - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
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

        .search-form {
            display: flex;
            align-items: center;
            margin-left: 190px;
        }
        .search-form input {
            padding: 8px 12px;
            border: none;
            border-radius: 25px 0 0 25px;
            outline: none;
            width: 280px;
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
            margin-left: auto;
            display: flex;
            align-items: center;
        }
        .cart-info a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }

        /* Contact Form */
        .contact-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 35px;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
        }
        .contact-container h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 20px;
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
        .btn-submit {
            width: 100%;
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
        .error-message, .success-message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        .error-message {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
            .footer-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 480px) {
            .footer-grid { grid-template-columns: 1fr; text-align: center; }
            .contact-container { margin: 20px; padding: 20px; }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Main Menu -->
     <!-- ========== MAIN MENU ========== -->
                <div class="main-menu">
                    <ul>
    <!--                    <li><a href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>-->
                        <li><a href="${pageContext.request.contextPath}/Home">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>

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
                                        <a href="${pageContext.request.contextPath}/admin/dashboard">DASH BOARD</a>
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
            <div class="menu-title">Danh mục sản phẩm</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
            </ul>
            <div class="menu-title">Sản phẩm nổi bật</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
            </ul>
        </div>

        <div class="content">
            <div class="contact-container">
                <h2>📞 LIÊN HỆ VỚI CHÚNG TÔI</h2>
                
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="name" required placeholder="Nhập họ và tên">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required placeholder="example@email.com">
                    </div>
                    <div class="form-group">
                        <label>Nội dung</label>
                        <textarea name="message" rows="5" required placeholder="Nhập nội dung liên hệ..."></textarea>
                    </div>
                    <button type="submit" class="btn-submit">📤 Gửi liên hệ</button>
                </form>
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