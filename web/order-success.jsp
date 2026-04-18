<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <!-- ← THÊM DÒNG NÀY -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="container">
        <div class="banner">
            <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner">
        </div>
        
        <!-- Top Menu -->
        <div class="top-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home">🏠 Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/products">✨ Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">📞 Liên hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a></li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li style="flex: 1;"></li>
                        <li><span class="user-name">👤 ${sessionScope.user.fullName}</span></li>
                        <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">🚪 Đăng xuất</a></li>
                    </c:when>
                    <c:otherwise>
                        <li style="flex: 1;"></li>
                        <li><a href="${pageContext.request.contextPath}/LoginServlet">🔐 Đăng nhập</a></li>
                        <li><a href="${pageContext.request.contextPath}/register">📝 Đăng ký</a></li>
                    </c:otherwise>
                </c:choose>
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
            <div class="content" style="text-align: center; padding: 50px;">
                <h1 style="color: #b8860b;">✅ ĐẶT HÀNG THÀNH CÔNG!</h1>
                <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được ghi nhận.</p>
                <p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
                <br>
                <a href="${pageContext.request.contextPath}/Home" style="background: #b8860b; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Tiếp tục mua sắm</a>
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
</body>
</html>