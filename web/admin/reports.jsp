<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        .admin-container { padding: 20px; }
        .admin-title { font-size: 24px; color: #b8860b; margin-bottom: 20px; }
        .report-tabs { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .report-tab { background: #f5f5f5; padding: 8px 20px; border-radius: 5px; text-decoration: none; color: #333; }
        .report-tab.active { background: #b8860b; color: white; }
        .stats-card { background: white; border-radius: 10px; padding: 20px; margin-bottom: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        .stats-row { display: flex; gap: 20px; flex-wrap: wrap; }
        .stat-item { flex: 1; min-width: 150px; background: #f9f5ed; padding: 15px; border-radius: 8px; text-align: center; border-left: 4px solid #b8860b; }
        .stat-number { font-size: 28px; font-weight: bold; color: #b8860b; }
        .product-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .product-table th, .product-table td { padding: 10px; text-align: left; border-bottom: 1px solid #eee; }
        .product-table th { background: #fafafa; }
        canvas { max-height: 400px; width: 100%; }
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
                    <h1 class="admin-title">📈 Thống kê - Báo cáo</h1>
                    
                    <div class="report-tabs">
                        <a href="?type=revenue" class="report-tab ${reportType == 'revenue' ? 'active' : ''}">💰 Doanh thu</a>
                        <a href="?type=topProducts" class="report-tab ${reportType == 'topProducts' ? 'active' : ''}">🏆 Top sản phẩm</a>
                        <a href="?type=orderStats" class="report-tab ${reportType == 'orderStats' ? 'active' : ''}">📊 Trạng thái đơn hàng</a>
                    </div>
                    
                    <!-- Doanh thu theo tháng -->
                    <c:if test="${reportType == 'revenue'}">
                        <div class="stats-card">
                            <h3>💰 Doanh thu theo tháng năm ${selectedYear}</h3>
                            <canvas id="revenueChart"></canvas>
                            <form style="margin-top: 20px;">
                                <select name="year" onchange="this.form.submit()">
                                    <option value="2023" ${selectedYear == 2023 ? 'selected' : ''}>2023</option>
                                    <option value="2024" ${selectedYear == 2024 ? 'selected' : ''}>2024</option>
                                    <option value="2025" ${selectedYear == 2025 ? 'selected' : ''}>2025</option>
                                </select>
                                <input type="hidden" name="type" value="revenue">
                            </form>
                        </div>
                        <script>
                            var revenueData = [
                                <c:forEach items="${revenueData}" var="item" varStatus="status">
                                    ${item[2]}${not status.last ? ',' : ''}
                                </c:forEach>
                            ];
                            var ctx = document.getElementById('revenueChart').getContext('2d');
                            new Chart(ctx, {
                                type: 'bar',
                                data: { 
                                    labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'], 
                                    datasets: [{ label: 'Doanh thu (VNĐ)', data: revenueData, backgroundColor: '#b8860b' }] 
                                },
                                options: { responsive: true, scales: { y: { beginAtZero: true } } }
                            });
                        </script>
                    </c:if>
                    
                    <!-- Top sản phẩm bán chạy -->
                    <c:if test="${reportType == 'topProducts'}">
                        <div class="stats-card">
                            <h3>🏆 Top sản phẩm bán chạy</h3>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng bán</th>
                                        <th>Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${topProducts}" var="p" varStatus="st">
                                        <tr>
                                            <td>${st.count}</td>
                                            <td>${p[1]}</td>
                                            <td>${p[2]}</td>
                                            <td><fmt:formatNumber value="${p[3]}" pattern="#,##0"/> ₫</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty topProducts}">
                                        <tr><td colspan="4" style="text-align:center;">Chưa có dữ liệu</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    
                    <!-- Thống kê trạng thái đơn hàng -->
                    <c:if test="${reportType == 'orderStats'}">
                        <div class="stats-row">
                            <div class="stat-item"><h3>Tổng đơn</h3><div class="stat-number">${totalOrders}</div></div>
                            <div class="stat-item"><h3>Chờ xác nhận</h3><div class="stat-number">${pending}</div></div>
                            <div class="stat-item"><h3>Đã xác nhận</h3><div class="stat-number">${confirmed}</div></div>
                            <div class="stat-item"><h3>Đang giao</h3><div class="stat-number">${shipped}</div></div>
                            <div class="stat-item"><h3>Đã giao</h3><div class="stat-number">${delivered}</div></div>
                            <div class="stat-item"><h3>Đã hủy</h3><div class="stat-number">${cancelled}</div></div>
                        </div>
                        <canvas id="orderStatsChart"></canvas>
                        <script>
                            var ctx2 = document.getElementById('orderStatsChart').getContext('2d');
                            new Chart(ctx2, {
                                type: 'pie',
                                data: { 
                                    labels: ['Chờ xác nhận', 'Đã xác nhận', 'Đang giao', 'Đã giao', 'Đã hủy'], 
                                    datasets: [{ 
                                        data: [${pending}, ${confirmed}, ${shipped}, ${delivered}, ${cancelled}],
                                        backgroundColor: ['#ffc107', '#17a2b8', '#007bff', '#28a745', '#dc3545']
                                    }] 
                                },
                                options: { responsive: true }
                            });
                        </script>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmLogout(event) { 
            event.preventDefault(); 
            if(confirm('Đăng xuất?')) 
                window.location.href='${pageContext.request.contextPath}/logout'; 
        }
    </script>
</body>
</html>