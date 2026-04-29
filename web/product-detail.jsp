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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <style>
            .product-detail-container {
                display: flex;
                gap: 40px;
                padding: 20px;
                background: white;
                border-radius: 8px;
            }

            .product-detail-image {
                flex: 1;
                text-align: center;
            }

            .product-detail-image img {
                max-width: 100%;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .product-detail-info {
                flex: 1;
            }

            .product-detail-info h1 {
                font-size: 28px;
                color: #333;
                margin-bottom: 15px;
            }

            .product-price {
                font-size: 28px;
                color: #ff6600;
                font-weight: bold;
                margin: 20px 0;
                padding: 10px 0;
                border-top: 1px solid #ddd;
                border-bottom: 1px solid #ddd;
            }

            .product-description {
                margin: 20px 0;
                line-height: 1.8;
                color: #666;
            }

            .product-description h3 {
                color: #333;
                margin-bottom: 10px;
            }

            .product-meta {
                margin: 20px 0;
                padding: 15px;
                background-color: #f9f9f9;
                border-radius: 5px;
            }

            .product-meta p {
                margin: 5px 0;
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
                border: 1px solid #ddd;
                border-radius: 4px;
                text-align: center;
            }

            .btn-add-to-cart {
                background-color: #ff6600;
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 18px;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .btn-add-to-cart:hover {
                background-color: #e65c00;
            }

            .btn-buy-now {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 18px;
                cursor: pointer;
                border-radius: 5px;
                margin-top: 10px;
                transition: background-color 0.3s;
            }

            .btn-buy-now:hover {
                background-color: #218838;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #007bff;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .message {
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 4px;
            }

            .message-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .message-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
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
                    <li><a href="${pageContext.request.contextPath}/about">📖 Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home">🏠 Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">✨ Sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">📞 Liên hệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a></li>

                    <!-- FORM TÌM KIẾM - PHẢI ĐẶT TRONG THẺ LI -->
                    <li style="margin: 0 15px; display: inline-block; list-style: none;">
                        <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex; align-items: center; margin: 0; padding: 0;">
                            <input type="text" name="keyword" placeholder="🔍 Tìm kiếm sản phẩm..." value="${param.keyword}" 
                                   style="padding: 8px 12px; border: 1px solid #ddd; border-radius: 25px 0 0 25px; outline: none; width: 200px; font-size: 13px; background: white;">
                            <button type="submit" style="padding: 8px 15px; background: #b8860b; color: white; border: none; border-radius: 0 25px 25px 0; cursor: pointer; font-size: 13px;">
                                Tìm
                            </button>
                        </form>
                    </li>

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                                </c:if>
                            <!-- Đẩy các mục sang phải -->
                            <li style="flex: 1;"></li>
                            <!-- Đã đăng nhập -->
                            <li><span class="user-name">👤 ${sessionScope.user.fullName}</span></li>
                            <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">🚪 Đăng xuất</a></li>
                            </c:when>
                            <c:otherwise>
                            <li style="flex: 1;"></li>
                            <!-- Chưa đăng nhập -->
                            <li><a href="${pageContext.request.contextPath}/LoginServlet">🔐 Đăng nhập</a></li>
                            <li><a href="${pageContext.request.contextPath}/register">📝 Đăng ký</a></li>
                            </c:otherwise>
                        </c:choose>
                </ul>
            </div>

            <div class="main-content">
                <!-- Left Menu -->
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

                <!-- Content -->
                <div class="content">
                    <div class="content-title">CHI TIẾT SẢN PHẨM</div>

                    <!-- Hiển thị thông báo -->
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
                                    <button type="submit" class="btn-add-to-cart">
                                        🛒 Thêm vào giỏ hàng
                                    </button>
                                    <button type="button" class="btn-buy-now" onclick="buyNow()">💳 Mua ngay</button>

                                    <script>
                                        function buyNow() {
                                            var quantity = document.querySelector('input[name="quantity"]').value;
                                            var productId = ${product.id};
                                            window.location.href = '${pageContext.request.contextPath}/buy-now?id=' + productId + '&quantity=' + quantity;
                                        }
                                    </script>
                                </div>
                            </form>

                            <a href="${pageContext.request.contextPath}/products" class="back-link">
                                ← Quay lại danh sách sản phẩm
                            </a>
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

         <!-- Include Chatbot -->
        <jsp:include page="chatbot.jsp" />
    </body>
</html>