<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="web_dth.demo.model.user_model.UserAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String contextPath = request.getContextPath();
  UserAccount currentUser = (UserAccount) request.getSession().getAttribute("currentUser");
%>

<header class="site-header">
  <div class="container nav-wrap">
    <a href="<%= contextPath %>/admin" class="logo">
      <span class="logo-mark">AD</span>
      <span class="logo-text">Admin Console</span>
    </a>

    <nav class="top-nav">
      <a href="<%= contextPath %>/admin/products">Sản phẩm</a>
      <a href="<%= contextPath %>/admin/users">Người dùng</a>
      <a href="<%= contextPath %>/admin/orders">Đơn hàng</a>
      <a href="<%= contextPath %>/home">Trang khách hàng</a>
      <% if (currentUser != null) { %>
      <span class="nav-user-chip">Xin chao, <%= currentUser.getDisplayName() %></span>
      <% } %>
      <a href="<%= contextPath %>/logout">Đăng xuất</a>
    </nav>
  </div>
</header>
