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
        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </nav>
</header>

<main class="auth-main">

    <!-- LEFT -->
    <section class="auth-panel info-panel">
        <p class="mini-title">Thành viên DT PhoneStore</p>

        <h1>
            Đăng nhập để theo dõi đơn hàng và mua sắm nhanh hơn
        </h1>

        <ul class="benefit-list">
            <li>Lưu lịch sử mua sắm và bảo hành điện tử.</li>
            <li>Nhận mã giảm giá theo cấp độ thành viên.</li>
            <li>Theo dõi giao hàng thời gian thực.</li>
        </ul>

        <div class="chip-row">
            <span>Bảo mật 2 lớp</span>
            <span>Hỗ trợ 24/7</span>
            <span>Đăng nhập 1 chạm</span>
        </div>
    </section>

    <!-- RIGHT -->
    <section class="auth-panel form-panel">

        <p class="mini-title">Xin chào bạn trở lại</p>
        <h2>Đăng nhập tài khoản</h2>

        <!-- ERROR -->
        <c:if test="${not empty errorMessage}">
            <p class="error-box">${errorMessage}</p>
        </c:if>

        <form class="login-form"
              action="${pageContext.request.contextPath}/login"
              method="post">

            <!-- USERNAME -->
            <div class="field">
                <label>Email</label>
                <input type="text"
                       name="email"
                       value="${enteredEmail}"
                       placeholder="Nhập email"
                       required />
            </div>

            <!-- PASSWORD -->
            <div class="field">
                <label>Mật khẩu</label>
                <input type="password"
                       name="password"
                       placeholder="Nhap mat khau"
                       required />
            </div>

            <div class="form-tools">
                <label class="remember-check">
                    <input type="checkbox" name="remember" />
                    <span>Ghi nhớ đăng nhập</span>
                </label>
                <a href="#">Quên mật khẩu?</a>
            </div>

            <button class="submit-btn" type="submit">
                Đăng nhập
            </button>
        </form>

        <div class="divider">
            <span>Hoặc đăng nhập nhanh hơn</span>
        </div>

        <div class="social-row">
            <button type="button" class="social-btn">Google</button>
            <button type="button" class="social-btn">Facebook</button>
        </div>

        <p class="signup-text">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/register">
                Đăng ký ngay
            </a>
        </p>

    </section>

</main>


