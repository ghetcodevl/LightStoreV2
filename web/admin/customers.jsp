<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý khách hàng - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .admin-container { padding: 20px; }
        .admin-title { font-size: 24px; color: #b8860b; margin-bottom: 20px; }
        .search-form { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .search-form input { padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px; width: 300px; }
        .search-form button { background: #b8860b; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; }
        .customer-table { width: 100%; border-collapse: collapse; }
        .customer-table th, .customer-table td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        .customer-table th { background: #fafafa; font-weight: 600; }
        .delete-btn { background: #dc3545; color: white; padding: 5px 12px; border: none; border-radius: 3px; cursor: pointer; }
        .delete-btn:hover { background: #c82333; }
        .pagination { margin-top: 20px; display: flex; justify-content: center; gap: 8px; }
        .pagination a { padding: 6px 12px; border: 1px solid #ddd; color: #333; text-decoration: none; border-radius: 5px; }
        .pagination a.active { background: #b8860b; color: white; }
        .message { padding: 10px; margin-bottom: 20px; border-radius: 5px; }
        .message-success { background: #d4edda; color: #155724; }
        .message-error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <div class="container">
        <!-- Top Menu -->
        <div class="top-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">📦 Đơn hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">🛍️ Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/categories">📁 Danh mục</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports">📈 Thống kê</a></li>
                <li><a href="${pageContext.request.contextPath}/Home">🏠 Về trang chủ</a></li>
                <li style="flex:1;"></li>
                <li><span class="user-name">👤 Admin: ${sessionScope.user.fullName}</span></li>
                <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">🚪 Đăng xuất</a></li>
            </ul>
        </div>

        <div class="main-content">
            <!-- Left menu admin -->
            <div class="left-menu">
                <div class="menu-title">Quản lý</div>
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
                    <h1 class="admin-title">👥 Quản lý khách hàng</h1>
                    
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
                        <c:if test="${not empty keywordFilter}">
                            <a href="${pageContext.request.contextPath}/admin/customers" style="background:#6c757d; color:white; padding:8px 15px; border-radius:5px; text-decoration:none;">Xóa bộ lọc</a>
                        </c:if>
                    </form>
                    
                    <table class="customer-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Số điện thoại</th>
                                <th>Địa chỉ</th>
                                <th>Ngày đăng ký</th>
                                <th>Thao tác</th>
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
                                        <button class="delete-btn" onclick="confirmDelete(${c.id})">🗑️ Xóa</button>
                                    </td>
                                 </tr>
                            </c:forEach>
                            <c:if test="${empty customerList}">
                                 <tr>
                                    <td colspan="7" style="text-align:center; padding:40px;">📭 Không có khách hàng nào</td>
                                 </tr>
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
        
        <div class="footer">
            <div class="footer-bottom">
                <p>© 2024 DecorLamp. All rights reserved.</p>
            </div>
        </div>
    </div>

    <script>
        function confirmLogout(event) { 
            event.preventDefault(); 
            if(confirm('Bạn có chắc chắn muốn đăng xuất?')) 
                window.location.href='${pageContext.request.contextPath}/logout'; 
        }
        
        function confirmDelete(id) { 
            if(confirm('Xóa khách hàng này? Hành động không thể hoàn tác!')) 
                window.location.href='${pageContext.request.contextPath}/admin/customers?action=delete&id='+id; 
        }
    </script>
</body>
</html>