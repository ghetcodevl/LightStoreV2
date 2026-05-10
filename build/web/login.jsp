<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Đăng nhập - DecorLamp</title>
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

        /* Login Form */
        .login-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 35px;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
        }
        .login-container h2 {
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
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(192,57,43,0.1);
        }
        .btn-login {
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
        .btn-login:hover {
            background: var(--primary-dark);
        }
        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .mess {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .mess-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .mess-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }
        .forgot-password a {
            color: var(--text-gray);
            font-size: 13px;
            text-decoration: none;
        }
        .forgot-password a:hover {
            color: var(--primary-color);
        }
        .message-success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
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
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Main Menu -->
    <div class="main-menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/Home">Trang chủ</a></li>
            <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
            <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
            <li class="search-form">
                <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex;">
                    <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </form>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
<!--        <div class="left-menu">
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
        </div>-->

        <div class="content">
            <div class="login-container">
                <h2>ĐĂNG NHẬP</h2>
                
                <c:if test="${param.reset == 'success'}">
                    <div class="message-success">
                        ✅ Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.
                    </div>
                </c:if>
                <c:if test="${not empty mess}">
                    <div class="mess mess-error">${mess}</div>
                </c:if>
                <c:if test="${not empty sessionScope.successMess}">
                    <div class="mess mess-success">${sessionScope.successMess}</div>
                    <c:remove var="successMess" scope="session"/>
                </c:if>

                <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required placeholder="Nhập email của bạn">
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <input type="password" name="password" required placeholder="Nhập mật khẩu">
                    </div>
                    <div class="forgot-password">
                        <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="btn-login">Đăng nhập</button>
                </form>

                <div class="register-link">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
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