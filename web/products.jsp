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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #c0392b;      /* Màu đỏ đậm sang trọng */
                --primary-dark: #a93226;
                --primary-light: #e74c3c;
                --text-dark: #1a1a1a;
                --text-gray: #555;
                --text-light: #888;
                --bg-gray: #f8f8f8;
                --border-color: #e0e0e0;
                --white: #ffffff;
                --font-main: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                --font-price: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            }

            .main-menu {
                background: var(--text-dark);
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

            /* ========== SEARCH FORM ========== */
            .search-form {
                display: flex;
                align-items: center;
                margin-left: 190px;
            }
            .search-form input {
                padding: 8px 12px;
                border: none;
                border-radius: 25px 0 0 25px;
                outline: none;
                width: 280px;
            }
            .search-form button {
                padding: 8px 15px;
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
                transition: 0.3s;
            }
            .search-form button:hover {
                background: var(--primary-dark);
            }

            .search-item {
                margin: 0 10px;
                display: inline-block;
                vertical-align: middle;
            }

            .search-form-header {
                display: flex;
                align-items: center;
                margin: 0 15px;
            }
            .search-form-header input {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 25px 0 0 25px;
                outline: none;
                width: 200px;
                font-size: 13px;
                background: #fff;
            }
            .search-form-header button {
                padding: 8px 15px;
                background: #b8860b;
                color: white;
                border: none;
                border-radius: 0 25px 25px 0;
                cursor: pointer;
                font-size: 13px;
                transition: background 0.3s;
            }
            .search-form-header button:hover {
                background: #9a7209;
            }

            .cart-info {
                margin-left: auto;
                display: flex;
                align-items: center;
            }
            .cart-info a {
                color: white;
                text-decoration: none;
                margin: 0 10px;
            }
            /* Product styles */
            .content-title {
                font-size: 28px;
                font-weight: 700;
                color: #1a1a1a;
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                /*                border-bottom: 3px solid #c0392b;*/
                display: inline-block;
                width: 100%;
            }

            .search-result-info {
                background: #f8f8f8;
                padding: 12px 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                font-size: 14px;
                color: #555;
            }

            .search-result-info strong {
                color: #c0392b;
            }



            .product-section {
                margin-bottom: 40px;
            }

            .product-section h3 {
                font-size: 20px;
                font-weight: 600;
                color: #1a1a1a;
                margin-bottom: 20px;
                padding-left: 12px;
                border-left: 4px solid #c0392b;
            }


            .product-list {
                display: grid !important;
                grid-template-columns: repeat(4, 1fr) !important;
                gap: 20px !important;
                margin: 0 !important;
                padding: 0 !important;


                /* Product Item */
                .product-item {
                    background: #ffffff;
                    border: 1px solid #e0e0e0;
                    border-radius: 10px;
                    overflow: hidden;
                    transition: all 0.3s ease;
                    width: 100% !important;
                }

                .product-item:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 20px rgba(0,0,0,0.1);
                    border-color: #c0392b;
                }

                .product-item a {
                    display: block;
                    padding: 12px;
                    text-decoration: none;
                    color: inherit;
                }

                .product-item img {
                    width: 100%;
                    height: 180px;
                    object-fit: cover;
                    border-radius: 8px;
                }

                .product-item h4 {
                    font-size: 14px;
                    font-weight: 500;
                    margin: 10px 0 5px;
                    line-height: 1.4;
                    color: #332;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    min-height: 40px;
                }

                .product-item .price {
                    font-size: 15px;
                    font-weight: 700;
                    color: #c0392b;
                    margin-top: 5px;
                }

                /* Responsive */

                /*            .cart-info {
                            margin-left: auto;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }
                        .cart-info a {
                            color: white;
                            text-decoration: none;
                            padding: 8px 16px;
                            border-radius: 20px;
                            transition: 0.3s;
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
                        .cart-info a:hover {
                            color: white;
                        }*/

                /* ========== LEFT MENU ========== */
                .main-content {
                    display: flex;
                    gap: 30px;
                    padding: 30px;
                }
                .left-menu {
                    width: 260px;
                    background: var(--bg-gray);
                    padding: 15px;
                    border-radius: 10px;
                }
                .menu-title {
                    font-size: 18px;
                    font-weight: 700;
                    color: var(--text-dark);
                    padding: 10px 0;
                    margin-bottom: 15px;
                    /*            border-bottom: 3px solid var(--primary-color);*/
                    display: inline-block;
                }
                .left-menu ul {
                    list-style: none;
                    margin-bottom: 20px;
                }
                .left-menu li a {
                    display: block;
                    padding: 10px 0;
                    color: var(--text-gray);
                    text-decoration: none;
                    transition: all 0.3s;
                }
                .left-menu li a:hover {
                    color: var(--primary-color);
                    padding-left: 10px;
                }

                /* ========== CONTENT ========== */
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
                    /*            border-bottom: 3px solid var(--primary-color);*/
                    width: 100%;
                }

                /* Search Result */
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
                .product-item img {
                    width: 100%;
                    height: 180px;
                    object-fit: cover;
                    border-radius: 8px;
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
                .product-item .price {
                    font-size: 15px;
                    font-weight: 700;
                    color: var(--primary-color);
                }

                /* No Result */
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

                /* ========== PAGINATION ========== */
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
                    min-width: 36px;
                    text-align: center;
                    background: var(--white);
                    border: 1px solid var(--border-color);
                    color: var(--text-gray);
                    text-decoration: none;
                    border-radius: 6px;
                    font-size: 14px;
                    font-weight: 500;
                    transition: all 0.3s;
                }
                .pagination a:hover {
                    background: var(--primary-color);
                    color: white;
                    border-color: var(--primary-color);
                }
                .pagination a.active {
                    background: var(--primary-color);
                    color: white;
                    border-color: var(--primary-color);
                }

                /* ========== FOOTER ========== */
.footer {
    background: var(--text-dark);
    color: var(--text-light);
    padding: 40px 30px 20px;
    margin-top: 30px;
}
.footer-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 30px;
    margin-bottom: 30px;
}
.footer-col h3 {
    color: var(--white);
    font-size: 16px;
    margin-bottom: 15px;
    padding-bottom: 8px;
    border-bottom: 2px solid var(--primary-color);
    display: inline-block;
}
.footer-col ul { list-style: none; }
.footer-col ul li { margin-bottom: 8px; }
.footer-col ul li a {
    color: var(--text-light);
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



            </style>

        </head>
        <body>
            <div class="container">
                <!-- ========== MAIN MENU ========== -->
                <div class="main-menu">
                    <ul>
    <!--                    <li><a href="${pageContext.request.contextPath}/about">Giới thiệu</a></li>-->
                        <li><a href="${pageContext.request.contextPath}/Home">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>

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
                                        <a href="${pageContext.request.contextPath}/admin/dashboard">DASH BOARD</a>
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
                                <h3>DECORLAMP</h3>
                                <p class="footer-desc">
                                    Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, 
                                    đèn cổ điển, đèn đồng... Với thiết kế sang trọng, chất lượng vượt trội.
                                </p>
                            </div>
                            <div class="footer-col">
                                <h3>SẢN PHẨM</h3>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                                    <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                                </ul>
                            </div>
                            <div class="footer-col">
                                <h3>HỖ TRỢ</h3>
                                <ul>
                                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                                    <li><a href="#">Chính sách vận chuyển</a></li>
                                    <li><a href="#">Chính sách đổi trả</a></li>
                                    <li><a href="#">Chính sách bảo hành</a></li>
                                </ul>
                            </div>
                            <div class="footer-col">
                                <h3>THÔNG TIN</h3>
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