<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Đăng ký</title>

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

    <a href="${pageContext.request.contextPath}/login">

      Đăng nhập

    </a>

  </nav>

</header>

<!-- MAIN -->

<main class="auth-main auth-main-register">

  <!-- LEFT PANEL -->

  <section class="auth-panel info-panel">

    <p class="mini-title">

      Tài khoản mới

    </p>

    <h1>

      Tạo tài khoản để đặt hàng
      và theo dõi đơn hàng nhanh hơn

    </h1>

    <ul class="benefit-list">

      <li>
        Giỏ hàng được lưu trong phiên đăng nhập.
      </li>

      <li>
        Đăng ký một lần, mua sắm nhiều lần.
      </li>

      <li>
        Giao diện đồng bộ với hệ thống sản phẩm và đơn hàng.
      </li>

    </ul>

    <div class="chip-row">

      <span>Nhanh</span>

      <span>An toàn</span>

      <span>Hỗ trợ mua hàng</span>

    </div>

  </section>

  <!-- RIGHT PANEL -->

  <section class="auth-panel form-panel">

    <p class="mini-title">

      Bắt đầu ngay

    </p>

    <h2>

      Đăng ký tài khoản

    </h2>

    <!-- ERROR MESSAGE -->

    <c:if test="${not empty errorMessage}">

      <div class="error-box">

          ${errorMessage}

      </div>

    </c:if>

    <!-- REGISTER FORM -->

    <form class="login-form"
          action="${pageContext.request.contextPath}/register"
          method="post">

      <!-- FULL NAME -->

      <div class="field">

        <label>

          Họ và tên

        </label>

        <input type="text"
               name="fullName"
               value="${enteredFullName}"
               placeholder="Nhập họ và tên"
               minlength="3"
               maxlength="100"
               autocomplete="name"
               required />

      </div>

      <!-- EMAIL -->

      <div class="field">

        <label>

          Email

        </label>

        <input type="email"
               name="email"
               value="${enteredEmail}"
               placeholder="Nhập email"
               autocomplete="email"
               required />

      </div>

      <!-- PHONE -->

      <div class="field">

        <label>

          Số điện thoại

        </label>

        <input type="tel"
               name="phone"
               value="${enteredPhone}"
               placeholder="Nhập số điện thoại"
               pattern="[0-9]{10,11}"
               autocomplete="tel"
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
               minlength="6"
               autocomplete="new-password"
               required />

      </div>

      <!-- CONFIRM PASSWORD -->

      <div class="field">

        <label>

          Xác nhận mật khẩu

        </label>

        <input type="password"
               name="confirmPassword"
               placeholder="Nhập lại mật khẩu"
               minlength="6"
               autocomplete="new-password"
               required />

      </div>

      <!-- BUTTON -->

      <button class="submit-btn"
              type="submit">

        Tạo tài khoản

      </button>

    </form>

    <!-- LOGIN -->

    <p class="signup-text">

      Đã có tài khoản?

      <a href="${pageContext.request.contextPath}/login">

        Đăng nhập ngay

      </a>

    </p>

  </section>

</main>

</body>
</html>