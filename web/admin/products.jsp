<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Quản lý sản phẩm - Admin</title>
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
        * { margin: 0; padding: 0; box-sizing: border-box; }
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
        .main-menu li a:hover { background: var(--primary-color); }
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
        .left-menu ul { list-style: none; margin-bottom: 20px; }
        .left-menu li a {
            display: block;
            padding: 8px 0;
            color: var(--text-gray);
            text-decoration: none;
            transition: all 0.3s;
        }
        .left-menu li a:hover { color: var(--primary-color); padding-left: 8px; }
        .content { flex: 1; }
        .admin-container { padding: 20px; background: var(--white); border-radius: 12px; }
        .admin-title { font-size: 24px; font-weight: 700; color: var(--primary-color); margin-bottom: 20px; }
        .add-btn { background: #28a745; color: white; padding: 8px 15px; border: none; border-radius: 6px; cursor: pointer; margin-bottom: 20px; }
        .search-form { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .search-form input, .search-form select { padding: 8px 12px; border: 1px solid var(--border-color); border-radius: 6px; }
        .search-form button { background: var(--primary-color); color: white; border: none; padding: 8px 15px; border-radius: 6px; cursor: pointer; }
        .product-table { width: 100%; border-collapse: collapse; }
        .product-table th, .product-table td { padding: 12px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .product-table th { background: var(--bg-gray); font-weight: 600; }
        .product-table img { width: 50px; height: 50px; object-fit: cover; border-radius: 6px; }
        .edit-btn { background: #007bff; color: white; padding: 4px 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .delete-btn { background: #dc3545; color: white; padding: 4px 10px; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .pagination { margin-top: 20px; display: flex; justify-content: center; gap: 8px; }
        .pagination a { padding: 6px 12px; border: 1px solid var(--border-color); color: var(--text-gray); text-decoration: none; border-radius: 5px; }
        .pagination a.active { background: var(--primary-color); color: white; }
        .message { padding: 10px; margin-bottom: 20px; border-radius: 6px; }
        .message-success { background: #d4edda; color: #155724; }
        .message-error { background: #f8d7da; color: #721c24; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; }
        .modal-content { background: white; width: 500px; margin: 50px auto; padding: 20px; border-radius: 12px; }
        .modal-content input, .modal-content textarea, .modal-content select { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid var(--border-color); border-radius: 6px; }
        .close { float: right; font-size: 24px; cursor: pointer; }
        @media (max-width: 768px) { .main-content { flex-direction: column; } .left-menu { width: 100%; } .product-table { display: block; overflow-x: auto; } }
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
                <h1 class="admin-title">🛍️ QUẢN LÝ SẢN PHẨM</h1>

                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="message message-success">${sessionScope.successMessage}</div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="message message-error">${sessionScope.errorMessage}</div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <button class="add-btn" onclick="openAddModal()">➕ Thêm sản phẩm</button>

                <form class="search-form" action="${pageContext.request.contextPath}/admin/products" method="get">
                    <input type="text" name="keyword" placeholder="Tìm theo tên..." value="${keywordFilter}">
                    <select name="category">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.id}" ${categoryFilter == c.id ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">🔍 Tìm kiếm</button>
                </form>

                <table class="product-table">
                    <thead><tr><th>ID</th><th>Ảnh</th><th>Tên sản phẩm</th><th>Giá</th><th>Danh mục</th><th>Tag</th><th>Thao tác</th></tr></thead>
                    <tbody>
                        <c:forEach items="${productList}" var="p">
                            <tr>
                                <td>${p.id}</td>
                                <td><img src="${p.image}" onerror="this.src='https://via.placeholder.com/50'"></td>
                                <td>${p.name}</td>
                                <td><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</td>
                                <td>${p.categoryId}</td>
                                <td>${p.tag}</td>
                                <td>
                                    <button class="edit-btn" onclick="openEditModal(${p.id}, '${p.name}', ${p.price}, '${p.image}', '${p.description}', '${p.tag}', ${p.categoryId})">✏️ Sửa</button>
                                    <button class="delete-btn" onclick="deleteProduct(${p.id}, '${p.name}')">🗑️ Xóa</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&keyword=${keywordFilter}&category=${categoryFilter}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3 id="modalTitle">Thêm sản phẩm</h3>
        <form id="productForm" method="post">
            <input type="hidden" name="action" id="formAction">
            <input type="hidden" name="id" id="productId">
            <input type="text" name="name" id="productName" placeholder="Tên sản phẩm" required>
            <input type="number" name="price" id="productPrice" placeholder="Giá" required>
            <input type="text" name="image" id="productImage" placeholder="URL hình ảnh">
            <textarea name="description" id="productDescription" rows="3" placeholder="Mô tả sản phẩm"></textarea>
            <select name="tag" id="productTag">
                <option value="">Chọn tag</option><option value="new">Hàng mới</option><option value="bestseller">Bán chạy</option><option value="sale">Giảm giá</option>
            </select>
            <select name="categoryId" id="productCategory">
                <option value="">Chọn danh mục</option>
                <c:forEach items="${categories}" var="c"><option value="${c.id}">${c.name}</option></c:forEach>
            </select>
            <button type="submit">Lưu</button>
            <button type="button" onclick="closeModal()">Hủy</button>
        </form>
    </div>
</div>

<script>
    function confirmLogout(e) { e.preventDefault(); if(confirm('Đăng xuất?')) window.location.href='${pageContext.request.contextPath}/logout'; }
    function deleteProduct(id, name) { if(confirm('Xóa sản phẩm "'+name+'"?')) window.location.href='${pageContext.request.contextPath}/admin/products?action=delete&id='+id; }
    function openAddModal() { document.getElementById('modalTitle').innerText='Thêm sản phẩm'; document.getElementById('formAction').value='add'; document.getElementById('productForm').reset(); document.getElementById('productModal').style.display='block'; document.getElementById('productForm').action='${pageContext.request.contextPath}/admin/products'; }
    function openEditModal(id, name, price, image, desc, tag, cid) { document.getElementById('modalTitle').innerText='Sửa sản phẩm'; document.getElementById('formAction').value='edit'; document.getElementById('productId').value=id; document.getElementById('productName').value=name; document.getElementById('productPrice').value=price; document.getElementById('productImage').value=image; document.getElementById('productDescription').value=desc; document.getElementById('productTag').value=tag; document.getElementById('productCategory').value=cid; document.getElementById('productModal').style.display='block'; document.getElementById('productForm').action='${pageContext.request.contextPath}/admin/products'; }
    function closeModal() { document.getElementById('productModal').style.display='none'; }
</script>
</body>
</html>