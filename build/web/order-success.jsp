<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Đặt hàng thành công - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <a href="https://www.flaticon.com/free-icons/success" title="success icons">Success icons created by hqrloveq - Flaticon</a>
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
            min-height: 500px;
            padding: 30px;
        }
        .success-container {
            text-align: center;
            max-width: 600px;
            margin: 0 auto;
            padding: 50px 30px;
            background: var(--white);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
        }
        .success-title {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        .success-message {
            font-size: 16px;
            color: var(--text-gray);
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .btn-continue {
            display: inline-block;
            background: var(--primary-color);
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s;
        }
        .btn-continue:hover {
            background: var(--primary-dark);
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

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }
            .success-container {
                padding: 30px 20px;
            }
            .success-title {
                font-size: 24px;
            }
            .footer-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .search-form input {
                width: 150px;
            }
        }
        @media (max-width: 480px) {
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
        <div class="main-menu">
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

        <!-- Main Content -->
        <div class="main-content">
            <div class="success-container">
<!--                <div class="success-icon"><img src="${pageContext.request.contextPath}/images/check.png" 
                                               alt="Đèn văn phòng"
                                               onerror="this.src='https://placehold.co/400x250/e8d5a8/8b6914?text=No+Image'"></div>-->
                <h1 class="success-title">ĐẶT HÀNG THÀNH CÔNG!</h1>
                <div class="success-message">
                    <p>Cảm ơn bạn đã mua hàng tại DecorLamp!</p>
                    <p>Đơn hàng của bạn đã được ghi nhận và đang được xử lý.</p>
                    <p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận đơn hàng.</p>
                </div>
                <a href="${pageContext.request.contextPath}/products" class="btn-continue">🛒 Tiếp tục mua sắm</a>
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
</body>
</html>