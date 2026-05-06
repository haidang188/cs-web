<%@ page import="haidang.casestudy.model.user_model.User" %><%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 5/6/2026
  Time: 12:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String contextPath = request.getContextPath();
  User currentUser = (User) request.getAttribute("currentUser");
%>

<header class="site-header">
  <div class="container nav-wrap">
    <a href="<%= contextPath %>/home" class="logo">
      <span class="logo-mark">DT</span>
      <span class="logo-text">PhoneStore</span>
    </a>

    <nav class="top-nav">
      <a href="#san-pham">Sản phẩm</a>
      <a href="#danh-muc">Danh mục</a>
      <a href="#thuong-hieu">Thương hiệu</a>
      <a href="#danh-gia">Đánh giá</a>
      <a href="#lien-he">Liên hệ</a>
      <a href="<%= contextPath %>/products">Tất cả sản phẩm</a>

      <% if (currentUser == null) { %>
      <a href="<%= contextPath %>/login">Đăng nhập</a>
      <% } else { %>
      <a href="<%= contextPath %>/cart">Giỏ hàng</a>
      <a href="<%= contextPath %>/orders">Đơn hàng</a>

      <% if ("ADMIN".equalsIgnoreCase(currentUser.getRole())) { %>
      <a href="<%= contextPath %>/admin">Admin</a>
      <% } %>

      <span class="nav-user-chip">Xin chao, <%= currentUser.getFullName() %></span>
      <a href="<%= contextPath %>/logout">Đăng xuất</a>
      <% } %>
    </nav>
  </div>
</header>
