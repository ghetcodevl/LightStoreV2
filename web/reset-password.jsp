<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Đặt lại mật khẩu - DecorLamp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/test.css">
    <style>
        .reset-container {
            max-width: 450px;
            margin: 60px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .reset-container h2 {
            text-align: center;
            color: #b8860b;
            margin-bottom: 10px;
        }
        .reset-container .subtitle {
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
        .message-error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #f5c6cb;
        }
        .password-requirements {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="banner">
            <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="DecorLamp Banner">
        </div>

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
            <div class="content">
                <div class="reset-container">
                    <h2>🔐 Đặt lại mật khẩu</h2>
                    <div class="subtitle">Vui lòng nhập mật khẩu mới</div>
                    
                    <c:if test="${not empty error}">
                        <div class="message-error">${error}</div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/reset-password" method="post">
                        <input type="hidden" name="token" value="${token}">
                        <div class="form-group">
                            <label>🔒 Mật khẩu mới:</label>
                            <input type="password" name="password" required minlength="6">
                            <div class="password-requirements">* Mật khẩu phải có ít nhất 6 ký tự</div>
                        </div>
                        <div class="form-group">
                            <label>🔄 Xác nhận mật khẩu:</label>
                            <input type="password" name="confirmPassword" required>
                        </div>
                        <button type="submit" class="btn-submit">Đặt lại mật khẩu</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="footer-bottom">
                <p>© 2024 DecorLamp. All rights reserved.</p>
            </div>
        </div>
    </div>
</body>
</html>