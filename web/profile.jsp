<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Thông tin tài khoản - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .profile-container {
            display: flex;
            gap: 30px;
            padding: 30px;
        }
        .profile-sidebar {
            width: 280px;
            background: var(--bg-gray);
            border-radius: 12px;
            padding: 20px;
            height: fit-content;
        }
        .profile-sidebar .avatar {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-sidebar .avatar i {
            font-size: 80px;
            color: var(--primary-color);
        }
        .profile-sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-sidebar .nav-links {
            list-style: none;
        }
        .profile-sidebar .nav-links li {
            margin-bottom: 10px;
        }
        .profile-sidebar .nav-links li a {
            display: block;
            padding: 10px 15px;
            background: white;
            border-radius: 8px;
            color: var(--text-dark);
            text-decoration: none;
            transition: all 0.3s;
        }
        .profile-sidebar .nav-links li a:hover,
        .profile-sidebar .nav-links li a.active {
            background: var(--primary-color);
            color: white;
        }
        .profile-content {
            flex: 1;
            background: var(--white);
            border-radius: 12px;
            padding: 25px;
            border: 1px solid var(--border-color);
        }
        .profile-content h2 {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary-color);
            display: inline-block;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        .btn-save {
            background: var(--primary-color);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .order-table th, .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        .order-table th {
            background: var(--bg-gray);
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 6px;
        }
        .message-success {
            background: #d4edda;
            color: #155724;
        }
        .message-error {
            background: #f8d7da;
            color: #721c24;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
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

    <div class="profile-container">
        <!-- Sidebar -->
        <div class="profile-sidebar">
            <div class="avatar">
                <i class="fas fa-user-circle"></i>
            </div>
            <h3>${sessionScope.user.fullName}</h3>
            <ul class="nav-links">
                <li><a href="#" onclick="showTab('info')" class="active" id="tab-info-link">📋 Thông tin tài khoản</a></li>
                <li><a href="#" onclick="showTab('orders')" id="tab-orders-link">📦 Lịch sử đơn hàng</a></li>
                <li><a href="#" onclick="showTab('password')" id="tab-password-link">🔑 Đổi mật khẩu</a></li>
            </ul>
        </div>

        <!-- Content -->
        <div class="profile-content">
            <div id="info" class="tab-content active">
                <h2>Thông tin tài khoản</h2>
                
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="message message-success">${sessionScope.successMessage}</div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="message message-error">${sessionScope.errorMessage}</div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <input type="hidden" name="action" value="update">
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="fullName" value="${sessionScope.user.fullName}" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="${sessionScope.user.email}" readonly disabled style="background:#f0f0f0;">
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="tel" name="phone" value="${sessionScope.user.phone}">
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <input type="text" name="address" value="${sessionScope.user.address}">
                    </div>
                    <button type="submit" class="btn-save">Cập nhật</button>
                </form>
            </div>

            <div id="orders" class="tab-content">
                <h2>Lịch sử đơn hàng</h2>
                
                <c:choose>
                    <c:when test="${not empty orderList}">
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Địa chỉ</th>
                                    <th>Chi tiết</th>
                                 </thead>
                            <tbody>
                                <c:forEach items="${orderList}" var="order">
                                    <tr>
                                        <td>#${order.id}</td>
                                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatNumber value="${order.total}" pattern="#,##0"/>đ</span></td>
                                        <td>${order.address}</td>
                                        <td><a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" style="color: var(--primary-color);">📄 Xem chi tiết</a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Bạn chưa có đơn hàng nào.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn-save" style="display: inline-block; margin-top: 15px;">Mua sắm ngay</a>
                    </c:otherwise>
                </c:choose>
            </div>

            <div id="password" class="tab-content">
                <h2>Đổi mật khẩu</h2>
                
                <form action="${pageContext.request.contextPath}/profile" method="post">
                    <input type="hidden" name="action" value="change-password">
                    <div class="form-group">
                        <label>Mật khẩu cũ</label>
                        <input type="password" name="oldPassword" required>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu mới</label>
                        <input type="password" name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label>Xác nhận mật khẩu mới</label>
                        <input type="password" name="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn-save">Đổi mật khẩu</button>
                </form>
            </div>
        </div>
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
    
    function showTab(tabName) {
        document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
        document.getElementById(tabName).classList.add('active');
        
        document.querySelectorAll('.nav-links li a').forEach(link => link.classList.remove('active'));
        if (tabName === 'info') document.getElementById('tab-info-link').classList.add('active');
        if (tabName === 'orders') document.getElementById('tab-orders-link').classList.add('active');
        if (tabName === 'password') document.getElementById('tab-password-link').classList.add('active');
    }
</script>

<jsp:include page="chatbot.jsp" />
</body>
</html>