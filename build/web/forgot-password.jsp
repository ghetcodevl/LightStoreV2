<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Quên mật khẩu - DecorLamp</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f0;
            color: var(--text-dark);
            margin: 0;
            padding: 0;
        }
        
        /* Main Menu Fixed */
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
            min-height: 500px;
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        /* Forgot Password Form */
        .forgot-container {
            max-width: 500px;
            width: 100%;
            margin: 40px auto;
            padding: 35px;
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
            border: 1px solid var(--border-color);
        }
        
        .forgot-container h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 10px;
            font-size: 28px;
            font-weight: 700;
        }
        
        .forgot-container .subtitle {
            text-align: center;
            color: var(--text-gray);
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(192,57,43,0.1);
        }
        
        .btn-submit {
            width: 100%;
            background: var(--primary-color);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s;
        }
        
        .btn-submit:hover {
            background: var(--primary-dark);
        }
        
        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
        }
        
        .message-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .reset-link-box {
            background: var(--bg-gray);
            padding: 18px;
            border-radius: 12px;
            margin-top: 20px;
            border-left: 4px solid var(--primary-color);
            word-break: break-all;
        }
        
        .reset-link-box p {
            margin: 0 0 10px 0;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .reset-link-box a {
            color: #007bff;
            text-decoration: none;
            font-size: 12px;
        }
        
        .reset-link-box a:hover {
            text-decoration: underline;
        }
        
        .reset-link-box .note {
            margin-top: 10px;
            font-size: 12px;
            color: var(--text-gray);
        }
        
        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        
        .back-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
        
        /* Footer */
        .footer {
            background: var(--text-dark);
            color: var(--text-gray);
            padding: 40px 30px 20px;
            margin-top: 30px;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #333;
            font-size: 12px;
        }
        
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            .left-menu {
                width: 100%;
            }
            .forgot-container {
                margin: 20px;
                padding: 20px;
            }
            .forgot-container h2 {
                font-size: 22px;
            }
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
            <li><a href="${pageContext.request.contextPath}/LoginServlet">ĐĂNG NHẬP</a></li>
            <li><a href="${pageContext.request.contextPath}/register">ĐĂNG KÝ</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Left Menu -->
<!--        <div class="left-menu">
            <div class="menu-title">DANH MỤC SẢN PHẨM</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
            </ul>
            <div class="menu-title">SẢN PHẨM NỔI BẬT</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/products?tag=new">Hàng mới</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=bestseller">Bán chạy</a></li>
                <li><a href="${pageContext.request.contextPath}/products?tag=sale">Giảm giá</a></li>
            </ul>
        </div>-->

        <!-- Content -->
        <div class="content">
            <div class="forgot-container">
                <h2>🔐 QUÊN MẬT KHẨU?</h2>
                <div class="subtitle">Nhập email đã đăng ký để đặt lại mật khẩu</div>
                
                <c:if test="${not empty message}">
                    <div class="message message-success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="message message-error">${error}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="form-group">
                        <label>📧 Email đăng ký</label>
                        <input type="email" name="email" value="${email}" placeholder="example@email.com" required>
                    </div>
                    <button type="submit" class="btn-submit">📤 Gửi yêu cầu</button>
                </form>
                
                <c:if test="${not empty resetLink}">
                    <div class="reset-link-box">
                        <p>🔗 Link đặt lại mật khẩu</p>
                        <a href="${resetLink}" target="_blank">${resetLink}</a>
                        <div class="note">⏰ Link có hiệu lực trong 15 phút</div>
                    </div>
                </c:if>
                
                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/LoginServlet">← Quay lại trang đăng nhập</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-bottom">
            <p>© 2024 DecorLamp. All rights reserved.</p>
            <p>Nhóm thực hiện: Đặng Minh Quốc, Lại Thế Trường, Lê Anh Tuấn</p>
        </div>
    </footer>
</div>

<jsp:include page="chatbot.jsp" />
</body>
</html>