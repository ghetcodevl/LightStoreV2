<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Thanh toán - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .checkout-container {
            display: flex;
            gap: 30px;
            padding: 20px;
        }
        .checkout-info {
            flex: 1;
            background: #f9f5ed;
            padding: 20px;
            border-radius: 10px;
        }
        .checkout-cart {
            flex: 1;
            background: #fffdf9;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e8d5a8;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #8b6914;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #e8d5a8;
            border-radius: 5px;
        }
        .btn-submit {
            background: linear-gradient(135deg, #d4a017 0%, #b8860b 100%);
            color: #1a1510;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .btn-cancel {
            background: linear-gradient(135deg, #8b6914 0%, #6b4e0a 100%);
            color: #e8d5a8;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-cancel:hover {
            background: linear-gradient(135deg, #6b4e0a 0%, #4a3506 100%);
        }
        .cart-item {
            display: flex;
            gap: 15px;
            padding: 10px 0;
            border-bottom: 1px solid #e8d5a8;
        }
        .cart-item img {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        .total {
            text-align: right;
            font-size: 20px;
            margin-top: 20px;
            padding-top: 10px;
            border-top: 2px solid #b8860b;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .button-group .btn-submit {
            flex: 2;
            margin-bottom: 0;
        }
        .button-group .btn-cancel {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="container">
<!--        <div class="banner">
            <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner">
        </div>-->

        <div class="top-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home">🏠 Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/products">✨ Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">📞 Liên hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li style="flex: 1;"></li>
                            <!-- Đã đăng nhập -->
                            <li><span class="user-name">👤 ${sessionScope.user.fullName}</span></li>
                            <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">🚪 Đăng xuất</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="right-menu"><a href="${pageContext.request.contextPath}/LoginServlet">🔐 Đăng nhập</a></li>
                        <li class="right-menu"><a href="${pageContext.request.contextPath}/register">📝 Đăng ký</a></li>
                    </c:otherwise>
                </c:choose>
                        
            </ul>
        </div>

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
                <div class="content-title">📋 THANH TOÁN</div>
                
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>
                
                <div class="checkout-container">
                    <!-- Form thông tin giao hàng -->
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
                            
                            <!-- Nhóm nút: Xác nhận và Hủy -->
                            <div class="button-group">
                                <button type="submit" class="btn-submit">✅ Xác nhận đặt hàng</button>
                                <a href="${pageContext.request.contextPath}/cart" class="btn-cancel">❌ Hủy bỏ</a>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Thông tin giỏ hàng -->
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
                            Tổng cộng: <strong style="color:#b8860b"><fmt:formatNumber value="${total}" pattern="#,##0"/> VNĐ</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="footer-container">
                <div class="footer-row">
                    <div class="footer-col">
                        <h3>🎯 SUNDECOR</h3>
                        <p class="footer-desc">Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê...</p>
                    </div>
                    <div class="footer-col">
                        <h3>✨ SẢN PHẨM</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>📞 HỖ TRỢ</h3>
                        <ul>
                            <li><a href="#">Hướng dẫn mua hàng</a></li>
                            <li><a href="#">Chính sách vận chuyển</a></li>
                            <li><a href="#">Chính sách đổi trả</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>🏢 THÔNG TIN CÔNG TY</h3>
                        <ul class="footer-contact">
                            <li>📞 Hotline: 0965.69.8866</li>
                            <li>📧 Email: decorlamp@gmail.com</li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>© 2024 DecorLamp. All rights reserved.</p>
                     <p>Nhóm thực hiện: Đặng Minh Quốc (01/01/2005), Lại Thế Trường (02/02/2005), Lê Anh Tuấn (03/03/2005)</p>
                </div>
            </div>
        </div>
    </div>

    <script>
    function confirmLogout(event) {
        event.preventDefault();
        if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
            window.location.href = '${pageContext.request.contextPath}/logout';
        }
    }
    </script>
</body>
</html>