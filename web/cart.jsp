<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - DecorLamp</title>
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
                            <!-- Thêm một li trống để đẩy các mục sang phải -->
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
            <div class="left-menu">
                <div class="menu-title">Danh mục sản phẩm</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn chùm cổ điển</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn chùm Đồng</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn chùm phòng khách</a></li>
                </ul>
            </div>

            <div class="content">
                <div class="content-title">GIỎ HÀNG CỦA BẠN</div>

                <c:if test="${not empty sessionScope.cartMessage}">
                    <div class="message message-success">${sessionScope.cartMessage}</div>
                    <c:remove var="cartMessage" scope="session"/>
                </c:if>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="empty-cart">
                            <p>🛒 Giỏ hàng của bạn đang trống!</p>
                            <p><a href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="update">
                            <table class="cart-table">
                                <thead>
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${cartItems}" var="item">
                                        <c:set var="product" value="${item.key}"/>
                                        <c:set var="quantity" value="${item.value}"/>
                                        <c:set var="subtotal" value="${product.price * quantity}"/>
                                        <tr>
                                            <td>
                                                <img src="${product.image}" alt="${product.name}" style="width: 60px; height: 60px; object-fit: cover;" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                            </td>
                                            <td>${product.name}</td>
                                            <td><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</td>
                                            <td>
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input type="number" name="quantity" value="${quantity}" min="0" style="width: 60px; padding: 5px;">
                                            </td>
                                            <td><fmt:formatNumber value="${subtotal}" pattern="#,##0"/> VNĐ</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/cart?action=remove&productId=${product.id}" 
                                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')"
                                                   style="color: #dc3545; text-decoration: none;">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" style="text-align: right;"><strong>Tổng cộng:</strong></td>
                                        <td colspan="2"><strong><fmt:formatNumber value="${total}" pattern="#,##0"/> VNĐ</strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                            
                            <div style="margin-top: 20px; display: flex; justify-content: space-between;">
                                <div>
                                    <button type="submit" style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;">Cập nhật giỏ hàng</button>
                                    <a href="${pageContext.request.contextPath}/cart?action=clear" 
                                       onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')"
                                       style="background-color: #ffc107; color: #333; padding: 10px 20px; text-decoration: none; border-radius: 5px; margin-left: 10px;">Xóa tất cả</a>
                                </div>
                                <a href="${pageContext.request.contextPath}/checkout" 
                                   style="background-color: #28a745; color: white; padding: 10px 30px; text-decoration: none; border-radius: 5px;">Thanh toán →</a>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
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