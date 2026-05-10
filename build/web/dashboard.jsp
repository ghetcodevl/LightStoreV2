<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    Object user = session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Admin Dashboard - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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
            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
            }
            .dashboard-title {
                font-size: 28px;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid var(--primary-color);
                display: inline-block;
            }
            .stats-row {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .stat-card {
                flex: 1;
                min-width: 200px;
                background: var(--white);
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                border-left: 4px solid var(--primary-color);
            }
            .stat-card h3 {
                font-size: 13px;
                color: var(--text-gray);
                margin-bottom: 10px;
                text-transform: uppercase;
            }
            .stat-card .stat-number {
                font-size: 32px;
                font-weight: bold;
                color: var(--primary-color);
            }
            .chart-section {
                background: var(--white);
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 30px;
                border: 1px solid var(--border-color);
            }
            .chart-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .chart-buttons button {
                background: var(--bg-gray);
                border: 1px solid var(--border-color);
                padding: 6px 15px;
                margin-left: 8px;
                border-radius: 20px;
                cursor: pointer;
            }
            .chart-buttons button.active {
                background: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            .orders-section {
                background: var(--white);
                border-radius: 12px;
                padding: 20px;
                border: 1px solid var(--border-color);
            }
            .filter-form {
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: wrap;
            }
            .filter-form input {
                padding: 8px 12px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                width: 250px;
            }
            .filter-form button {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 8px 15px;
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
                font-weight: 600;
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
            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                }
                .left-menu {
                    width: 100%;
                }
                .stats-row {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Main Menu -->
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
                    <div class="dashboard-container">
                        <h1 class="dashboard-title">📊 TỔNG QUAN</h1>

                        <div class="stats-row">
                            <div class="stat-card">
                                <h3>Tổng đơn hàng</h3>
                                <div class="stat-number">${totalOrders != null ? totalOrders : 0}</div>
                            </div>
                            <div class="stat-card">
                                <h3>Doanh thu</h3>
                                <div class="stat-number"><fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" pattern="#,##0"/>₫</div>
                            </div>
                            <div class="stat-card">
                                <h3>Sản phẩm</h3>
                                <div class="stat-number">${totalProducts != null ? totalProducts : 0}</div>
                            </div>
                            <div class="stat-card">
                                <h3>Khách hàng</h3>
                                <div class="stat-number">${totalUsers != null ? totalUsers : 0}</div>
                            </div>
                        </div>

                        <div class="chart-section">
                            <div class="chart-header">
                                <h3>📈 Thống kê đơn hàng</h3>
                                <div class="chart-buttons">
                                    <button data-range="week" class="active">Tuần này</button>
                                    <button data-range="month">Tháng này</button>
                                    <button data-range="year">Năm nay</button>
                                </div>
                            </div>
                            <canvas id="orderChart" width="400" height="200"></canvas>
                        </div>

                        <div class="orders-section">
                            <div class="orders-header">
                                <h3>📋 Đơn hàng gần đây</h3>
                                <form class="filter-form" action="${pageContext.request.contextPath}/admin/orders" method="get">
                                    <input type="text" name="keyword" placeholder="🔍 Tìm theo mã đơn, tên KH, SĐT..." value="${param.keyword}">
                                    <button type="submit">Lọc</button>
                                    <c:if test="${not empty param.keyword}">
                                        <a href="${pageContext.request.contextPath}/admin/orders" style="color: var(--primary-color);">Xóa bộ lọc</a>
                                    </c:if>
                                </form>
                            </div>
                            <table class="order-table">
                                <thead>
                                <td><th>Mã đơn</th><th>Khách hàng</th><th>Ngày đặt</th><th>Tổng tiền</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orderList}" var="order">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td>${order.customerName != null ? order.customerName : 'Khách vãng lai'}</td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td><fmt:formatNumber value="${order.total}" pattern="#,##0"/>₫</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty orderList}">
                                        <tr><td colspan="4" style="text-align:center;">📭 Không có đơn hàng nào</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function confirmLogout(event) {
                event.preventDefault();
                        if (confirm('Đăng xuất?'))
                    window.location.href = '${pageContext.request.contextPath}/logout';
            }

            // Dữ liệu biểu đồ mẫu
            const chartData = {
                week: {
                    labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
                    data: [12, 19, 15, 17, 14, 22, 18]
                },
                month: {
                    labels: ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4'],
                    data: [45, 52, 49, 63]
                },
                year: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                    data: [120, 135, 142, 168, 190, 210, 205, 198, 215, 230, 245, 260]
                }
            };

            let myChart;
            const ctx = document.getElementById('orderChart').getContext('2d');

            function renderChart(range) {
                const data = chartData[range];
                if (myChart)
                    myChart.destroy();
                myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.labels,
                        datasets: [{
                                label: 'Số đơn hàng',
                                data: data.data,
                                backgroundColor: '#c0392b',
                                borderRadius: 5
                            }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {beginAtZero: true, title: {display: true, text: 'Số đơn hàng'}}
                        }
                    }
                });
            }

            document.querySelectorAll('.chart-buttons button').forEach(btn => {
                btn.addEventListener('click', function () {
                    document.querySelectorAll('.chart-buttons button').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    renderChart(this.getAttribute('data-range'));
                });
            });

            renderChart('week');
        </script>
    </body>
</html>