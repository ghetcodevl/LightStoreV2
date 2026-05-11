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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #c0392b;
                --primary-dark: #a93226;
                --text-dark: #1a1a1a;
                --text-gray: #555;
                --bg-gray: #f8f8f8;
                --border-color: #e0e0e0;
                --white: #ffffff;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f0;
                color: var(--text-dark);
                margin: 0;
                padding: 0;
            }

            .main-menu {
                background: var(--text-dark);
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;
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

            .container {
                margin-top: 50px;
                max-width: 95%;
                margin-left: auto;
                margin-right: auto;
                background: var(--white);
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            .search-form {
                display: flex;
                align-items: center;
                margin-left: auto;
            }
            .search-form input {
                padding: 8px 12px;
                border: none;
                border-radius: 25px 0 0 25px;
                outline: none;
                width: 250px;
            }
            .search-form button {
                padding: 8px 15px;
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
            }
            .cart-info {
                display: flex;
                align-items: center;
                margin-left: 15px;
            }
            .cart-info a {
                color: white;
                text-decoration: none;
                margin: 0 5px;
                padding: 8px 16px;
                border-radius: 20px;
            }
            .cart-info .user-name {
                background: var(--primary-color);
            }
            .cart-info .logout-btn {
                background: #555;
            }
            .cart-info .logout-btn:hover {
                background: var(--primary-color);
            }

            .main-content {
                display: flex;
                gap: 30px;
                padding: 30px;
                align-items: flex-start;
            }

            .left-menu {
                width: 260px;
                background: var(--bg-gray);
                padding: 15px;
                border-radius: 10px;
                position: sticky;
                top: 80px;          /* Cách top 80px để không bị menu che */
                align-self: flex-start;
                height: fit-content;
                max-height: calc(100vh - 100px);
                overflow-y: auto;   /* Nếu nội dung dài thì có scroll riêng */
            }
            .menu-title {
                font-size: 18px;
                font-weight: 700;
                color: var(--text-dark);
                padding: 10px 0;
                margin-bottom: 15px;
                border-bottom: 2px solid var(--primary-color);
                display: inline-block;
            }
            .left-menu ul {
                list-style: none;
                margin-bottom: 20px;
            }
            .left-menu li a {
                display: block;
                padding: 8px 0;
                color: var(--text-gray);
                text-decoration: none;
                transition: all 0.3s;
            }
            .left-menu li a:hover {
                color: var(--primary-color);
                padding-left: 8px;
            }
            .content {
                flex: 1;
            }
            .content-title {
                font-size: 28px;
                font-weight: 700;
                color: var(--text-dark);
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 3px solid var(--primary-color);
            }

            .search-result-info {
                background: var(--bg-gray);
                padding: 12px 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                font-size: 14px;
                color: var(--text-gray);
            }
            .search-result-info strong {
                color: var(--primary-color);
            }

            /* Product List */
            .product-list {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }
            .product-item {
                background: var(--white);
                border: 1px solid var(--border-color);
                border-radius: 10px;
                overflow: hidden;
                transition: all 0.3s;
            }
            .product-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
                border-color: var(--primary-color);
            }
            .product-item a {
                display: block;
                padding: 12px;
                text-decoration: none;
                color: inherit;
            }

            /* Image Wrapper - để badge đè lên ảnh */
            .image-wrapper {
                position: relative;
                overflow: hidden;
                border-radius: 8px;
            }
            .product-item img {
                width: 100%;
                height: 180px;
                object-fit: cover;
                display: block;
            }

            /* Sale Badge - đè lên góc ảnh */
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

            /* Price Box */
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

            .product-item h4 {
                font-size: 14px;
                font-weight: 500;
                margin: 10px 0 5px;
                line-height: 1.4;
                color: var(--text-dark);
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                min-height: 40px;
            }

            .no-result {
                text-align: center;
                padding: 60px;
                background: var(--bg-gray);
                border-radius: 12px;
                grid-column: 1/-1;
            }
            .no-result p:first-child {
                font-size: 18px;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 10px;
            }

            .pagination {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-top: 30px;
                flex-wrap: wrap;
            }
            .pagination a {
                display: inline-block;
                padding: 8px 14px;
                background: var(--white);
                border: 1px solid var(--border-color);
                color: var(--text-gray);
                text-decoration: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s;
            }
            .pagination a:hover, .pagination a.active {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }

            .footer {
                background: var(--text-dark);
                color: var(--text-gray);
                padding: 40px 30px 20px;
                margin-top: 30px;
            }
            .footer-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 30px;
                margin-bottom: 30px;
            }
            .footer-col h4 {
                color: var(--white);
                font-size: 16px;
                margin-bottom: 15px;
                padding-bottom: 8px;
                border-bottom: 2px solid var(--primary-color);
                display: inline-block;
            }
            .footer-col ul {
                list-style: none;
            }
            .footer-col ul li {
                margin-bottom: 8px;
            }
            .footer-col ul li a {
                color: var(--text-gray);
                text-decoration: none;
                transition: 0.3s;
            }
            .footer-col ul li a:hover {
                color: var(--primary-color);
                padding-left: 5px;
            }
            .footer-bottom {
                text-align: center;
                padding-top: 20px;
                border-top: 1px solid #333;
            }

            @media (max-width: 1024px) {
                .product-list {
                    grid-template-columns: repeat(3, 1fr);
                }
            }
            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                }
                .left-menu {
                    width: 100%;
                }
                .product-list {
                    grid-template-columns: repeat(2, 1fr);
                }
                .footer-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .search-form input {
                    width: 150px;
                }
            }
            @media (max-width: 480px) {
                .product-list {
                    grid-template-columns: 1fr;
                }
                .footer-grid {
                    grid-template-columns: 1fr;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="/header.jsp" />

            <script>
                function confirmLogout(event) {
                    event.preventDefault();
                    if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                        window.location.href = '${pageContext.request.contextPath}/logout';
                    }
                }
            </script>

            <!-- Main Content -->
            <div class="main-content">
                <div class="left-menu">
                    <div class="menu-title">DANH MỤC SẢN PHẨM</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                    </ul>
                    <div class="menu-title">SẢN PHẨM NỔI BẬT</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
                    </ul>
                </div>

                <div class="content">
                    <div class="content-title">${title}</div>

                    <c:if test="${not empty param.keyword}">
                        <div class="search-result-info">
                            🔍 Tìm thấy <strong>${fn:length(listP)}</strong> sản phẩm cho từ khóa "<strong>${param.keyword}</strong>"
                        </div>
                    </c:if>

                    <div class="product-list">
                        <c:forEach items="${listP}" var="p">
                            <div class="product-item">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                    <div class="image-wrapper">
                                        <img src="${p.image}" alt="${p.name}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">

                                        <!-- Badge giảm giá - đè lên góc ảnh -->
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

        <jsp:include page="chatbot.jsp" />
    </body>
</html>