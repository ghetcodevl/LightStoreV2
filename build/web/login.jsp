<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Đăng nhập - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <style>
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
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Banner -->
            <!--        <div class="banner">
                        <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner" onerror="this.src='https://via.placeholder.com/1200x300?text=DecorLamp'">
                    </div>-->

            <!-- Top Menu -->
            <div class="top-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
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
                        <h2>🔐 ĐĂNG NHẬP</h2>
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
                                <label>📧 Email:</label>
                                <input type="email" name="email" required placeholder="Nhập email của bạn">
                            </div>
                            <div class="form-group">
                                <label>🔒 Mật khẩu:</label>
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
                        <!-- Cột 1: Giới thiệu -->
                        <div class="footer-col">
                            <h3>🎯 SUNDECOR</h3>
                            <p class="footer-desc">
                                Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, 
                                đèn cổ điển, đèn đồng... Với thiết kế sang trọng, chất lượng vượt trội.
                            </p>
                            <div class="footer-social">
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="Instagram" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="Twitter" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/145/145802.png" alt="Zalo" width="30"></a>
                            </div>
                        </div>

                        <!-- Cột 2: Sản phẩm -->
                        <div class="footer-col">
                            <h3>✨ SẢN PHẨM</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng Mới</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Hàng Giảm Giá</a></li>
                            </ul>
                        </div>

                        <!-- Cột 3: Hỗ trợ -->
                        <div class="footer-col">
                            <h3>📞 HỖ TRỢ</h3>
                            <ul>
                                <li><a href="#">Hướng dẫn mua hàng</a></li>
                                <li><a href="#">Chính sách vận chuyển</a></li>
                                <li><a href="#">Chính sách đổi trả</a></li>
                                <li><a href="#">Chính sách bảo hành</a></li>
                                <li><a href="#">Phương thức thanh toán</a></li>
                                <li><a href="#">Câu hỏi thường gặp</a></li>
                            </ul>
                        </div>

                        <!-- Cột 4: Thông tin liên hệ -->
                        <div class="footer-col">
                            <h3>🏢 THÔNG TIN CÔNG TY</h3>
                            <ul class="footer-contact">
                                <li><strong>Công ty Cổ phần DecorLamp</strong></li>
                                <li>MST: 0105875457</li>
                                <li>📞 Hotline: 0965.69.8866</li>
                                <li>📧 Email: decorlamp@gmail.com</li>
                                <li>📍 Showroom 1: Số 8A Phạm Hùng, P. Mễ Trì, Q. Nam Từ Liêm, HN</li>
                                <li>📍 Showroom 2: Số 73 Ỷ Lan, P. Hiệp Tân, Q. Tân Phú, TP.HCM</li>
                            </ul>
                        </div>
                    </div>

                    <!-- Form đăng ký nhận mã giảm giá -->
                    <div class="footer-newsletter">
                        <div class="newsletter-content">
                            <h3>🎁 ĐĂNG KÝ NHẬN MÃ GIẢM GIÁ</h3>
                            <p>Nhận ưu đãi 10% cho đơn hàng đầu tiên khi đăng ký nhận bản tin</p>
                            <form action="${pageContext.request.contextPath}/subscribe" method="post" class="newsletter-form">
                                <input type="email" name="email" placeholder="Nhập email của bạn" required>
                                <button type="submit">Đăng ký</button>
                            </form>
                        </div>
                    </div>

                    <!-- Copyright -->
                    <div class="footer-bottom">
                        <p>© 2024 DecorLamp. All rights reserved. Designed by YourTeam</p>
                        <p>Nhóm thực hiện: Đặng Minh Quốc (01/01/2005), Lại Thế Trường (02/02/2005), Lê Anh Tuấn (03/03/2005)</p>
                    </div>
                </div>
            </footer>
        </div>
    </body>
</html>