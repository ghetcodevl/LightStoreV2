<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Chi tiết đơn hàng #${order.id} - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .order-detail-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--primary-color);
        }
        .order-header h1 {
            font-size: 24px;
            color: var(--text-dark);
        }
        .order-header .order-id {
            font-size: 18px;
            color: var(--primary-color);
            font-weight: bold;
        }
        .order-info {
            background: var(--bg-gray);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        .order-info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .order-info-item {
            display: flex;
            gap: 10px;
        }
        .order-info-item .label {
            font-weight: 600;
            color: var(--text-dark);
            min-width: 100px;
        }
        .order-info-item .value {
            color: var(--text-gray);
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        .order-table th {
            background: var(--bg-gray);
            font-weight: 600;
        }
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }
        .total-row {
            text-align: right;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid var(--border-color);
        }
        .total-amount {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-color);
        }
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: var(--primary-color);
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        @media (max-width: 768px) {
            .order-info-grid {
                grid-template-columns: 1fr;
            }
            .order-table {
                display: block;
                overflow-x: auto;
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
                <form action="${pageContext.request.contextPath}/products" method="get">
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
    </div>

    <div class="order-detail-container">
        <div class="order-header">
            <h1>📋 CHI TIẾT ĐƠN HÀNG</h1>
            <div class="order-id">#${order.id}</div>
        </div>

        <!-- Thông tin đơn hàng -->
        <div class="order-info">
            <div class="order-info-grid">
                <div class="order-info-item">
                    <span class="label">👤 Khách hàng:</span>
                    <span class="value">${order.customerName}</span>
                </div>
                <div class="order-info-item">
                    <span class="label">📞 Số điện thoại:</span>
                    <span class="value">${order.phone}</span>
                </div>
                <div class="order-info-item">
                    <span class="label">📅 Ngày đặt:</span>
                    <span class="value"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                </div>
                <div class="order-info-item">
                    <span class="label">🚚 Địa chỉ giao:</span>
                    <span class="value">${order.address}</span>
                </div>
                <c:if test="${not empty order.note}">
                    <div class="order-info-item">
                        <span class="label">📝 Ghi chú:</span>
                        <span class="value">${order.note}</span>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Danh sách sản phẩm -->
        <h3>🛍️ SẢN PHẨM ĐÃ MUA</h3>
        <table class="order-table">
            <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                 </thead>
            <tbody>
                <c:forEach items="${orderItems}" var="item">
                    <tr>
                        <td><img class="product-img" src="${item.productImage}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'" alt="${item.productName}"></td>
                        <td><a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}" style="color: var(--text-dark); text-decoration: none;">${item.productName}</a></td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,##0"/>đ</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0"/>đ</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="total-row">
            <span style="font-size: 18px;">Tổng cộng: </span>
            <span class="total-amount"><fmt:formatNumber value="${order.total}" pattern="#,##0"/>đ</span>
        </div>

        <a href="${pageContext.request.contextPath}/profile" class="back-link">← Quay lại trang cá nhân</a>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-grid">
            <div class="footer-col"><h4>DECORLAMP</h4><p>Chuyên cung cấp đèn trang trí cao cấp.</p></div>
            <div class="footer-col"><h4>SẢN PHẨM</h4><ul><li><a href="#">Đèn Chùm Pha Lê</a></li><li><a href="#">Đèn Chùm Cổ Điển</a></li></ul></div>
            <div class="footer-col"><h4>HỖ TRỢ</h4><ul><li><a href="#">Hướng dẫn mua hàng</a></li><li><a href="#">Chính sách vận chuyển</a></li></ul></div>
            <div class="footer-col"><h4>LIÊN HỆ</h4><ul><li><i class="fas fa-phone"></i> 0868.506.503</li><li><i class="fas fa-envelope"></i> decorlamp@gmail.com</li></ul></div>
        </div>
        <div class="footer-bottom"><p>© 2024 DecorLamp. All rights reserved.</p></div>
    </footer>
</div>

<script>
    function confirmLogout(event) {
        event.preventDefault();
        if (confirm('Đăng xuất?')) window.location.href = '${pageContext.request.contextPath}/logout';
    }
</script>

<jsp:include page="chatbot.jsp" />
</body>
</html>