<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DecorLamp - Đèn Trang Trí Cao Cấp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>

        </style>
    </head>
    <body>
        <div class="container">
            <!-- Header Top - Hotline -->
            <!--    <div class="header-top">
                    
                    <div class="social">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-zalo"></i></a>
                    </div>
                </div>-->

            <!-- Slideshow Banner -->
            <div class="slideshow-container">
                <div class="slide fade">
                    <img src="${pageContext.request.contextPath}/images/banner2.png" alt="Banner 1">
                </div>
                <div class="slide fade">
                    <img src="https://casani.vn/img/g/g94.jpg" alt="Banner 2">
                </div>
                <!--        <a class="prev" onclick="changeSlide(-1)">&#10094;</a>
                        <a class="next" onclick="changeSlide(1)">&#10095;</a>
                        <div class="dots-container">
                            <span class="dot" onclick="currentSlide(1)"></span>
                            <span class="dot" onclick="currentSlide(2)"></span>
                        </div>-->
            </div>

            <!-- Main Menu -->
            <div class="main-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Home">TRANG CHỦ</a></li>
                    <li><a href="${pageContext.request.contextPath}/products">SẢN PHẨM</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">GIỚI THIỆU</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">LIÊN HỆ</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart">GIỎ HÀNG</a></li>

                    <li class="search-form">
                        <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex;">
                            <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
                            <button type="submit"><i class="fas fa-search"></i></button>
                        </form>
                    </li>

                    <div class="cart-info">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <c:if test="${sessionScope.user.role == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard">📊</a>
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

            <!-- TOP ROW: Left Sidebar + Right Banner -->
            <div class="top-row">
                <!-- Left Sidebar -->
                <div class="left-sidebar">
                    <div class="product-categories">
                        <h3>SẢN PHẨM</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm cổ điển</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                            <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Chùm phòng khách</a></li>
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
                    <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp" 
                         onerror="this.src='https://sundecor.vn/wp-content/uploads/2025/06/den-chum-co-dien.jpg'">
                </div>
            </div>

            <!-- ========== POLICY BAR - Full Width ========== -->
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

            <!-- ========== PRODUCT SECTION ========== -->
            <div class="product-section">
                <!-- Sản phẩm nổi bật -->
                <h3 class="section-title">🔥 SẢN PHẨM NỔI BẬT</h3>
                <div class="product-grid">
                    <c:forEach items="${listP}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                <h4>${p.name}</h4>
                                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</p>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Hàng mới & Bán chạy (2 cột) -->
                <div class="two-columns">
                    <div class="column">
                        <h3 class="section-title" style="margin-top: 0;">🆕 HÀNG MỚI</h3>
                        <div class="product-grid">
                            <c:forEach items="${newProducts}" var="p" begin="0" end="3">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="column">
                        <h3 class="section-title" style="margin-top: 0;">⭐ BÁN CHẠY</h3>
                        <div class="product-grid">
                            <c:forEach items="${bestsellerProducts}" var="p" begin="0" end="3">
                                <div class="product-item">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                        <h4>${p.name}</h4>
                                        <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</p>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Giảm giá -->
                <h3 class="section-title">🎯 GIẢM GIÁ</h3>
                <div class="product-grid">
                    <c:forEach items="${saleProducts}" var="p" begin="0" end="7">
                        <div class="product-item">
                            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                <img src="${p.image}" alt="${p.name}" onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                <h4>${p.name}</h4>
                                <p class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</p>
                            </a>
                        </div>
                    </c:forEach>
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
                            <li><a href="#">Đèn Chùm Pha Lê</a></li>
                            <li><a href="#">Đèn Chùm Cổ Điển</a></li>
                            <li><a href="#">Đèn Chùm Đồng</a></li>
                            <li><a href="#">Đèn Thả Trần</a></li>
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
                }, 35000);
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