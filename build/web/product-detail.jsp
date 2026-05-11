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

            /* Main Menu Fixed */
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
                max-width: 1400px;
                margin: 0 auto;
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
                margin-top: 65px;
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

            /* Product Detail */
            .product-detail-container {
                display: flex;
                gap: 40px;
                padding: 20px;
                background: var(--white);
                border-radius: 12px;
                border: 1px solid var(--border-color);
            }
            .product-detail-image {
                flex: 1;
                text-align: center;
            }
            .product-detail-image img {
                max-width: 100%;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            .product-detail-info {
                flex: 1;
            }
            .product-detail-info h1 {
                font-size: 28px;
                color: var(--text-dark);
                margin-bottom: 15px;
            }

            /* Price Section */
            .product-price {
                margin: 20px 0;
                padding: 15px 0;
                border-top: 1px solid var(--border-color);
                border-bottom: 1px solid var(--border-color);
            }
            .price-sale {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 10px;
            }
            .discount-badge {
                background: #c0392b;
                color: white;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: bold;
            }
            .old-price {
                font-size: 18px;
                color: #999;
                text-decoration: line-through;
            }
            .current-price {
                font-size: 32px;
                font-weight: bold;
                color: #c0392b;
            }
            .save-amount {
                font-size: 14px;
                color: #27ae60;
                margin-top: 5px;
            }
            .normal-price {
                font-size: 28px;
                font-weight: bold;
                color: #c0392b;
            }

            .product-description {
                margin: 20px 0;
                line-height: 1.8;
                color: var(--text-gray);
            }
            .product-description h3 {
                color: var(--text-dark);
                margin-bottom: 10px;
            }
            .product-meta {
                margin: 20px 0;
                padding: 15px;
                background: var(--bg-gray);
                border-radius: 8px;
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
                border: 1px solid var(--border-color);
                border-radius: 6px;
                text-align: center;
            }
            .btn-add-to-cart {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                border-radius: 8px;
                transition: background 0.3s;
            }
            .btn-add-to-cart:hover {
                background: var(--primary-dark);
            }
            .btn-buy-now {
                background: #28a745;
                color: white;
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                border-radius: 8px;
                margin-left: 10px;
                transition: background 0.3s;
            }
            .btn-buy-now:hover {
                background: #218838;
            }
            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: var(--primary-color);
                text-decoration: none;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .message {
                padding: 12px;
                margin-bottom: 20px;
                border-radius: 8px;
            }
            .message-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            /* Related Products */
            .related-products {
                margin-top: 50px;
                padding: 0 20px 30px;
            }
            .section-title {
                font-size: 22px;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid var(--primary-color);
                display: inline-block;
            }
            .product-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }
            .product-item {
                position: relative;
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
            }
            .price-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 3px;
                margin-top: 8px;
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
                text-align: center;
            }

            /* Footer */
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
                .product-grid {
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
                .product-detail-container {
                    flex-direction: column;
                }
                .product-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .footer-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 480px) {
                .product-grid {
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
            <!-- Main Menu -->
            <jsp:include page="/header.jsp" />

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
                    <div class="content-title">CHI TIẾT SẢN PHẨM</div>

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
                                <c:choose>
                                    <c:when test="${product.tag == 'sale' and product.oldPrice > 0 and product.oldPrice != product.price}">
                                        <div class="price-sale">
                                            <span class="discount-badge">-${product.discountPercent}%</span>
                                            <span class="old-price"><fmt:formatNumber value="${product.oldPrice}" pattern="#,##0"/>đ</span>
                                        </div>
                                        <div class="current-price"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ</div>
                                        <div class="save-amount">Tiết kiệm: <fmt:formatNumber value="${product.oldPrice - product.price}" pattern="#,##0"/>đ</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="normal-price"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ</div>
                                    </c:otherwise>
                                </c:choose>
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
                                    <button type="submit" class="btn-add-to-cart">🛒 Thêm vào giỏ hàng</button>
                                    <button type="button" class="btn-buy-now" onclick="buyNow()">💳 Mua ngay</button>
                                </div>
                            </form>
                            <a href="${pageContext.request.contextPath}/products" class="back-link">← Quay lại danh sách sản phẩm</a>
                        </div>
                    </div>
                    <!-- ========== PHẦN ĐÁNH GIÁ SẢN PHẨM ========== -->
                    <div class="reviews-section">
                        <div class="reviews-header">
                            <h3 class="section-title">ĐÁNH GIÁ SẢN PHẨM</h3>
                            <div class="rating-summary">
                                <div class="average-rating">
                                    <span class="avg-score">${avgRating > 0 ? String.format("%.1f", avgRating) : "0"}</span>
                                    <div class="stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= Math.round(avgRating) ? 'active' : ''}"></i>
                                        </c:forEach>
                                    </div>
                                    <span class="total-reviews">(${totalReviews} đánh giá)</span>
                                </div>
                                <button class="btn-write-review" onclick="openReviewModal()">✍️ Viết đánh giá</button>
                            </div>
                        </div>

                        <div class="reviews-list">
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:forEach items="${reviews}" var="review">
                                        <div class="review-item">
                                            <div class="reviewer-info">
                                                <i class="fas fa-user-circle"></i>
                                                <span class="reviewer-name">${review.userName}</span>
                                                <span class="review-date"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy"/></span>
                                            </div>
                                            <div class="review-rating">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fas fa-star ${i <= review.rating ? 'active' : ''}"></i>
                                                </c:forEach>
                                            </div>
                                            <div class="review-comment">${review.comment}</div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-reviews">Chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên đánh giá!</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Modal viết đánh giá -->
                    <div id="reviewModal" class="modal">
                        <div class="modal-content">
                            <span class="close" onclick="closeReviewModal()">&times;</span>
                            <h3><i class="fas fa-star" style="color: #f5a623;"></i> Đánh giá sản phẩm</h3>
                            <form id="reviewForm" action="${pageContext.request.contextPath}/add-review" method="post">
                                <input type="hidden" name="productId" value="${product.id}">
                                <div class="form-group">
                                    <label>Đánh giá của bạn</label>
                                    <div class="rating-input">
                                        <i class="far fa-star" data-rating="1" onclick="setRating(1)"></i>
                                        <i class="far fa-star" data-rating="2" onclick="setRating(2)"></i>
                                        <i class="far fa-star" data-rating="3" onclick="setRating(3)"></i>
                                        <i class="far fa-star" data-rating="4" onclick="setRating(4)"></i>
                                        <i class="far fa-star" data-rating="5" onclick="setRating(5)"></i>
                                    </div>
                                    <input type="hidden" name="rating" id="ratingValue" required>
                                </div>
                                <div class="form-group">
                                    <label>Nhận xét của bạn</label>
                                    <textarea name="comment" rows="4" placeholder="Chia sẻ cảm nhận thực tế của bạn về sản phẩm..." required></textarea>
                                </div>
                                <button type="submit" class="btn-submit-review">Gửi đánh giá</button>
                            </form>
                        </div>
                    </div>
                    <!-- Hiển thị sao với nửa sao -->
                    <div class="stars-big">
                        <c:set var="ratingRound" value="${Math.floor(avgRating)}" />
                        <c:set var="hasHalf" value="${avgRating - ratingRound >= 0.5}" />
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= ratingRound}">
                                    <i class="fas fa-star active"></i>
                                </c:when>
                                <c:when test="${i == ratingRound + 1 and hasHalf}">
                                    <i class="fas fa-star-half-alt active"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="far fa-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <script>
                        let selectedRating = 0;

                        function setRating(rating) {
                            selectedRating = rating;
                            document.getElementById('ratingValue').value = rating;
                            const stars = document.querySelectorAll('.rating-input .fa-star');
                            stars.forEach((star, index) => {
                                if (index < rating) {
                                    star.classList.remove('far');
                                    star.classList.add('fas');
                                    star.classList.add('active');
                                } else {
                                    star.classList.remove('fas');
                                    star.classList.add('far');
                                    star.classList.remove('active');
                                }
                            });
                        }

                        function openReviewModal() {
                            document.getElementById('reviewModal').style.display = 'block';
                        }

                        function closeReviewModal() {
                            document.getElementById('reviewModal').style.display = 'none';
                        }

                        window.onclick = function (event) {
                            const modal = document.getElementById('reviewModal');
                            if (event.target == modal) {
                                modal.style.display = 'none';
                            }
                        }
                    </script>
                    <!-- Sản phẩm liên quan -->
                    <c:if test="${not empty relatedProducts}">
                        <div class="related-products">
                            <h3 class="section-title">🔥 CÓ THỂ BẠN CŨNG THÍCH</h3>
                            <div class="product-grid">
                                <c:forEach items="${relatedProducts}" var="rp">
                                    <div class="product-item">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${rp.id}">
                                            <div class="image-wrapper">
                                                <img src="${rp.image}" alt="${rp.name}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                                <c:if test="${rp.tag == 'sale' and rp.oldPrice > 0 and rp.oldPrice != rp.price}">
                                                    <div class="sale-badge">-${rp.discountPercent}%</div>
                                                </c:if>
                                            </div>
                                            <h4>${fn:substring(rp.name, 0, 40)}${fn:length(rp.name) > 40 ? '...' : ''}</h4>
                                            <c:choose>
                                                <c:when test="${rp.tag == 'sale' and rp.oldPrice > 0 and rp.oldPrice != rp.price}">
                                                    <div class="price-box">
                                                        <span class="old-price"><fmt:formatNumber value="${rp.oldPrice}" pattern="#,##0"/>đ</span>
                                                        <span class="price"><fmt:formatNumber value="${rp.price}" pattern="#,##0"/>đ</span>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="price"><fmt:formatNumber value="${rp.price}" pattern="#,##0"/>đ</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
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

        <script>
            function buyNow() {
                var quantity = document.querySelector('input[name="quantity"]').value;
                var productId = ${product.id};
                window.location.href = '${pageContext.request.contextPath}/buy-now?id=' + productId + '&quantity=' + quantity;
            }
        </script>

        <jsp:include page="chatbot.jsp" />
    </body>
</html>