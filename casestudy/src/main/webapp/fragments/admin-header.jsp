<%@ page import="haidang.casestudy.model.user_model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String contextPath = request.getContextPath();
  User currentUser = (User) request.getSession().getAttribute("loggedInUser");
%>

<header class="site-header">
  <div class="container nav-wrap">
    <a href="<%= contextPath %>/admin/products" class="logo">
      <span class="logo-mark">AD</span>
      <span class="logo-text">Admin Console</span>
    </a>

    <nav class="top-nav">
      <a href="<%= contextPath %>/admin/products">Sản phẩm</a>
      <a href="<%= contextPath %>/admin/orders">Đơn hàng</a>
      <a href="<%= contextPath %>/products">Trang khách hàng</a>
      <% if (currentUser != null) { %>
      <span class="nav-user-chip">Xin chào, <%= currentUser.getFullName() %></span>
      <% } %>
      <a href="<%= contextPath %>/logout">Đăng xuất</a>
    </nav>
  </div>
</header>

