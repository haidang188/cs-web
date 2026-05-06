<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Đăng nhập</title>

  <!-- GOOGLE FONT -->

  <link rel="preconnect"
        href="https://fonts.googleapis.com">

  <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&
family=Space+Grotesk:wght@500;700&display=swap"
        rel="stylesheet">

  <!-- LOGIN CSS -->

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/login.css">

</head>

<body>

<!-- BACKGROUND -->

<div class="login-bg"></div>

<!-- HEADER -->

<header class="auth-header">

  <!-- LOGO -->

  <a href="${pageContext.request.contextPath}/home"
     class="brand-link">

        <span class="brand-badge">

            DT

        </span>

    <span class="brand-name">

            PhoneStore

        </span>

  </a>

  <!-- NAVIGATION -->

  <nav class="auth-nav">

    <a href="${pageContext.request.contextPath}/home">

      Trang chủ

    </a>

    <a href="${pageContext.request.contextPath}/products">

      Sản phẩm

    </a>

    <a href="${pageContext.request.contextPath}/register">

      Đăng ký

    </a>

  </nav>

</header>

<!-- MAIN -->

<main class="auth-main">

  <!-- LEFT PANEL -->

  <section class="auth-panel info-panel">

    <p class="mini-title">

      Thành viên DT PhoneStore

    </p>

    <h1>

      Đăng nhập để theo dõi đơn hàng
      và mua sắm nhanh hơn

    </h1>

    <ul class="benefit-list">

      <li>
        Lưu lịch sử mua sắm và bảo hành điện tử.
      </li>

      <li>
        Nhận mã giảm giá theo cấp độ thành viên.
      </li>

      <li>
        Theo dõi giao hàng thời gian thực.
      </li>

    </ul>

    <div class="chip-row">

      <span>Bảo mật 2 lớp</span>

      <span>Hỗ trợ 24/7</span>

      <span>Đăng nhập 1 chạm</span>

    </div>

  </section>

  <!-- RIGHT PANEL -->

  <section class="auth-panel form-panel">

    <p class="mini-title">

      Xin chào bạn trở lại

    </p>

    <h2>

      Đăng nhập tài khoản

    </h2>

    <!-- ERROR MESSAGE -->

    <c:if test="${not empty errorMessage}">

      <div class="error-box">

          ${errorMessage}

      </div>

    </c:if>

    <!-- LOGIN FORM -->

    <form class="login-form"
          action="${pageContext.request.contextPath}/login"
          method="post">

      <!-- EMAIL -->

      <div class="field">

        <label>

          Email

        </label>

        <input type="email"
               name="email"
               value="${enteredEmail}"
               placeholder="Nhập email của bạn"
               autocomplete="email"
               required />

      </div>

      <!-- PASSWORD -->

      <div class="field">

        <label>

          Mật khẩu

        </label>

        <input type="password"
               name="password"
               placeholder="Nhập mật khẩu"
               autocomplete="current-password"
               minlength="6"
               required />

      </div>

      <!-- TOOLS -->

      <div class="form-tools">

        <label class="remember-check">

          <input type="checkbox"
                 name="remember">

          <span>

                        Ghi nhớ đăng nhập

                    </span>

        </label>

        <a href="#">

          Quên mật khẩu?

        </a>

      </div>

      <!-- BUTTON -->

      <button class="submit-btn"
              type="submit">

        Đăng nhập

      </button>

    </form>

    <!-- DIVIDER -->

    <div class="divider">

            <span>

                Hoặc đăng nhập nhanh hơn

            </span>

    </div>

    <!-- SOCIAL LOGIN -->

    <div class="social-row">

      <button type="button"
              class="social-btn">

        Google

      </button>

      <button type="button"
              class="social-btn">

        Facebook

      </button>

    </div>

    <!-- REGISTER -->

    <p class="signup-text">

      Chưa có tài khoản?

      <a href="${pageContext.request.contextPath}/register">

        Đăng ký ngay

      </a>

    </p>

  </section>

</main>

</body>
</html>