<%@ page import="haidang.casestudy.model.user_model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
    User currentUser = (User) request.getSession().getAttribute("loggedInUser");
%>

<header class="site-header">
    <div class="container nav-wrap">
        <a href="<%= contextPath %>/products" class="logo">
            <span class="logo-mark">DT</span>
            <span class="logo-text">PhoneStore</span>
        </a>

        <nav class="top-nav">
            <a href="<%= contextPath %>/products">Sản phẩm</a>
            <a href="<%= contextPath %>/cart">Giỏ hàng</a>

            <% if (currentUser == null) { %>
            <a href="<%= contextPath %>/login">Đăng nhập</a>
            <a href="<%= contextPath %>/register">Đăng ký</a>
            <% } else { %>
            <% if ("ADMIN".equalsIgnoreCase(currentUser.getRole())) { %>
            <a href="<%= contextPath %>/admin/products">Admin</a>
            <% } %>
            <span class="nav-user-chip">Xin chào, <%= currentUser.getFullName() %></span>
            <a href="<%= contextPath %>/logout">Đăng xuất</a>
            <% } %>
        </nav>
    </div>
</header>

