<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Quản lý khách hàng - Admin</title>
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
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f5f0;
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
            .admin-container {
                padding: 20px;
                background: var(--white);
                border-radius: 12px;
            }
            .admin-title {
                font-size: 24px;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 20px;
            }
            .search-form {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .search-form input {
                padding: 8px 12px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                width: 300px;
            }
            .search-form button {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 6px;
                cursor: pointer;
            }
            .customer-table {
                width: 100%;
                border-collapse: collapse;
            }
            .customer-table th, .customer-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid var(--border-color);
            }
            .customer-table th {
                background: var(--bg-gray);
                font-weight: 600;
            }
            .delete-btn {
                background: #dc3545;
                color: white;
                padding: 5px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 12px;
            }
            .delete-btn:hover {
                background: #c82333;
            }
            .pagination {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 8px;
            }
            .pagination a {
                padding: 6px 12px;
                border: 1px solid var(--border-color);
                color: var(--text-gray);
                text-decoration: none;
                border-radius: 5px;
            }
            .pagination a.active {
                background: var(--primary-color);
                color: white;
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
            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                }
                .left-menu {
                    width: 100%;
                }
                .customer-table {
                    display: block;
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="main-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">DASHBOARD</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">ĐƠN HÀNG</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products">SẢN PHẨM</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/customers">KHÁCH HÀNG</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/categories">DANH MỤC</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports">THỐNG KÊ</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home">VỀ TRANG CHỦ</a></li>
                    <li style="flex:1;"></li>
                    <li><span class="user-name">👤 Admin: ${sessionScope.user.fullName}</span></li>
                    <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">Đăng xuất</a></li>
                </ul>
            </div>

            <div class="main-content">
                <div class="left-menu">
                    <div class="menu-title">QUẢN LÝ</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/orders">📦 Đơn hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/products">🛍️ Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/categories">📁 Danh mục</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/reports">📈 Thống kê</a></li>
                    </ul>
                </div>

                <div class="content">
                    <div class="admin-container">
                        <h1 class="admin-title">👥 QUẢN LÝ KHÁCH HÀNG</h1>

                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="message message-success">${sessionScope.successMessage}</div>
                            <c:remove var="successMessage" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="message message-error">${sessionScope.errorMessage}</div>
                            <c:remove var="errorMessage" scope="session"/>
                        </c:if>

                        <form class="search-form" action="${pageContext.request.contextPath}/admin/customers" method="get">
                            <input type="text" name="keyword" placeholder="🔍 Tìm theo tên, email, số điện thoại..." value="${keywordFilter}">
                            <button type="submit">Tìm kiếm</button>
                        </form>

                        <table class="customer-table">
                            <thead>
                                <tr><th>ID</th><th>Họ tên</th><th>Email</th><th>SĐT</th><th>Địa chỉ</th><th>Thao tác</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${customerList}" var="c">
                                    <tr>
                                        <td>${c.id}</td>
                                        <td>${c.fullName}</td>
                                        <td>${c.email}</td>
                                        <td>${c.phone != null ? c.phone : '---'}</td>
                                        <td>${c.address != null ? c.address : '---'}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/customers?action=delete&id=${c.id}" 
                                               class="delete-btn" 
                                               onclick="return confirm('Xóa khách hàng ${c.fullName}? Hành động không thể hoàn tác!')">
                                                🗑️ Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty customerList}">
                                    <tr><td colspan="6" style="text-align:center;">📭 Không có khách hàng nào</td></tr>
                                </c:if>
                            </tbody>
                        </table>

                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="?page=${i}&keyword=${keywordFilter}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function confirmLogout(e) {
                e.preventDefault();
                if (confirm('Đăng xuất?'))
                    window.location.href = '${pageContext.request.contextPath}/logout';
            }
        </script>
    </body>
</html>