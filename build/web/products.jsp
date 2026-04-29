<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>${title} - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="container">
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
            <!-- Left Menu -->
            <div class="left-menu">
                
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
            </div>

            <!-- Content -->
            <div class="content">
                <div class="content-title">${title}</div>
                
                <!-- Hiển thị số lượng kết quả tìm kiếm -->
                <c:if test="${not empty param.keyword}">
                    <div class="search-result-info">
                        🔍 Tìm thấy <strong>${fn:length(listP)}</strong> sản phẩm cho từ khóa "<strong>${param.keyword}</strong>"
                    </div>
                </c:if>

                <div class="product-list">
                    <c:forEach items="${listP}" var="p">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <img src="${p.image}" alt="${p.name}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                <h4>${p.name}</h4>
                                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                            </a>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty listP}">
                        <div class="no-result">
                            <p>😅 Không tìm thấy sản phẩm nào</p>
                            <p>Vui lòng thử lại với từ khóa khác!</p>
                        </div>
                    </c:if>
                </div>

                <!-- Phân trang -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage-1}&keyword=${param.keyword}&category=${categoryFilter}&tag=${tagFilter}">« Trước</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&keyword=${param.keyword}&category=${categoryFilter}&tag=${tagFilter}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage+1}&keyword=${param.keyword}&category=${categoryFilter}&tag=${tagFilter}">Sau »</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-container">
                <div class="footer-row">
                    <div class="footer-col">
                        <h3>🎯 DECORLAMP</h3>
                        <p class="footer-desc">
                            Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, 
                            đèn cổ điển, đèn đồng... Với thiết kế sang trọng, chất lượng vượt trội.
                        </p>
                    </div>
                    <div class="footer-col">
                        <h3>✨ SẢN PHẨM</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>📞 HỖ TRỢ</h3>
                        <ul>
                            <li><a href="#">Hướng dẫn mua hàng</a></li>
                            <li><a href="#">Chính sách vận chuyển</a></li>
                            <li><a href="#">Chính sách đổi trả</a></li>
                            <li><a href="#">Chính sách bảo hành</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>🏢 THÔNG TIN</h3>
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