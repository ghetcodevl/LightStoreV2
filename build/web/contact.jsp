<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Liên hệ - DecorLamp</title>
        <link rel="stylesheet" href="style.css">
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
        </style>
    </head>
    <body>
        <div class="container">
<!--              ========== SLIDESHOW BANNER ========== 
            <div class="slideshow-container">
                <div class="slide fade">
                    <img src="${pageContext.request.contextPath}/images/banner2.png" alt="Banner 1">
                </div>
                <div class="slide fade">
                    <img src="https://casani.vn/img/g/g94.jpg" alt="Banner 2">
                </div>
                                <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
                                <a class="next" onclick="changeSlide(1)">&#10095;</a>
                                <div class="dots-container">
                                    <span class="dot" onclick="currentSlide(1)"></span>
                                    <span class="dot" onclick="currentSlide(2)"></span>
                                </div>
            </div>-->
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


            <div class="main-content">
                <!-- Left Menu -->
                <div class="left-menu">
                    <div class="menu-title">Danh mục sản phẩm</div>
                    <ul>
                        <li><a href="products?category=1">Đèn Chùm Pha Lê</a></li>
                        <li><a href="products?category=2">Đèn chùm cổ điển</a></li>
                        <li><a href="products?category=3">Đèn chùm Đồng</a></li>
                        <li><a href="products?category=4">Đèn chùm phòng khách</a></li>
                    </ul>
                    <div class="menu-title">Sản phẩm nổi bật</div>
                    <ul>
                        <li><a href="products?tag=new">Hàng mới</a></li>
                        <li><a href="products?tag=bestseller">Bán chạy</a></li>
                        <li><a href="products?tag=sale">Giảm giá</a></li>
                    </ul>
                </div>


                <div class="content">
                    <div class="content-title">LIÊN HỆ VỚI CHÚNG TÔI</div>

                    <c:if test="${not empty error}">
                        <div class="error-message">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="success-message">${success}</div>
                    </c:if>

                    <form action="contact" method="post" class="contact-form">
                        <div class="form-group">
                            <label>Họ và tên:</label>
                            <input type="text" name="name" required>
                        </div>
                        <div class="form-group">
                            <label>Email:</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Nội dung:</label>
                            <textarea name="message" rows="5" required></textarea>
                        </div>
                        <button type="submit">Gửi liên hệ</button>
                    </form>
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
                <!-- Include Chatbot -->
                <jsp:include page="chatbot.jsp" />
                </body>
                </html>