<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Kiểm tra đăng nhập admin (giả sử session attribute "user" có role="admin")
    // Trong LoginServlet đã set session "user" và khi role=admin thì redirect đến dashboard.jsp
    Object user = session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
    // Có thể kiểm tra thêm role nếu cần, ở đây giả sử chỉ admin mới vào được trang này
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Admin Dashboard - DecorLamp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
        <!-- Chart.js CDN cho biểu đồ -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
        <style>
            /* Các style bổ sung cho dashboard */
            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px;
            }
            .dashboard-title {
                font-size: 28px;
                color: #ff6600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #ff6600;
                display: inline-block;
            }
            /* Stats cards */
            .stats-row {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .stat-card {
                flex: 1;
                min-width: 200px;
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
                border-left: 5px solid #ff6600;
                transition: transform 0.2s;
            }
            .stat-card:hover {
                transform: translateY(-3px);
            }
            .stat-card h3 {
                font-size: 14px;
                color: #888;
                margin-bottom: 10px;
                text-transform: uppercase;
            }
            .stat-card .stat-number {
                font-size: 32px;
                font-weight: bold;
                color: #333;
            }
            .stat-card .stat-unit {
                font-size: 14px;
                color: #888;
                margin-left: 5px;
            }
            /* Chart section */
            .chart-section {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }
            .chart-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 10px;
            }
            .chart-header h3 {
                font-size: 18px;
                color: #333;
            }
            .chart-buttons button {
                background: #f5f5f5;
                border: 1px solid #ddd;
                padding: 6px 15px;
                margin-left: 8px;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.2s;
            }
            .chart-buttons button.active {
                background: #ff6600;
                color: white;
                border-color: #ff6600;
            }
            canvas {
                max-height: 300px;
                width: 100%;
            }
            /* Orders table */
            .orders-section {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }
            .orders-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 10px;
            }
            .filter-form {
                display: flex;
                gap: 10px;
                align-items: center;
            }
            .filter-form select, .filter-form input {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .filter-form button {
                background: #ff6600;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 5px;
                cursor: pointer;
            }
            .order-table {
                width: 100%;
                border-collapse: collapse;
            }
            .order-table th, .order-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            .order-table th {
                background: #fafafa;
                color: #333;
                font-weight: 600;
            }
            .status-badge {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
            }
            .status-pending {
                background: #fff3cd;
                color: #856404;
            }
            .status-confirmed {
                background: #d1ecf1;
                color: #0c5460;
            }
            .status-shipped {
                background: #cce5ff;
                color: #004085;
            }
            .status-delivered {
                background: #d4edda;
                color: #155724;
            }
            .status-cancelled {
                background: #f8d7da;
                color: #721c24;
            }
            .confirm-btn {
                background: #28a745;
                color: white;
                border: none;
                padding: 5px 12px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 12px;
            }
            .confirm-btn:hover {
                background: #218838;
            }
            .confirm-btn:disabled {
                background: #ccc;
                cursor: not-allowed;
            }
            .pagination {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 8px;
            }
            .pagination a {
                padding: 6px 12px;
                border: 1px solid #ddd;
                color: #333;
                text-decoration: none;
                border-radius: 5px;
            }
            .pagination a.active {
                background: #ff6600;
                color: white;
                border-color: #ff6600;
            }
            @media (max-width: 768px) {
                .stats-row {
                    flex-direction: column;
                }
                .filter-form {
                    flex-wrap: wrap;
                }
                .order-table {
                    font-size: 12px;
                }
                .order-table th, .order-table td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Banner -->
            <!--        <div class="banner">
                        <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner" onerror="this.src='https://via.placeholder.com/1200x300?text=DecorLamp'">
                    </div>-->

            <!-- Top Menu (có thêm menu cho admin) -->
            <div class="top-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/dashboard.jsp">📊 Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/orders">📦 Quản lý đơn hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/products">🛍️ Quản lý sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/Home">🏠 Về trang chủ</a></li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                            <li style="flex: 1;"></li>
                            <li><span class="user-name">👤 Admin: ${sessionScope.user.fullName}</span></li>
                            <li><a href="#" onclick="confirmLogout(event)" class="logout-btn">🚪 Đăng xuất</a></li>
                            </c:when>
                            <c:otherwise>
                            <li style="flex: 1;"></li>
                            <li><a href="${pageContext.request.contextPath}/LoginServlet">🔐 Đăng nhập</a></li>
                            </c:otherwise>
                        </c:choose>
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

            <div class="main-content">
                <!-- Left menu admin -->
                <div class="left-menu">
                    <div class="menu-title">Quản lý</div>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/orders">📦 Đơn hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/products.jsp">🛍️ Sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/categories">📁 Danh mục</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/reports">📈 Thống kê</a></li>
                    </ul>
                </div>

                <div class="content">
                    <div class="dashboard-container">
                        <h1 class="dashboard-title">📊 Tổng quan</h1>

                        <!-- Thẻ thống kê (dữ liệu giả, thực tế lấy từ request/session) -->
                        <div class="stats-row">
                            <div class="stat-card">
                                <h3>Tổng đơn hàng</h3>
                                <div class="stat-number">${totalOrders != null ? totalOrders : 0}</div>
                            </div>
                            <div class="stat-card">
                                <h3>Doanh thu</h3>
                                <div class="stat-number"><fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                            </div>
                            <div class="stat-card">
                                <h3>Đơn chờ xác nhận</h3>
                                <div class="stat-number">${pendingOrders != null ? pendingOrders : 0}</div>
                            </div>
                            <div class="stat-card">
                                <h3>Đã giao thành công</h3>
                                <div class="stat-number">${deliveredOrders != null ? deliveredOrders : 0}</div>
                            </div>
                        </div>

                        <!-- Biểu đồ thống kê -->
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

                        <!-- Bảng đơn hàng gần đây -->
                        <div class="orders-section">
                            <div class="orders-header">
                                <h3>📋 Đơn hàng gần đây</h3>
                                <form class="filter-form" action="${pageContext.request.contextPath}/admin/dashboard" method="get">
                                    <select name="status">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="confirmed" ${param.status == 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="shipped" ${param.status == 'shipped' ? 'selected' : ''}>Đang giao</option>
                                        <option value="delivered" ${param.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                        <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                    <input type="text" name="keyword" placeholder="Tìm theo mã đơn, tên KH" value="${param.keyword}">
                                    <button type="submit">Lọc</button>
                                </form>
                            </div>
                            <table class="order-table">
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty orderList}">
                                            <c:forEach var="order" items="${orderList}">
                                                <tr>
                                                    <td>#${order.id}</td>
                                                    <td>${order.customerName}</td>
                                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td><fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫" groupingUsed="true"/></td>
                                                    <td>
                                                        <span class="status-badge status-${order.status}">
                                                            <c:choose>
                                                                <c:when test="${order.status == 'pending'}">Chờ xác nhận</c:when>
                                                                <c:when test="${order.status == 'confirmed'}">Đã xác nhận</c:when>
                                                                <c:when test="${order.status == 'shipped'}">Đang giao</c:when>
                                                                <c:when test="${order.status == 'delivered'}">Đã giao</c:when>
                                                                <c:when test="${order.status == 'cancelled'}">Đã hủy</c:when>
                                                                <c:otherwise>${order.status}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:if test="${order.status == 'pending'}">
                                                            <form action="${pageContext.request.contextPath}/admin/confirmOrder" method="post" style="display:inline;">
                                                                <input type="hidden" name="orderId" value="${order.id}">
                                                                <button type="submit" class="confirm-btn" onclick="return confirm('Xác nhận đơn hàng #${order.id}?')">Xác nhận</button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${order.status != 'pending'}">
                                                            <button class="confirm-btn" disabled style="background:#ccc;">Đã xử lý</button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" style="text-align:center;">Không có đơn hàng nào.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                            <!-- Phân trang giả định -->
                            <c:if test="${totalPages > 1}">
                                <div class="pagination">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?page=${i}&status=${param.status}&keyword=${param.keyword}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer class="footer">
                <div class="footer-container">
                    <div class="footer-row">
                        <div class="footer-col">
                            <h3>🎯 SUNDECOR</h3>
                            <p class="footer-desc">
                                Chuyên cung cấp các sản phẩm đèn trang trí cao cấp, đèn chùm pha lê, 
                                đèn cổ điển, đèn đồng... Với thiết kế sang trọng, chất lượng vượt trội.
                            </p>
                            <div class="footer-social">
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="Instagram" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="Twitter" width="30"></a>
                                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/145/145802.png" alt="Zalo" width="30"></a>
                            </div>
                        </div>
                        <div class="footer-col">
                            <h3>✨ SẢN PHẨM</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng Mới</a></li>
                                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Hàng Giảm Giá</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h3>📞 HỖ TRỢ</h3>
                            <ul>
                                <li><a href="#">Hướng dẫn mua hàng</a></li>
                                <li><a href="#">Chính sách vận chuyển</a></li>
                                <li><a href="#">Chính sách đổi trả</a></li>
                                <li><a href="#">Chính sách bảo hành</a></li>
                                <li><a href="#">Phương thức thanh toán</a></li>
                                <li><a href="#">Câu hỏi thường gặp</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h3>🏢 THÔNG TIN CÔNG TY</h3>
                            <ul class="footer-contact">
                                <li><strong>Công ty Cổ phần DecorLamp</strong></li>
                                <li>MST: 0105875457</li>
                                <li>📞 Hotline: 0965.69.8866</li>
                                <li>📧 Email: decorlamp@gmail.com</li>
                                <li>📍 Showroom 1: Số 8A Phạm Hùng, P. Mễ Trì, Q. Nam Từ Liêm, HN</li>
                                <li>📍 Showroom 2: Số 73 Ỷ Lan, P. Hiệp Tân, Q. Tân Phú, TP.HCM</li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-newsletter">
                        <div class="newsletter-content">
                            <h3>🎁 ĐĂNG KÝ NHẬN MÃ GIẢM GIÁ</h3>
                            <p>Nhận ưu đãi 10% cho đơn hàng đầu tiên khi đăng ký nhận bản tin</p>
                            <form action="${pageContext.request.contextPath}/subscribe" method="post" class="newsletter-form">
                                <input type="email" name="email" placeholder="Nhập email của bạn" required>
                                <button type="submit">Đăng ký</button>
                            </form>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>© 2024 DecorLamp. All rights reserved. Designed by YourTeam</p>
                        <p>Nhóm thực hiện: Đặng Minh Quốc (01/01/2005), Lại Thế Trường (02/02/2005), Lê Anh Tuấn (03/03/2005)</p>
                    </div>
                </div>
            </footer>
        </div>

        <!--        <script>
                    // Dữ liệu thống kê theo tuần/tháng/năm - giả định từ backend truyền qua JSON hoặc embed script
                    // Trong thực tế, bạn có thể gán các mảng từ request attributes.
                    // Ở đây tạo dữ liệu mẫu để biểu đồ hoạt động.
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
                    if (myChart) myChart.destroy();
                    myChart = new Chart(ctx, {
                    type: 'bar',
                            data: {
                            labels: data.labels,
                                    datasets: [{
                                    label: 'Số đơn hàng',
                                            data: data.data,
                                            backgroundColor: 'rgba(255, 102, 0, 0.6)',
                                            borderColor: '#ff6600',
                                            borderWidth: 1,
                                            borderRadius: 5
                                    }]
                            },
                            options: {
                            responsive: true,
                                    maintainAspectRatio: true,
                                    scales: {
                                    y: {
                                    beginAtZero: true,
                                            title: { display: true, text: 'Số đơn hàng' }
                                    },
                                            x: {
                                            title: { display: true, text: range === 'week' ? 'Ngày trong tuần' : (range === 'month' ? 'Tuần' : 'Tháng') }
                                            }
                                    }
                            }
                    });
                    }
        
                    // Sự kiện cho nút chuyển biểu đồ
                    document.querySelectorAll('.chart-buttons button').forEach(btn => {
                    btn.addEventListener('click', function() {
                    document.querySelectorAll('.chart-buttons button').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    const range = this.getAttribute('data-range');
                    renderChart(range);
                    });
                    });
                    // Khởi tạo biểu đồ mặc định (tuần)
                    renderChart('week');
                    // (Tuỳ chọn) Nếu backend truyền dữ liệu thực tế, bạn có thể ghi đè chartData bằng JSON.parse từ request attribute
                    // Ví dụ: var serverChartData = ${chartDataJson};
                </script>-->
        <script>
            // Dữ liệu thống kê từ backend (thực tế)
            const chartData = ${chartDataJson != null ? chartDataJson : '{week:{labels:["Thứ 2","Thứ 3","Thứ 4","Thứ 5","Thứ 6","Thứ 7","CN"],data:[0,0,0,0,0,0,0]}, month:{labels:["Tuần 1","Tuần 2","Tuần 3","Tuần 4"],data:[0,0,0,0]}, year:{labels:["T1","T2","T3","T4","T5","T6","T7","T8","T9","T10","T11","T12"],data:[0,0,0,0,0,0,0,0,0,0,0,0]}}'};
            let myChart;
            const ctx = document.getElementById('orderChart').getContext('2d');
            function renderChart(range) {
                const data = chartData[range];
                if (!data)
                    return;
                if (myChart)
                    myChart.destroy();
                myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data.labels,
                        datasets: [{
                                label: 'Số đơn hàng',
                                data: data.data,
                                backgroundColor: 'rgba(255, 102, 0, 0.6)',
                                borderColor: '#ff6600',
                                borderWidth: 1,
                                borderRadius: 5
                            }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {display: true, text: 'Số đơn hàng'}
                            },
                            x: {
                                title: {display: true, text: range === 'week' ? 'Ngày trong tuần' : (range === 'month' ? 'Tuần' : 'Tháng')}
                            }
                        }
                    }
                });
            }

            // Sự kiện cho nút chuyển biểu đồ
            document.querySelectorAll('.chart-buttons button').forEach(btn => {
                btn.addEventListener('click', function () {
                    document.querySelectorAll('.chart-buttons button').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    const range = this.getAttribute('data-range');
                    renderChart(range);
                });
            });
            // Khởi tạo biểu đồ mặc định (tuần)
            renderChart('week');
        </script>
    </body>
</html>