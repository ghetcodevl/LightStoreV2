<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Đăng nhập - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <style>
               :root {
                --primary-color: #c0392b;      /* Màu đỏ đậm sang trọng */
                --primary-dark: #a93226;
                --primary-light: #e74c3c;
                --text-dark: #1a1a1a;
                --text-gray: #555;
                --text-light: #888;
                --bg-gray: #f8f8f8;
                --border-color: #e0e0e0;
                --white: #ffffff;
                --font-main: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                --font-price: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
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

            /* ========== SEARCH FORM ========== */
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
                transition: 0.3s;
            }
            .search-form button:hover {
                background: var(--primary-dark);
            }

            .search-item {
                margin: 0 10px;
                display: inline-block;
                vertical-align: middle;
            }

            .search-form-header {
                display: flex;
                align-items: center;
                margin: 0 15px;
            }
            .search-form-header input {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 25px 0 0 25px;
                outline: none;
                width: 200px;
                font-size: 13px;
                background: #fff;
            }
            .search-form-header button {
                padding: 8px 15px;
                background: #b8860b;
                color: white;
                border: none;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
                font-size: 13px;
                transition: background 0.3s;
            }
            .search-form-header button:hover {
                background: #9a7209;
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

            .login-container {
                max-width: 450px;
                margin: 50px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .login-container h2 {
                text-align: center;
                color: #ff6600;
                margin-bottom: 30px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: border-color 0.3s;
            }
            .form-group input:focus {
                outline: none;
                border-color: #ff6600;
            }
            .btn-login {
                width: 100%;
                background-color: #ff6600;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .btn-login:hover {
                background-color: #e65c00;
            }
            .register-link {
                text-align: center;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }
            .register-link a {
                color: #ff6600;
                text-decoration: none;
            }
            .register-link a:hover {
                text-decoration: underline;
            }
            .mess {
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 5px;
                text-align: center;
            }
            .mess-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .mess-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .forgot-password {
                text-align: right;
                margin-top: 10px;
            }
            .forgot-password a {
                color: #666;
                font-size: 14px;
                text-decoration: none;
            }
            .forgot-password a:hover {
                color: #ff6600;
            }
            /* ========== FOOTER ========== */
            .footer {
                background: var(--text-dark);
                color: var(--text-light);
                padding: 40px 30px 20px;
                margin-top: 30px;
            }
            .footer-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 30px;
                margin-bottom: 30px;
            }
            .footer-col h3 {
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
            .footer-col ul li a p{
                color: var(--white);
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
        </style>
    </head>
    <body>
        <div class="container">


            <div class="main-menu">
                <ul>
<!--                    <li><a href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>-->
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
            <div class="main-content">
                <div class="left-menu">
                    <div class="menu-title">Danh mục sản phẩm</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn chùm cổ điển</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn chùm Đồng</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn chùm phòng khách</a></li>
                    </ul>
                    <div class="menu-title">Sản phẩm nổi bật</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
                    </ul>
                </div>

                <div class="content">
                    <div class="login-container">
                        <h2>ĐĂNG NHẬP</h2>
                        <c:if test="${param.reset == 'success'}">
                            <div class="message message-success" style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center;">
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
                                <label>Email:</label>
                                <input type="email" name="email" required placeholder="Nhập email của bạn">
                            </div>
                            <div class="form-group">
                                <label>Mật khẩu:</label>
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
                <div class="footer-container">
                    <div class="footer-row">
                        <div class="footer-col">
                            <h3>DECORLAMP</h3>
                            <p class="footer-desc">
                                Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, 
                                đèn cổ điển, đèn đồng... Với thiết kế sang trọng, chất lượng vượt trội.
                            </p>
                        </div>
                        <div class="footer-col">
                            <h3>SẢN PHẨM</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h3>HỖ TRỢ</h3>
                            <ul>
                                <li><a href="#">Hướng dẫn mua hàng</a></li>
                                <li><a href="#">Chính sách vận chuyển</a></li>
                                <li><a href="#">Chính sách đổi trả</a></li>
                                <li><a href="#">Chính sách bảo hành</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h3>THÔNG TIN</h3>
                            <ul class="footer-contact">
                                <li>📞 Hotline: 0965.69.8866</li>
                                <li>📧 Email: decorlamp@gmail.com</li>
                                <li>📍 Hà Nội: Số 8A Phạm Hùng, Mễ Trì</li>
                                <li>📍 TP.HCM: Số 73 Ỷ Lan, Tân Phú</li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>© 2024 DecorLamp. All rights reserved.</p>
                        <p>Nhóm thực hiện: Đặng Minh Quốc, Lại Thế Trường, Lê Anh Tuấn</p>
                    </div>
                </div>
            </footer>
        </div>
    </body>
</html>