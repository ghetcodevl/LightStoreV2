<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .admin-container { padding: 20px; }
        .admin-title { font-size: 24px; color: #b8860b; margin-bottom: 20px; }
        .add-form { display: flex; gap: 10px; margin-bottom: 20px; align-items: center; }
        .add-form input { padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px; width: 300px; }
        .add-form button { background: #28a745; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; }
        .category-table { width: 100%; border-collapse: collapse; }
        .category-table th, .category-table td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        .category-table th { background: #fafafa; font-weight: 600; }
        .edit-btn { background: #007bff; color: white; padding: 4px 10px; border: none; border-radius: 3px; cursor: pointer; }
        .delete-btn { background: #dc3545; color: white; padding: 4px 10px; border: none; border-radius: 3px; cursor: pointer; }
        .message { padding: 10px; margin-bottom: 20px; border-radius: 5px; }
        .message-success { background: #d4edda; color: #155724; }
        .message-error { background: #f8d7da; color: #721c24; }
        .inline-form { display: inline; }
    </style>
</head>
<body>
    <div class="container">
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
                    <h1 class="admin-title">📁 Quản lý danh mục</h1>
                    
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="message message-success">${sessionScope.successMessage}</div>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>
                    
                    <form class="add-form" action="${pageContext.request.contextPath}/admin/categories" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="text" name="name" placeholder="Tên danh mục mới" required>
                        <button type="submit">➕ Thêm danh mục</button>
                    </form>
                    
                    <table class="category-table">
                        <thead><tr><th>ID</th><th>Tên danh mục</th><th>Thao tác</th></tr></thead>
                        <tbody>
                            <c:forEach items="${categoryList}" var="c">
                                <tr>
                                    <td>${c.id}</td>
                                    <td>
                                        <form class="inline-form" action="${pageContext.request.contextPath}/admin/categories" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <input type="text" name="name" value="${c.name}" style="padding:4px;">
                                            <button type="submit" class="edit-btn">✏️ Sửa</button>
                                        </form>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" class="delete-btn" onclick="return confirm('Xóa danh mục này?')">🗑️ Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmLogout(event) { event.preventDefault(); if(confirm('Đăng xuất?')) window.location.href='${pageContext.request.contextPath}/logout'; }
    </script>
</body>
</html>