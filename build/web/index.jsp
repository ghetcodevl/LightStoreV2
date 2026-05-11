<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>DecorLamp - Đèn Trang Trí Cao Cấp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            /* Product Image Wrapper & Sale Badge */
            .product-item {
                position: relative;
            }
            .image-wrapper {
                position: relative;
                overflow: hidden;
                border-radius: 8px;
            }
            .sale-badge {
                position: absolute;
                top: 10px;
                left: 10px;
                background: #c0392b;
                color: white;
                padding: 5px 12px;
                border-radius: 25px;
                font-size: 13px;
                font-weight: bold;
                z-index: 10;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }
            .price-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 3px;
                margin-top: 8px;
            }
            .old-price {
                font-size: 13px;
                color: #999;
                text-decoration: line-through;
            }
            .price {
                font-size: 16px;
                font-weight: 700;
                color: #c0392b;
            }

            /* Blog Section */
            .blog-section {
                background: #f8f8f8;
                padding: 50px 30px;
                margin: 40px 0 0;
                border-radius: 12px;
            }
            .blog-section .content-title {
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                color: #1a1a1a;
                margin-bottom: 30px;
                padding-bottom: 15px;
                position: relative;
                border-bottom: none;
            }
            .blog-section .content-title:after {
                content: '';
                display: block;
                width: 60px;
                height: 3px;
                background: #c0392b;
                margin: 12px auto 0;
            }
            .blog-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 25px;
                margin-bottom: 40px;
            }
            .blog-card {
                background: white;
                border-radius: 12px;
                overflow: hidden;
                transition: all 0.3s;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }
            .blog-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            }
            .blog-card-image {
                height: 180px;
                overflow: hidden;
            }
            .blog-card-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .blog-card-content {
                padding: 15px;
            }
            .blog-card-content h3 {
                font-size: 15px;
                font-weight: bold;
                color: #1a1a1a;
                margin-bottom: 10px;
                line-height: 1.4;
            }
            .blog-card-content p {
                font-size: 13px;
                color: #666;
                line-height: 1.5;
                margin-bottom: 12px;
            }
            .blog-card-content .read-more {
                color: #c0392b;
                text-decoration: none;
                font-weight: bold;
                font-size: 12px;
            }
            .blog-card-content .read-more:hover {
                color: #a93226;
            }
            .blog-more {
                text-align: center;
            }
            .btn-view-all {
                display: inline-block;
                background: transparent;
                border: 2px solid #c0392b;
                color: #c0392b;
                padding: 10px 35px;
                border-radius: 30px;
                font-weight: bold;
                text-decoration: none;
            }
            .btn-view-all:hover {
                background: #c0392b;
                color: white;
            }

            @media (max-width: 1024px) {
                .blog-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 768px) {
                .blog-section {
                    padding: 30px 15px;
                }
                .blog-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Slideshow Banner -->
            <div class="slideshow-container">
                <div class="slide fade">
                    <img src="${pageContext.request.contextPath}/images/banner2.png" alt="Banner 1">
                </div>
                <div class="slide fade">
                    <img src="https://casani.vn/img/g/g94.jpg" alt="Banner 2">
                </div>
            </div>

            <!-- Main Menu -->
<!--            <div class="main-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Home">TRANG CHỦ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">SẢN PHẨM</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">LIÊN HỆ</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart">GIỎ HÀNG</a></li>
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
                                    <a href="${pageContext.request.contextPath}/admin/dashboard">DASHBOARD</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/profile" class="user-name"><i class="fas fa-user"></i> ${sessionScope.user.fullName}</a>
                                <a href="#" onclick="confirmLogout(event)" class="logout-btn">Đăng xuất</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/LoginServlet">Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </ul>
            </div>-->
<jsp:include page="/header.jsp" />
            <script>
                function confirmLogout(event) {
                    event.preventDefault();
                    if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                        window.location.href = '${pageContext.request.contextPath}/logout';
                    }
                }
            </script>

            <!-- Top Row -->
            <div class="top-row">
                <!-- Left Sidebar -->
                <div class="left-sidebar">
                    <div class="product-categories">
                        <h3>SẢN PHẨM</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
                            </ul>
                        </ul>
                    </div>
                </div>

                <!-- Right Banner -->
                <div class="right-banner">
                    <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner" 
                         onerror="this.src='https://sundecor.vn/wp-content/uploads/2025/06/den-chum-co-dien.jpg'">
                </div>
            </div>

            <!-- Policy Bar -->
            <div class="policy-bar">
                <div class="policy-item">
                    <div class="icon"><img src="${pageContext.request.contextPath}/images/1.png" alt="Uy tín"></div>
                    <div class="text">
                        <h4>Uy tín đặt lên hàng đầu</h4>
                        <p>Chất lượng – Dịch vụ – Thương hiệu</p>
                    </div>
                </div>
                <div class="policy-item">
                    <div class="icon"><img src="${pageContext.request.contextPath}/images/2.png" alt="Lắp đặt"></div>
                    <div class="text">
                        <h4>Miễn phí lắp đặt &lt; 15km</h4>
                        <p>Đội ngũ lắp đặt chuyên nghiệp</p>
                    </div>
                </div>
                <div class="policy-item">
                    <div class="icon"><img src="${pageContext.request.contextPath}/images/3.png" alt="Giao hàng"></div>
                    <div class="text">
                        <h4>Giao hàng toàn quốc</h4>
                        <p>Miễn phí giao hàng Toàn Quốc</p>
                    </div>
                </div>
                <div class="policy-item">
                    <div class="icon"><img src="${pageContext.request.contextPath}/images/4.png" alt="Sản phẩm"></div>
                    <div class="text">
                        <h4>Sản phẩm đa dạng phong phú</h4>
                        <p>Luôn đi đầu xu hướng sản phẩm</p>
                    </div>
                </div>
            </div>

            <!-- Product Section -->
            <div class="product-section">
                <!-- Sản phẩm nổi bật -->
                <h3 class="section-title">SẢN PHẨM NỔI BẬT</h3>
                <div class="product-grid">
                    <c:forEach items="${listP}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <div class="image-wrapper">
                                    <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                    <c:if test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="sale-badge">-${p.discountPercent}%</div>
                                    </c:if>
                                </div>
                                <h4>${p.name}</h4>
                                <c:choose>
                                    <c:when test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="price-box">
                                            <span class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,##0"/>đ</span>
                                            <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</p>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Hàng mới -->
                <h3 class="section-title">HÀNG MỚI</h3>
                <div class="product-grid">
                    <c:forEach items="${newProducts}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <div class="image-wrapper">
                                    <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                    <c:if test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="sale-badge">-${p.discountPercent}%</div>
                                    </c:if>
                                </div>
                                <h4>${p.name}</h4>
                                <c:choose>
                                    <c:when test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="price-box">
                                            <span class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,##0"/>đ</span>
                                            <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</p>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Bán chạy -->
                <h3 class="section-title">BÁN CHẠY</h3>
                <div class="product-grid">
                    <c:forEach items="${bestsellerProducts}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <div class="image-wrapper">
                                    <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                    <c:if test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="sale-badge">-${p.discountPercent}%</div>
                                    </c:if>
                                </div>
                                <h4>${p.name}</h4>
                                <c:choose>
                                    <c:when test="${p.tag == 'sale' and p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="price-box">
                                            <span class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,##0"/>đ</span>
                                            <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</p>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Giảm giá -->
                <h3 class="section-title">GIẢM GIÁ</h3>
                <div class="product-grid">
                    <c:forEach items="${saleProducts}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <div class="image-wrapper">
                                    <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                    <c:if test="${p.oldPrice > 0 and p.oldPrice != p.price}">
                                        <div class="sale-badge">-${p.discountPercent}%</div>
                                    </c:if>
                                </div>
                                <h4>${p.name}</h4>
                                <div class="price-box">
                                    <span class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,##0"/>đ</span>
                                    <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</span>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Blog Section -->
            <div class="blog-section">
                <div class="content-title">NHỮNG TIN TỨC, CÁCH LỰA CHỌN ĐÈN TRANG TRÍ</div>
                <div class="blog-grid">
                    <div class="blog-card">
                        <div class="blog-card-image">
                            <img src="${pageContext.request.contextPath}/images/bo-tui-3-cau-hoi-hay-gap-khi-su-dung-den-pha-le-dung-phong-thuy.jpg" 
                                 alt="Đèn pha lê phong thủy"
                                 onerror="this.src='https://placehold.co/400x250/e8d5a8/8b6914?text=No+Image'">
                        </div>
                        <div class="blog-card-content">
                            <h3>Bỏ túi 3 câu hỏi hay gặp khi sử dụng đèn pha lê đúng phong thủy</h3>
                            <p>Hiện nay, có rất nhiều câu hỏi xoay quanh mẫu đèn pha lê được rất nhiều người tiêu dùng quan tâm...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-card-image">
                            <img src="${pageContext.request.contextPath}/images/casani-the-gioi-den-trang-tri-gia-re-chat-luong.jpg" 
                                 alt="Casani đèn trang trí"
                                 onerror="this.src='https://placehold.co/400x250/e8d5a8/8b6914?text=No+Image'">
                        </div>
                        <div class="blog-card-content">
                            <h3>Casani - Thế giới đèn trang trí giá rẻ, chất lượng</h3>
                            <p>Bạn đang muốn mua đèn led trang trí cho căn nhà, văn phòng của mình? Casani chính là một thương hiệu lâu năm...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-card-image">
                            <img src="${pageContext.request.contextPath}/images/tong-hop-cac-cach-phoi-mau-den-trang-tri-noi-that.jpg" 
                                 alt="Phối màu đèn trang trí"
                                 onerror="this.src='https://placehold.co/400x250/e8d5a8/8b6914?text=No+Image'">
                        </div>
                        <div class="blog-card-content">
                            <h3>Tổng hợp các cách phối màu đèn trang trí nội thất</h3>
                            <p>Hiện nay nhu cầu sử dụng các loại đèn trang trí ngày càng trở nên phổ biến. Để tăng thêm hiệu quả trang trí...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-card-image">
                            <img src="${pageContext.request.contextPath}/images/45.jpg" 
                                 alt="Đèn văn phòng"
                                 onerror="this.src='https://placehold.co/400x250/e8d5a8/8b6914?text=No+Image'">
                        </div>
                        <div class="blog-card-content">
                            <h3>Những lưu ý khi lựa chọn đèn trang trí cho văn phòng</h3>
                            <p>Hiện nay nhiều công ty ưu tiên lắp đèn trang trí để làm giải pháp chiếu sáng hữu hiệu cho văn phòng làm việc...</p>
                            <a href="#" class="read-more">Đọc tiếp →</a>
                        </div>
                    </div>
                </div>
                <div class="blog-more">
                    <a href="#" class="btn-view-all">Xem tất cả bài viết</a>
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
        </div>

        <!-- Slideshow Script -->
        <script>
            let slideIndex = 1;
            let slideInterval;
            showSlides(slideIndex);
            startAutoSlide();

            function changeSlide(n) {
                showSlides(slideIndex += n);
                resetTimer();
            }
            function currentSlide(n) {
                showSlides(slideIndex = n);
                resetTimer();
            }
            function showSlides(n) {
                let slides = document.getElementsByClassName("slide");
                let dots = document.getElementsByClassName("dot");
                if (n > slides.length) {
                    slideIndex = 1;
                }
                if (n < 1) {
                    slideIndex = slides.length;
                }
                for (let i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                for (let i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" active", "");
                }
                if (slides[slideIndex - 1]) {
                    slides[slideIndex - 1].style.display = "block";
                }
                if (dots[slideIndex - 1]) {
                    dots[slideIndex - 1].className += " active";
                }
            }
            function startAutoSlide() {
                slideInterval = setInterval(function () {
                    slideIndex++;
                    showSlides(slideIndex);
                    if (slideIndex > document.getElementsByClassName("slide").length) {
                        slideIndex = 1;
                    }
                }, 5000);
            }
            function resetTimer() {
                clearInterval(slideInterval);
                startAutoSlide();
            }
        </script>

        <!-- Zalo Button -->
        <div style="position: fixed; bottom: 30px; right: 30px; z-index: 999;">
            <a href="https://zalo.me/0868506503" target="_blank" style="display: block; width: 55px; height: 55px; background: #0068ff; border-radius: 50%; text-align: center; line-height: 55px; color: white; font-size: 28px; text-decoration: none; box-shadow: 0 2px 10px rgba(0,0,0,0.2);">
                <i class="fab fa-facebook-messenger"></i>
            </a>
        </div>

        <!-- Include Chatbot -->
        <jsp:include page="chatbot.jsp" />
    </body>
</html>