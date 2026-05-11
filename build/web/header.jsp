<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Header chuẩn dùng chung cho tất cả trang (trừ admin) -->
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

<script>
    function confirmLogout(event) {
        event.preventDefault();
        if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
            window.location.href = '${pageContext.request.contextPath}/logout';
        }
    }
</script>