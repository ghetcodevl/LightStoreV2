<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giới thiệu - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <style>
            .about-container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 40px 20px;
            }
            .about-title {
                font-size: 32px;
                color: #b8860b;
                text-align: center;
                margin-bottom: 30px;
                font-family: 'Georgia', serif;
            }
            .about-section {
                margin-bottom: 40px;
            }
            .about-section h2 {
                color: #8b6914;
                margin-bottom: 15px;
                padding-left: 10px;
                border-left: 4px solid #b8860b;
            }
            .about-section p {
                line-height: 1.8;
                color: #4a3720;
                margin-bottom: 15px;
            }
            .about-image {
                text-align: center;
                margin: 30px 0;
            }
            .about-image img {
                max-width: 100%;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            .values-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 30px;
                margin: 30px 0;
            }
            .value-item {
                text-align: center;
                padding: 20px;
                background: #f9f5ed;
                border-radius: 10px;
                transition: transform 0.3s;
            }
            .value-item:hover {
                transform: translateY(-5px);
            }
            .value-icon {
                font-size: 40px;
                margin-bottom: 15px;
            }
            .value-item h3 {
                color: #b8860b;
                margin-bottom: 10px;
            }
            @media (max-width: 768px) {
                .values-grid {
                    grid-template-columns: 1fr;
                }
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
                <div class="left-menu">
                    <div class="menu-title">Danh mục sản phẩm</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                    </ul>
                    <div class="menu-title">Hỗ trợ</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                    </ul>
                </div>

                <div class="content">
                    <div class="about-container">
                        <h1 class="about-title">✨ Về DecorLamp ✨</h1>

                        <div class="about-image">
                            <img src="${pageContext.request.contextPath}/images/about.jpg" alt="DecorLamp Showroom" onerror="this.src='https://via.placeholder.com/800x400/e8d5a8/8b6914?text=DecorLamp'">
                        </div>

                        <div class="about-section">
                            <h2>🏢 Về chúng tôi</h2>
                            <p>DecorLamp là thương hiệu chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, đèn cổ điển, đèn đồng... Với hơn 10 năm kinh nghiệm trong lĩnh vực chiếu sáng và trang trí nội thất, chúng tôi tự hào mang đến cho khách hàng những sản phẩm chất lượng nhất với giá cả cạnh tranh nhất.</p>
                            <p>Showroom của chúng tôi trưng bày hơn 1000 mẫu mã đèn trang trí khác nhau, từ phong cách cổ điển sang trọng đến hiện đại tinh tế, đáp ứng mọi nhu cầu của khách hàng.</p>
                        </div>

                        <div class="about-section">
                            <h2>🎯 Sứ mệnh</h2>
                            <p>Mang ánh sáng chất lượng cao đến mọi không gian sống của người Việt. Chúng tôi cam kết cung cấp sản phẩm chính hãng, bảo hành dài hạn, dịch vụ chuyên nghiệp và giá cả hợp lý nhất.</p>
                        </div>

                        <div class="values-grid">
                            <div class="value-item">
                                <div class="value-icon">💎</div>
                                <h3>Chất lượng</h3>
                                <p>Sản phẩm chính hãng, kiểm định nghiêm ngặt trước khi đến tay khách hàng</p>
                            </div>
                            <div class="value-item">
                                <div class="value-icon">🚚</div>
                                <h3>Giao hàng nhanh</h3>
                                <p>Giao hàng toàn quốc, lắp đặt tận nơi trong thời gian sớm nhất</p>
                            </div>
                            <div class="value-item">
                                <div class="value-icon">🔧</div>
                                <h3>Bảo hành chu đáo</h3>
                                <p>Bảo hành chính hãng lên đến 24 tháng, hỗ trợ kỹ thuật 24/7</p>
                            </div>
                        </div>

                        <div class="about-section">
                            <h2>📍 Hệ thống showroom</h2>
                            <p><strong>Showroom Hà Nội:</strong> Số 8A Phạm Hùng, Phường Mễ Trì, Quận Nam Từ Liêm, TP. Hà Nội</p>
                            <p><strong>Showroom TP.HCM:</strong> Số 73 Ỷ Lan, Phường Hiệp Tân, Quận Tân Phú, TP. Hồ Chí Minh</p>
                            <p><strong>Hotline:</strong> 0965.69.8866</p>
                            <p><strong>Email:</strong> decorlamp@gmail.com</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="footer">
                <div class="footer-container">
                    <div class="footer-bottom">
                        <p>© 2024 DecorLamp. All rights reserved.</p>
                        <p>Nhóm thực hiện: Đặng Minh Quốc, Lại Thế Trường, Lê Anh Tuấn</p>
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
         <!-- Include Chatbot -->
        <jsp:include page="chatbot.jsp" />
    </body>
</html>