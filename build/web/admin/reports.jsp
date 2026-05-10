<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Thống kê - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        :root { --primary-color: #c0392b; --text-dark: #1a1a1a; --text-gray: #555; --bg-gray: #f8f8f8; --border-color: #e0e0e0; --white: #ffffff; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f5f5f0; margin: 0; padding: 0; }
        .main-menu { background: var(--text-dark); position: fixed; top: 0; left: 0; width: 100%; z-index: 1000; }
        .main-menu ul { list-style: none; display: flex; justify-content: center; align-items: center; padding: 0 25px; margin: 0; flex-wrap: wrap; max-width: 1400px; margin: 0 auto; }
        .main-menu li a { display: block; color: var(--white); padding: 15px 25px; text-decoration: none; font-size: 14px; font-weight: 500; text-transform: uppercase; transition: 0.3s; }
        .main-menu li a:hover { background: var(--primary-color); }
        .container { margin-top: 65px; max-width: 95%; margin-left: auto; margin-right: auto; background: var(--white); box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        .main-content { display: flex; gap: 30px; padding: 30px; }
        .left-menu { width: 260px; background: var(--bg-gray); padding: 15px; border-radius: 10px; }
        .menu-title { font-size: 18px; font-weight: 700; color: var(--text-dark); padding: 10px 0; margin-bottom: 15px; border-bottom: 2px solid var(--primary-color); display: inline-block; }
        .left-menu ul { list-style: none; margin-bottom: 20px; }
        .left-menu li a { display: block; padding: 8px 0; color: var(--text-gray); text-decoration: none; transition: all 0.3s; }
        .left-menu li a:hover { color: var(--primary-color); padding-left: 8px; }
        .content { flex: 1; }
        .admin-container { padding: 20px; }
        .admin-title { font-size: 24px; font-weight: 700; color: var(--primary-color); margin-bottom: 20px; }
        .report-tabs { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .report-tab { background: var(--bg-gray); padding: 8px 20px; border-radius: 20px; text-decoration: none; color: var(--text-gray); transition: 0.3s; }
        .report-tab.active { background: var(--primary-color); color: white; }
        .stats-card { background: var(--white); border-radius: 12px; padding: 20px; margin-bottom: 20px; border: 1px solid var(--border-color); }
        .stats-row { display: flex; gap: 20px; justify-content: center; }
        .stat-item { min-width: 200px; background: var(--bg-gray); padding: 30px; border-radius: 12px; text-align: center; border-left: 4px solid var(--primary-color); }
        .stat-number { font-size: 36px; font-weight: bold; color: var(--primary-color); }
        .product-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .product-table th, .product-table td { padding: 10px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .product-table th { background: var(--bg-gray); font-weight: 600; }
        canvas { max-height: 400px; width: 100%; }
        @media (max-width: 768px) { .main-content { flex-direction: column; } .left-menu { width: 100%; } .stats-row { flex-direction: column; align-items: center; } }
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
                <h1 class="admin-title">📈 THỐNG KÊ - BÁO CÁO</h1>
                
                <div class="report-tabs">
                    <a href="?type=revenue" class="report-tab ${reportType == 'revenue' ? 'active' : ''}">💰 Doanh thu</a>
                    <a href="?type=topProducts" class="report-tab ${reportType == 'topProducts' ? 'active' : ''}">🏆 Top sản phẩm</a>
                    <a href="?type=orderStats" class="report-tab ${reportType == 'orderStats' ? 'active' : ''}">📊 Tổng quan đơn hàng</a>
                </div>
                
                <!-- Doanh thu theo tháng -->
                <c:if test="${reportType == 'revenue'}">
                    <div class="stats-card">
                        <h3>💰 Doanh thu theo tháng năm ${selectedYear}</h3>
                        <canvas id="revenueChart"></canvas>
                        <form style="margin-top: 20px;">
                            <select name="year" onchange="this.form.submit()" style="padding:8px; border-radius:6px; border:1px solid var(--border-color);">
                                <option value="2023" ${selectedYear == 2023 ? 'selected' : ''}>2023</option>
                                <option value="2024" ${selectedYear == 2024 ? 'selected' : ''}>2024</option>
                                <option value="2025" ${selectedYear == 2025 ? 'selected' : ''}>2025</option>
                            </select>
                            <input type="hidden" name="type" value="revenue">
                        </form>
                    </div>
                    <script>
                        var revenueData = [<c:forEach items="${revenueData}" var="item" varStatus="status">${item[1]}${not status.last ? ',' : ''}</c:forEach>];
                        new Chart(document.getElementById('revenueChart'), { 
                            type: 'bar', 
                            data: { labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'], 
                                    datasets: [{ label: 'Doanh thu (VNĐ)', data: revenueData, backgroundColor: '#c0392b' }] }, 
                            options: { responsive: true, scales: { y: { beginAtZero: true } } } 
                        });
                    </script>
                </c:if>
                
                <!-- Top sản phẩm bán chạy -->
                <c:if test="${reportType == 'topProducts'}">
                    <div class="stats-card">
                        <h3>🏆 Top sản phẩm bán chạy</h3>
                        <table class="product-table">
                            <thead><tr><th>STT</th><th>Sản phẩm</th><th>Số lượng bán</th><th>Doanh thu</th></tr></thead>
                            <tbody>
                                <c:forEach items="${topProducts}" var="p" varStatus="st">
                                    <tr><td>${st.count}</td><td>${p[1]}</td><td>${p[2]}</td><td><fmt:formatNumber value="${p[3]}" pattern="#,##0"/>₫</td></tr>
                                </c:forEach>
                                <c:if test="${empty topProducts}"><tr><td colspan="4" style="text-align:center;">Chưa có dữ liệu</td></tr></c:if>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                
                <!-- Tổng quan đơn hàng -->
                <c:if test="${reportType == 'orderStats'}">
                    <div class="stats-row">
                        <div class="stat-item">
                            <h3>📦 Tổng đơn hàng</h3>
                            <div class="stat-number">${totalOrders}</div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    function confirmLogout(e) { e.preventDefault(); if(confirm('Đăng xuất?')) window.location.href='${pageContext.request.contextPath}/logout'; }
</script>
</body>
</html>