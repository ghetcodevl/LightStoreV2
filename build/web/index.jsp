<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<!--<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>DecorLamp - Đèn Trang Trí Cao Cấp</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <div class="container">
             Banner 
            <div class="banner">
                <img src="images/banner.jpg" alt="DecorLamp Banner">
            </div>

             Top Menu 
            <div class="top-menu">
                <ul>
                    <li><a href="Home">Trang chủ</a></li>
                    <li><a href="ProductListServlet">Sản phẩm</a></li>
                    <li><a href="ContactServlet">Liên hệ</a></li>
                    <li><a href="CartServlet">Giỏ hàng</a></li>
<c:choose>
    <c:when test="${not empty sessionScope.user}">
    <li><a href="logout">Đăng xuất (${sessionScope.user.fullName})</a></li>
    <li><a href="cart.jsp">Giỏ hàng</a></li>
    </c:when>
    <c:otherwise>
    <li><a href="LoginServlet">Đăng nhập</a></li>
    <li><a href="register.jsp">Đăng ký</a></li>
    </c:otherwise>
</c:choose>
</ul>
</div>

<div class="main-content">
Left Menu 
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

Content 
<div class="content">
<div class="content-title">SẢN PHẨM NỔI BẬT</div>

<div class="product-section">
<h3>Hàng mới</h3>
<div class="product-list">
<c:forEach items="${listP}" var="p">
    <c:if test="${p.tag == 'new'}">
        <div class="product-item">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                <img src="${p.image}" alt="${p.name}" onerror="this.src='images/no-image.jpg'">
                <h4>${p.name}</h4>
                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
            </a>
        </div>
    </c:if>
</c:forEach>
</div>
</div>

<div class="product-section">
<h3>Bán chạy</h3>
<div class="product-list">
<c:forEach items="${listP}" var="p">
    <c:if test="${p.tag == 'bestseller'}">
        <div class="product-item">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                <img src="${p.image}" alt="${p.name}" onerror="this.src='images/no-image.jpg'">
                <h4>${p.name}</h4>
                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
            </a>
        </div>
    </c:if>
</c:forEach>
</div>
</div>

<div class="product-section">
<h3>Giảm giá</h3>
<div class="product-list">
<c:forEach items="${listP}" var="p">
    <c:if test="${p.tag == 'sale'}">
        <div class="product-item">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                <img src="${p.image}" alt="${p.name}" onerror="this.src='images/no-image.jpg'">
                <h4>${p.name}</h4>
                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
            </a>
        </div>
    </c:if>
</c:forEach>
</div>
</div>
</div>
</div>

Footer 
<div class="footer">
Nhóm thực hiện: Nguyễn Văn A (01/01/2000), Trần Thị B (02/02/2000), Lê Văn C (03/03/2000)
</div>
</div>
</body>
</html>-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>DecorLamp - Đèn Trang Trí Cao Cấp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <style>
            /* Hero Section */
            .hero {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 60px 40px;
                text-align: center;
                margin-bottom: 30px;
                border-radius: 10px;
            }
            .hero h1 {
                font-size: 42px;
                margin-bottom: 20px;
            }
            .hero p {
                font-size: 18px;
                margin-bottom: 30px;
            }
            .hero .btn-shop {
                background-color: #ff6600;
                color: white;
                padding: 12px 30px;
                text-decoration: none;
                border-radius: 5px;
                font-size: 18px;
                transition: background-color 0.3s;
            }
            .hero .btn-shop:hover {
                background-color: #e65c00;
            }

            /* Featured Banner */
            .featured-banner {
                display: flex;
                gap: 20px;
                margin-bottom: 40px;
            }
            .featured-banner-item {
                flex: 1;
                background: #f9f9f9;
                padding: 30px;
                text-align: center;
                border-radius: 10px;
                transition: transform 0.3s;
            }
            .featured-banner-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .featured-banner-item h3 {
                color: #ff6600;
                margin-bottom: 10px;
            }

            /* Welcome Section */
            .welcome {
                text-align: center;
                padding: 40px;
                background-color: #f5f5f5;
                border-radius: 10px;
                margin-bottom: 30px;
            }
            .welcome h2 {
                color: #333;
                margin-bottom: 15px;
            }
            .welcome p {
                color: #666;
                line-height: 1.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Banner -->
            <div class="banner">
                <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner" onerror="this.src='https://sundecor.vn/wp-content/uploads/2025/06/den-chum-co-dien.jpg'">
            </div>

            <!-- Top Menu -->
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
                        <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm cổ điển</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Chùm phòng khách</a></li>
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
                    <!-- Hero Section -->
                    <div class="hero">
                        <h1>✨ ĐÈN TRANG TRÍ CAO CẤP ✨</h1>
                        <p>Mang ánh sáng sang trọng và đẳng cấp đến không gian sống của bạn</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn-shop">Mua sắm ngay →</a>
                    </div>

                    <!-- Welcome Section -->
                    <div class="welcome">
                        <h2>🏠 Chào mừng đến với DecorLamp</h2>
                        <p>Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, đèn cổ điển, đèn đồng...<br>
                            Với thiết kế sang trọng, chất lượng vượt trội, chúng tôi tự hào mang đến cho bạn không gian sống lung linh và đẳng cấp.</p>
                    </div>

                    <!-- Featured Categories -->
                    <div class="featured-banner">
                        <div class="featured-banner-item">
                            <h3>💎 ĐÈN PHA LÊ</h3>
                            <p>Sang trọng - Lộng lẫy</p>
                        </div>
                        <div class="featured-banner-item">
                            <h3>🏛️ ĐÈN CỔ ĐIỂN</h3>
                            <p>Tinh tế - Hoài cổ</p>
                        </div>
                        <div class="featured-banner-item">
                            <h3>🪙 ĐÈN ĐỒNG</h3>
                            <p>Cao cấp - Bền đẹp</p>
                        </div>
                    </div>

                    <div class="product-section">
                        <h3>🔥 SẢN PHẨM NỔI BẬT</h3>
                        <div class="product-list">
                            <c:forEach items="${listP}" var="p" begin="0" end="26">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="product-section">
                        <h3>🆕 HÀNG MỚI</h3>
                        <div class="product-list">
                            <c:forEach items="${newProducts}" var="p">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200/e8d5a8/8b6914?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                                    </a>
                                </div>
                            </c:forEach>
                            <c:if test="${empty newProducts}">
                                <p style="text-align:center; width:100%;">Chưa có sản phẩm nào trong mục này</p>
                            </c:if>
                        </div>
                    </div>

                    <div class="product-section">
                        <h3>⭐ BÁN CHẠY</h3>
                        <div class="product-list">
                            <c:forEach items="${bestsellerProducts}" var="p">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200/e8d5a8/8b6914?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                                    </a>
                                </div>
                            </c:forEach>
                            <c:if test="${empty bestsellerProducts}">
                                <p style="text-align:center; width:100%;">Chưa có sản phẩm nào trong mục này</p>
                            </c:if>
                        </div>
                    </div>

                    <div class="product-section">
                        <h3>🎯 GIẢM GIÁ</h3>
                        <div class="product-list">
                            <c:forEach items="${saleProducts}" var="p">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200/e8d5a8/8b6914?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</p>
                                    </a>
                                </div>
                            </c:forEach>
                            <c:if test="${empty saleProducts}">
                                <p style="text-align:center; width:100%;">Chưa có sản phẩm nào trong mục này</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========== BLOG / TIN TỨC SECTION ========== -->
            <!-- ========== BLOG / TIN TỨC SECTION ========== -->
            <div class="blog-section">
                <div class="content-title">📰 NHỮNG TIN TỨC, CÁCH LỰA CHỌN ĐÈN TRANG TRÍ</div>

                <div class="blog-list">
                    <!-- Bài viết 1 -->
                    <div class="blog-item">
                        <div class="blog-image">
                            <img src="${pageContext.request.contextPath}/images/blog/phong-thuy.jpg" 
                                 alt="Đèn pha lê phong thủy"
                                 onerror="this.src='https://placehold.co/120x120/e8d5a8/8b6914?text=Phong+Th%E1%BB%A7y'">
                        </div>
                        <div class="blog-content">
                            <h3>💡 Bỏ túi 3 câu hỏi hay gặp khi sử dụng đèn pha lê đúng phong thủy</h3>
                            <p>Hiện nay, có rất nhiều câu hỏi xoay quanh mẫu đèn pha lê được rất nhiều người tiêu dùng quan tâm. Vì chất liệu pha lê tượng trưng cho nguồn năng lượng tích cực, có ý nghĩa phong thủy tốt lành...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>

                    <!-- Bài viết 2 -->
                    <div class="blog-item">
                        <div class="blog-image">
                            <img src="${pageContext.request.contextPath}/images/blog/casani.jpg" 
                                 alt="Casani đèn trang trí"
                                 onerror="this.src='https://placehold.co/120x120/e8d5a8/8b6914?text=Casani'">
                        </div>
                        <div class="blog-content">
                            <h3>🏪 Casani - Thế giới đèn trang trí giá rẻ, chất lượng</h3>
                            <p>Bạn đang muốn mua đèn led trang trí cho căn nhà, văn phòng của mình? Casani chính là một thương hiệu lâu năm, uy tín chuyên phân phối đèn trang trí chính hãng, giá rẻ mà bạn không thể bỏ qua...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>

                    <!-- Bài viết 3 -->
                    <div class="blog-item">
                        <div class="blog-image">
                            <img src="${pageContext.request.contextPath}/images/blog/phoi-mau.jpg" 
                                 alt="Phối màu đèn trang trí"
                                 onerror="this.src='https://placehold.co/120x120/e8d5a8/8b6914?text=Ph%E1%BB%91i+M%C3%A0u'">
                        </div>
                        <div class="blog-content">
                            <h3>🎨 Tổng hợp các cách phối màu đèn trang trí nội thất</h3>
                            <p>Hiện nay nhu cầu sử dụng các loại đèn trang trí ngày càng trở nên phổ biến. Để tăng thêm hiệu quả trang trí thì bạn cần biết cách phối màu đèn trang trí nội thất sao cho phù hợp...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>

                    <!-- Bài viết 4 -->
                    <div class="blog-item">
                        <div class="blog-image">
                            <img src="${pageContext.request.contextPath}/images/blog/van-phong.jpg" 
                                 alt="Đèn văn phòng"
                                 onerror="this.src='https://placehold.co/120x120/e8d5a8/8b6914?text=V%C4%83n+Ph%C3%B2ng'">
                        </div>
                        <div class="blog-content">
                            <h3>🏢 Những lưu ý khi lựa chọn đèn trang trí cho văn phòng</h3>
                            <p>Hiện nay nhiều công ty ưu tiên lắp đèn trang trí để làm giải pháp chiếu sáng hữu hiệu cho văn phòng làm việc. Vậy làm thế nào để lựa chọn được mẫu đèn trang trí phù hợp nhất cho văn phòng...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>

                    <!-- Bài viết 5 -->
                    <div class="blog-item">
                        <div class="blog-image">
                            <img src="${pageContext.request.contextPath}/images/blog/luu-y.jpg" 
                                 alt="Lưu ý khi mua đèn"
                                 onerror="this.src='https://placehold.co/120x120/e8d5a8/8b6914?text=L%C6%B0u+%C3%9D'">
                        </div>
                        <div class="blog-content">
                            <h3>📝 Một số lưu ý khi mua và sử dụng đèn trang trí</h3>
                            <p>Một số lưu ý khi mua và sử dụng đèn trang trí để đảm bảo độ bền và an toàn cho người sử dụng. Cách chọn đèn phù hợp với từng không gian và nhu cầu sử dụng...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>
                </div>

                <!-- Xem thêm button -->
                <div class="blog-more">
                    <a href="#" class="btn-view-all">📖 Xem tất cả bài viết</a>
                </div>
            </div>
            <!-- Footer -->
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