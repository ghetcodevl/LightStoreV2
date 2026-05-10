<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Đăng ký - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
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

            .register-container {
                max-width: 550px;
                margin: 30px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .register-container h2 {
                text-align: center;
                color: var(--primary-color);
                margin-bottom: 30px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: var(--primary-color);
            }
            .form-group input, .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }
            .form-group input:focus, .form-group textarea:focus {
                outline: none;
                border-color: #ff6600;
            }
            .form-row {
                display: flex;
                gap: 15px;
            }
            .form-row .form-group {
                flex: 1;
            }
            .btn-register {
                width: 100%;
                background-color: var(--primary-color);
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
            }
            .btn-register:hover {
                background-color: #e65c00;
            }
            .login-link {
                text-align: center;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }
            .login-link a {
                color: #ff6600;
                text-decoration: none;
            }
            .mess {
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 5px;
                text-align: center;
            }
            .mess-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .required {
                color: red;
            }
            /* ========== FOOTER ========== */
            /*            .footer {
                            background: #1a1a1a;
                            color: #e8d5a8;
                            margin-top: 40px;
                            border-top: 3px solid var(--primary-color);
                        }
            
                        .footer-col h3 {
                            color: var(--primary-color);
                            border-bottom: 2px solid var(--primary-color);
                        }
            
                        .footer-col ul li a:hover {
                            color: var(--primary-color);
                        }*/
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

                    <li class="search-form">
                        <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex;">
                            <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm..." value="${param.keyword}">
                            <button type="submit"><i class="fas fa-search"></i></button>
                        </form>
                    </li>


                </ul>
            </div>



            <!--        <div class="main-content">
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
                        </div>-->

            <div class="content">
                <div class="register-container">
                    <h2>📝 ĐĂNG KÝ TÀI KHOẢN</h2>

                    <c:if test="${not empty mess}">
                        <div class="mess mess-error">${mess}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                        <div class="form-group">
                            <label>Họ và tên: <span class="required">*</span></label>
                            <input type="text" name="fullname" required placeholder="Nhập họ và tên">
                        </div>

                        <div class="form-group">
                            <label>Email: <span class="required">*</span></label>
                            <input type="email" name="email" required placeholder="example@email.com">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Mật khẩu: <span class="required">*</span></label>
                                <input type="password" name="password" required placeholder="Ít nhất 6 ký tự">
                            </div>
                            <div class="form-group">
                                <label>Xác nhận mật khẩu: <span class="required">*</span></label>
                                <input type="password" name="repassword" required placeholder="Nhập lại mật khẩu">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Số điện thoại:</label>
                                <input type="tel" name="phone" placeholder="0123456789">
                            </div>
                            <div class="form-group">
                                <label>Địa chỉ:</label>
                                <input type="text" name="address" placeholder="Số nhà, đường, quận/huyện">
                            </div>
                        </div>

                        <button type="submit" class="btn-register">Đăng ký</button>
                    </form>

                    <div class="login-link">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
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
                        <li><a href="#">Phương thức thanh toán</a></li>
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

    </body>
</html>