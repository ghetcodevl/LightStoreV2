<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ========== CHATBOT ========== -->
<div class="chatbot-container">
    <div class="chatbot-button" id="chatbotToggle">
        💬 <span>Chat với chúng tôi</span>
    </div>
    <div class="chatbot-window" id="chatbotWindow">
        <div class="chatbot-header">
            <span>🤖 DecorLamp Support</span>
            <button class="chatbot-close" id="chatbotClose">×</button>
        </div>
        <div class="chatbot-messages" id="chatbotMessages">
            <div class="chatbot-message bot">
                <div class="message-bubble">
                    👋 Xin chào! Tôi là trợ lý ảo của DecorLamp.<br>
                    Bạn có thể chọn câu hỏi bên dưới hoặc nhập câu hỏi của riêng bạn nhé!
                </div>
            </div>
        </div>
        
        <!-- Câu hỏi gợi ý -->
        <div class="chatbot-suggestions" id="chatbotSuggestions">
            <button class="suggestion-btn" data-question="🔍 Đèn pha lê dưới 10 triệu">🔍 Đèn pha lê dưới 10tr</button>
            <button class="suggestion-btn" data-question="🔍 Đèn cổ điển">🔍 Đèn cổ điển</button>
            <button class="suggestion-btn" data-question="🔍 Đèn đồng">🔍 Đèn đồng</button>
            <button class="suggestion-btn" data-question="🔍 Đèn thả trần">🔍 Đèn thả trần</button>
            <button class="suggestion-btn" data-question="🔍 Hàng mới về">🔍 Hàng mới về</button>
            <button class="suggestion-btn" data-question="🔍 Sản phẩm bán chạy">🔍 Sản phẩm bán chạy</button>
            <button class="suggestion-btn" data-question="🔍 Đèn đang giảm giá">🔍 Đèn đang giảm giá</button>
            <button class="suggestion-btn" data-question="🔍 Chính sách bảo hành">🔍 Chính sách bảo hành</button>
            <button class="suggestion-btn" data-question="🔍 Giao hàng - Thanh toán">🔍 Giao hàng - Thanh toán</button>
        </div>
        
        <div class="chatbot-input">
            <input type="text" id="chatbotInput" placeholder="Hoặc nhập câu hỏi của bạn..." onkeypress="handleKeyPress(event)">
            <button id="chatbotSend">📤 Gửi</button>
        </div>
    </div>
</div>

<style>
    .chatbot-container {
        position: fixed;
        bottom: 30px;
        right: 30px;
        z-index: 9999;
    }
    .chatbot-button {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #d4a017 0%, #b8860b 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        transition: all 0.3s ease;
        color: white;
        font-size: 24px;
    }
    .chatbot-button span { display: none; font-size: 14px; margin-left: 5px; }
    .chatbot-button:hover { transform: scale(1.05); width: auto; border-radius: 30px; padding: 0 20px; }
    .chatbot-button:hover span { display: inline; }
    .chatbot-window {
        position: absolute;
        bottom: 80px;
        right: 0;
        width: 380px;
        height: 500px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.2);
        display: none;
        flex-direction: column;
        overflow: hidden;
        border: 1px solid #e8d5a8;
    }
    .chatbot-window.active { display: flex; }
    .chatbot-header {
        background: linear-gradient(135deg, #2c2418 0%, #1a1510 100%);
        color: #e8d5a8;
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #b8860b;
    }
    .chatbot-close { background: none; border: none; color: white; font-size: 24px; cursor: pointer; }
    .chatbot-messages { flex: 1; padding: 15px; overflow-y: auto; background: #f9f5ed; }
    .chatbot-message { margin-bottom: 15px; display: flex; }
    .chatbot-message.user { justify-content: flex-end; }
    .chatbot-message.bot { justify-content: flex-start; }
    .message-bubble {
        max-width: 85%;
        padding: 10px 15px;
        border-radius: 18px;
        font-size: 14px;
        line-height: 1.4;
    }
    .chatbot-message.user .message-bubble {
        background: #b8860b;
        color: white;
        border-bottom-right-radius: 5px;
    }
    .chatbot-message.bot .message-bubble {
        background: white;
        color: #333;
        border: 1px solid #e8d5a8;
        border-bottom-left-radius: 5px;
    }
    .chatbot-suggestions {
        padding: 10px;
        background: #f9f5ed;
        border-top: 1px solid #e8d5a8;
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        max-height: 100px;
        overflow-y: auto;
    }
    .suggestion-btn {
        background: white;
        border: 1px solid #b8860b;
        color: #b8860b;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        cursor: pointer;
        transition: all 0.2s;
    }
    .suggestion-btn:hover { background: #b8860b; color: white; }
    .chatbot-input {
        display: flex;
        padding: 10px;
        border-top: 1px solid #e8d5a8;
        background: white;
    }
    .chatbot-input input {
        flex: 1;
        padding: 10px;
        border: 1px solid #e8d5a8;
        border-radius: 25px;
        outline: none;
        font-size: 14px;
    }
    .chatbot-input button {
        margin-left: 8px;
        padding: 8px 15px;
        background: #b8860b;
        color: white;
        border: none;
        border-radius: 25px;
        cursor: pointer;
    }
    .typing-indicator { display: flex; align-items: center; gap: 4px; padding: 10px 15px; }
    .typing-indicator span {
        width: 8px;
        height: 8px;
        background: #b8860b;
        border-radius: 50%;
        animation: typing 1.4s infinite ease-in-out;
    }
    .typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
    .typing-indicator span:nth-child(3) { animation-delay: 0.4s; }
    @keyframes typing {
        0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
        30% { transform: translateY(-10px); opacity: 1; }
    }
    @media (max-width: 480px) {
        .chatbot-window { width: 320px; height: 480px; right: -10px; }
        .suggestion-btn { font-size: 10px; padding: 4px 8px; }
    }
</style>

<script>
    // Dữ liệu sản phẩm từ database (đồng bộ với sản phẩm thực tế)
    var productDatabase = [
        // Đèn Pha Lê (category_id = 1)
        { id: 1, name: "Đèn Chùm Pha Lê Kim Cương", price: 15000000, category: "Đèn Chùm Pha Lê", tag: "new" },
        { id: 2, name: "Đèn Chùm Pha Lê", price: 12500000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 3, name: "Đèn Chùm Trái Tim", price: 8000000, category: "Đèn Chùm Pha Lê", tag: "new" },
        { id: 4, name: "Đèn Chùm Tân Cổ Điển", price: 25000000, category: "Đèn Chùm Pha Lê", tag: "new" },
        { id: 11, name: "Đèn Chùm Pha Lê Hiện Đại CCH-3796", price: 12500000, category: "Đèn Chùm Pha Lê", tag: "new" },
        { id: 15, name: "Đèn Chùm Pha Lê Trắng CCP-9888", price: 14200000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 19, name: "Đèn Chùm Pha Lê Màu Hồng CCP-7777", price: 11800000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 23, name: "Đèn Chùm Pha Lê 15 Đèn CCP-6666", price: 28900000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 58, name: "Đèn Chùm Pha Lê 15 Đèn CCP-6666", price: 28900000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 61, name: "Đèn Chùm Pha Lê Kim Cương 8 Đèn", price: 16800000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        { id: 65, name: "Đèn Chùm Pha Lê Ánh Sáng Vàng", price: 13500000, category: "Đèn Chùm Pha Lê", tag: "bestseller" },
        // Đèn Cổ Điển (category_id = 2)
        { id: 6, name: "Đèn Chùm Bát Đá Tự Nhiên", price: 1200000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 7, name: "Đèn Chùm Đồng Phong Cách Indochi CCD", price: 450000, category: "Đèn Chùm Cổ Điển", tag: "sale" },
        { id: 8, name: "Đèn Chùm Tân Cổ Điển", price: 850000, category: "Đèn Chùm Cổ Điển", tag: "bestseller" },
        { id: 9, name: "Đèn Chùm Phòng Khách", price: 1500000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 12, name: "Đèn Chùm Cổ Điển Pha Lê Vàng", price: 18900000, category: "Đèn Chùm Cổ Điển", tag: "bestseller" },
        { id: 16, name: "Đèn Chùm Cổ Điển 7 Đèn CCL-7766", price: 15600000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 20, name: "Đèn Chùm Cổ Điển Đồng CCL-8899", price: 24500000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 24, name: "Đèn Chùm Cổ Điển 12 Đèn CCL-5555", price: 32500000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 47, name: "Đèn Chùm Cổ Điển Pha Lê Vàng", price: 18900000, category: "Đèn Chùm Cổ Điển", tag: "bestseller" },
        { id: 51, name: "Đèn Chùm Cổ Điển 7 Đèn CCL-7766", price: 15600000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 55, name: "Đèn Chùm Cổ Điển Đồng CCL-8899", price: 24500000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 59, name: "Đèn Chùm Cổ Điển 12 Đèn CCL-5555", price: 32500000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        { id: 62, name: "Đèn Chùm Cổ Điển Hoàng Gia 10 Đèn", price: 27900000, category: "Đèn Chùm Cổ Điển", tag: "new" },
        // Đèn Đồng (category_id = 3)
        { id: 5, name: "Đèn Chùm đồng cao cấp", price: 9500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 10, name: "Đèn Chùm Đồng Châu Âu", price: 2000000, category: "Đèn Chùm Đồng", tag: "new" },
        { id: 13, name: "Đèn Chùm Đồng Nguyên Khối CCD-1888", price: 16500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 17, name: "Đèn Chùm Đồng Indochine CCD-1999", price: 13500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 21, name: "Đèn Chùm Đồng Cao Cấp CCD-1666", price: 9900000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 25, name: "Đèn Chùm Đồng Mạ Vàng CCD-2222", price: 18500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 48, name: "Đèn Chùm Đồng Nguyên Khối CCD-1888", price: 16500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 52, name: "Đèn Chùm Đồng Indochine CCD-1999", price: 13500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 56, name: "Đèn Chùm Đồng Cao Cấp CCD-1666", price: 9900000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 60, name: "Đèn Chùm Đồng Mạ Vàng CCD-2222", price: 18500000, category: "Đèn Chùm Đồng", tag: "sale" },
        { id: 63, name: "Đèn Chùm Đồng Antique CCD-3333", price: 15900000, category: "Đèn Chùm Đồng", tag: "sale" },
        // Đèn Thả Trần (category_id = 4)
        { id: 14, name: "Đèn Thả Trần Phòng Khách CTT-2024", price: 4800000, category: "Đèn Thả Trần", tag: "new" },
        { id: 18, name: "Đèn Thả Trần Công Nghiệp CTT-2025", price: 3900000, category: "Đèn Thả Trần", tag: "new" },
        { id: 22, name: "Đèn Thả Trần Pha Lê CTT-2026", price: 5200000, category: "Đèn Thả Trần", tag: "new" },
        { id: 49, name: "Đèn Thả Trần Phòng Khách CTT-2024", price: 4800000, category: "Đèn Thả Trần", tag: "new" },
        { id: 53, name: "Đèn Thả Trần Công Nghiệp CTT-2025", price: 3900000, category: "Đèn Thả Trần", tag: "new" },
        { id: 57, name: "Đèn Thả Trần Pha Lê CTT-2026", price: 5200000, category: "Đèn Thả Trần", tag: "new" },
        { id: 64, name: "Đèn Thả Trần Văn Phòng CTT-2027", price: 3500000, category: "Đèn Thả Trần", tag: "new" }
    ];

    // Câu trả lời cho từ khóa
    function getProductsByCategory(category) {
        return productDatabase.filter(p => p.category === category);
    }
    
    function getProductsByTag(tag) {
        return productDatabase.filter(p => p.tag === tag);
    }
    
    function getProductsByPriceRange(min, max) {
        return productDatabase.filter(p => p.price >= min && p.price <= max);
    }
    
    function formatProductList(products, title) {
        if (products.length === 0) return "😅 Không tìm thấy sản phẩm nào.";
        var html = title + "<br>";
        for (var i = 0; i < Math.min(products.length, 5); i++) {
            html += "• <strong>" + products[i].name + "</strong> - " + formatPrice(products[i].price) + "<br>";
        }
        if (products.length > 5) {
            html += "<br>📌 Và " + (products.length - 5) + " sản phẩm khác...";
        }
        return html;
    }
    
    function formatPrice(price) {
        return price.toLocaleString('vi-VN') + 'đ';
    }
    
    // Xử lý tin nhắn
    document.addEventListener('DOMContentLoaded', function() {
        var toggle = document.getElementById('chatbotToggle');
        var windowDiv = document.getElementById('chatbotWindow');
        var close = document.getElementById('chatbotClose');
        var send = document.getElementById('chatbotSend');
        var input = document.getElementById('chatbotInput');
        
        if (toggle) toggle.addEventListener('click', function() { windowDiv.classList.toggle('active'); });
        if (close) close.addEventListener('click', function() { windowDiv.classList.remove('active'); });
        if (send) send.addEventListener('click', sendMessage);
        if (input) input.addEventListener('keypress', function(event) { if (event.key === 'Enter') sendMessage(); });
        
        // Xử lý click vào nút gợi ý
        var suggestionBtns = document.querySelectorAll('.suggestion-btn');
        suggestionBtns.forEach(function(btn) {
            btn.addEventListener('click', function() {
                var question = this.getAttribute('data-question');
                document.getElementById('chatbotInput').value = question;
                sendMessage();
            });
        });
    });
    
    function sendMessage() {
        var input = document.getElementById('chatbotInput');
        var message = input.value.trim();
        if (message === '') return;
        
        addMessage(message, 'user');
        input.value = '';
        showTyping();
        
        setTimeout(function() {
            removeTyping();
            var reply = getReply(message);
            addMessage(reply, 'bot');
        }, 500);
    }
    
    function getReply(message) {
        var q = message.toLowerCase();
        
        // Đèn pha lê
        if (q.includes('pha lê') && (q.includes('dưới 10') || q.includes('10tr'))) {
            var products = getProductsByPriceRange(0, 10000000).filter(p => p.category === "Đèn Chùm Pha Lê");
            return formatProductList(products, "💎 Đèn pha lê dưới 10 triệu:");
        }
        if (q.includes('pha lê') || q.includes('pha le')) {
            var products = getProductsByCategory("Đèn Chùm Pha Lê");
            return formatProductList(products, "💎 Các sản phẩm đèn pha lê:");
        }
        
        // Đèn cổ điển
        if (q.includes('cổ điển') || q.includes('co dien')) {
            var products = getProductsByCategory("Đèn Chùm Cổ Điển");
            return formatProductList(products, "🏛️ Các sản phẩm đèn cổ điển:");
        }
        
        // Đèn đồng
        if (q.includes('đồng') || q.includes('dong')) {
            var products = getProductsByCategory("Đèn Chùm Đồng");
            return formatProductList(products, "🪙 Các sản phẩm đèn đồng:");
        }
        
        // Đèn thả trần
        if (q.includes('thả trần') || q.includes('tha tran')) {
            var products = getProductsByCategory("Đèn Thả Trần");
            return formatProductList(products, "💡 Các sản phẩm đèn thả trần:");
        }
        
        // Hàng mới
        if (q.includes('hàng mới') || q.includes('hang moi') || q.includes('mới')) {
            var products = getProductsByTag("new");
            return formatProductList(products, "🆕 Sản phẩm mới về:");
        }
        
        // Bán chạy
        if (q.includes('bán chạy') || q.includes('ban chay') || q.includes('hot')) {
            var products = getProductsByTag("bestseller");
            return formatProductList(products, "⭐ Sản phẩm bán chạy:");
        }
        
        // Giảm giá
        if (q.includes('giảm giá') || q.includes('giam gia') || q.includes('sale')) {
            var products = getProductsByTag("sale");
            return formatProductList(products, "🎯 Sản phẩm đang giảm giá:");
        }
        
        // Bảo hành
        if (q.includes('bảo hành') || q.includes('bao hanh')) {
            return "🔧 <strong>Chính sách bảo hành:</strong><br>• Bảo hành chính hãng <strong>24 tháng</strong><br>• Đổi mới trong <strong>7 ngày</strong> nếu lỗi nhà sản xuất<br>• Bảo trì miễn phí trọn đời tại showroom";
        }
        
        // Giao hàng - Thanh toán
        if (q.includes('giao hàng') || q.includes('van chuyen') || q.includes('thanh toán')) {
            return "🚚 <strong>Giao hàng - Thanh toán:</strong><br>• Giao hàng toàn quốc 2-5 ngày<br>• Phí ship 30.000đ - 80.000đ<br>• Thanh toán khi nhận hàng (COD)<br>• Chuyển khoản ngân hàng<br>• Thẻ tín dụng / Trả góp 0%";
        }
        
        // Chào hỏi
        if (q.includes('chào') || q.includes('hello') || q.includes('hi')) {
            return "👋 Xin chào! Tôi có thể tư vấn đèn trang trí cho bạn. Bạn muốn tìm loại đèn nào?";
        }
        
        // Cảm ơn
        if (q.includes('cảm ơn') || q.includes('cam on')) {
            return "😊 Cảm ơn bạn! Rất vui được hỗ trợ. Chúc bạn một ngày tốt lành!";
        }
        
        // Mặc định
        return "🙏 Cảm ơn bạn đã quan tâm!<br><br>" +
               "📌 Bạn có thể hỏi tôi về:<br>" +
               "• Sản phẩm theo loại (đèn pha lê, cổ điển, đồng, thả trần)<br>" +
               "• Sản phẩm theo nhu cầu (hàng mới, bán chạy, giảm giá)<br>" +
               "• Chính sách bảo hành, giao hàng, thanh toán<br><br>" +
               "📞 Hoặc gọi hotline 0965.69.8866 để được tư vấn trực tiếp!";
    }
    
    function addMessage(text, sender) {
        var messagesDiv = document.getElementById('chatbotMessages');
        var messageDiv = document.createElement('div');
        messageDiv.className = 'chatbot-message ' + sender;
        messageDiv.innerHTML = '<div class="message-bubble">' + text + '</div>';
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
    
    function showTyping() {
        var messagesDiv = document.getElementById('chatbotMessages');
        var typingDiv = document.createElement('div');
        typingDiv.className = 'chatbot-message bot typing';
        typingDiv.id = 'typingIndicator';
        typingDiv.innerHTML = '<div class="typing-indicator"><span></span><span></span><span></span></div>';
        messagesDiv.appendChild(typingDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
    
    function removeTyping() {
        var typing = document.getElementById('typingIndicator');
        if (typing) typing.remove();
    }
</script>