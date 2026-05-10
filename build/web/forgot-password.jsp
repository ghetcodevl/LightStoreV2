<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Quên mật khẩu - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <style>
        .forgot-container {
            max-width: 500px;
            margin: 60px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .forgot-container h2 {
            text-align: center;
            color: #b8860b;
            margin-bottom: 10px;
        }
        .forgot-container .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #b8860b;
        }
        .btn-submit {
            width: 100%;
            background: #b8860b;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn-submit:hover {
            background: #9a7209;
        }
        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
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
            background: #f9f5ed;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            border-left: 4px solid #b8860b;
            word-break: break-all;
        }
        .reset-link-box p {
            margin: 0 0 10px 0;
            font-weight: bold;
            color: #b8860b;
        }
        .reset-link-box a {
            color: #007bff;
            text-decoration: none;
            font-size: 12px;
        }
        .reset-link-box a:hover {
            text-decoration: underline;
        }
        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .back-link a {
            color: #b8860b;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Banner -->
        <div class="banner">
            <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner" onerror="this.src='https://via.placeholder.com/1200x300?text=DecorLamp'">
        </div>

        <!-- Top Menu -->
        <div class="top-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Home">🏠 Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/products">✨ Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">📞 Liên hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a></li>
                <li class="right-menu"><a href="${pageContext.request.contextPath}/LoginServlet">🔐 Đăng nhập</a></li>
                <li class="right-menu"><a href="${pageContext.request.contextPath}/register">📝 Đăng ký</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="left-menu">
                <div class="menu-title">Danh mục sản phẩm</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/products?category=1">Đèn Chùm Pha Lê</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2">Đèn Chùm Cổ Điển</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3">Đèn Chùm Đồng</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=4">Đèn Thả Trần</a></li>
                </ul>
            </div>

            <div class="content">
                <div class="forgot-container">
                    <h2>🔐 Quên mật khẩu?</h2>
                    <div class="subtitle">Nhập email đã đăng ký để đặt lại mật khẩu</div>
                    
                    <c:if test="${not empty message}">
                        <div class="message message-success">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="message message-error">${error}</div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                        <div class="form-group">
                            <label>📧 Email đăng ký:</label>
                            <input type="email" name="email" value="${email}" placeholder="example@email.com" required>
                        </div>
                        <button type="submit" class="btn-submit">Gửi yêu cầu</button>
                    </form>
                    
                    <c:if test="${not empty resetLink}">
                        <div class="reset-link-box">
                            <p>🔗 Click vào link bên dưới để đặt lại mật khẩu:</p>
                            <a href="${resetLink}" target="_blank">${resetLink}</a>
                            <p style="margin-top: 10px; font-size: 12px; color: #999;">
                                ⏰ Link có hiệu lực trong 15 phút
                            </p>
                        </div>
                    </c:if>
                    
                    <div class="back-link">
                        <a href="${pageContext.request.contextPath}/LoginServlet">← Quay lại trang đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="footer-bottom">
                <p>© 2024 DecorLamp. All rights reserved.</p>
            </div>
        </div>
    </div>
</body>
</html>