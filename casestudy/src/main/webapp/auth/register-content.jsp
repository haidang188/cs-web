<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="login-bg"></div>

<header class="auth-header">
    <a href="${pageContext.request.contextPath}/products" class="brand-link">
        <span class="brand-badge">DT</span>
        <span class="brand-name">PhoneStore</span>
    </a>

    <nav class="auth-nav">
        <a href="${pageContext.request.contextPath}/products">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </nav>
</header>

<main class="auth-main auth-main-register">

    <!-- LEFT -->
    <section class="auth-panel info-panel">
        <p class="mini-title">Tài khoản mới</p>

        <h1>
            Tạo tài khoản để đặt hàng và theo dõi đơn hàng nhanh hơn
        </h1>

        <ul class="benefit-list">
            <li>Giỏ hàng lưu tạm trong phiên đăng nhập.</li>
            <li>Đăng ký 1 lần, mua sắm và xem đơn hàng nhiều lần.</li>
            <li>Giao dien dong bo voi trang san pham va admin.</li>
        </ul>

        <div class="chip-row">
            <span>Nhanh</span>
            <span>An toàn</span>
            <span>Hỗ trợ mua hàng</span>
        </div>
    </section>

    <!-- RIGHT -->
    <section class="auth-panel form-panel">

        <p class="mini-title">Bắt đầu ngay</p>
        <h2>Đăng ký tài khoản</h2>

        <!-- ERROR -->
        <c:if test="${not empty errorMessage}">
            <p class="error-box">${errorMessage}</p>
        </c:if>

        <form class="login-form"
              action="${pageContext.request.contextPath}/register"
              method="post">

            <!-- NAME -->
            <div class="field">
                <label>Họ tên</label>
                <input type="text"
                       name="fullName"
                       value="${enteredFullName}"
                       placeholder="Nhập họ tên"
                       required />
            </div>

            <!-- EMAIL -->
            <div class="field">
                <label>Email</label>
                <input type="email"
                       name="email"
                       value="${enteredEmail}"
                       placeholder="Nhập email"
                       required />
            </div>

            <!-- PHONE -->
            <div class="field">
                <label>Số điện thoại</label>
                <input type="text"
                       name="phone"
                       value="${enteredPhone}"
                       placeholder="Nhập số điện thoại" />
            </div>

            <!-- PASSWORD -->
            <div class="field">
                <label>Mật khẩu</label>
                <input type="password"
                       name="password"
                       placeholder="Nhập mật khẩu"
                       required />
            </div>

            <!-- CONFIRM -->
            <div class="field">
                <label>Xác nhận mật khẩu</label>
                <input type="password"
                       name="confirmPassword"
                       placeholder="Nhập lại mật khẩu "
                       required />
            </div>

            <button class="submit-btn" type="submit">
                Tạo tài khoản
            </button>

        </form>

        <p class="signup-text">
            Đã có tài khoản ?
            <a href="${pageContext.request.contextPath}/login">
                Đăng nhập ngay
            </a>
        </p>

    </section>

</main>


