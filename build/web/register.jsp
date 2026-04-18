<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
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
            color: #ff6600;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
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
            background-color: #ff6600;
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Banner -->
        <div class="banner">
            <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner">
        </div>

        <!-- Top Menu -->
        <div class="top-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
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