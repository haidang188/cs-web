<%@ page import="haidang.casestudy.model.user_model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
    User currentUser = (User) request.getSession().getAttribute("loggedInUser");
%>

<header class="cps-header-wrap">
    <div class="cps-top-strip">
        <div class="container cps-top-inner">
            <span>Hệ thống bán lẻ điện thoại và phụ kiện</span>
            <span>Hotline: 0909 000 111</span>
        </div>
    </div>

    <div class="container cps-main-inner">
        <a href="<%= contextPath %>/products" class="cps-brand">
            <span class="cps-brand-mark">DT</span>
            <span class="cps-brand-text">PhoneStore</span>
        </a>

        <a href="<%= contextPath %>/products" class="cps-pill-btn">Danh mục</a>

        <div class="cps-actions">
            <a href="<%= contextPath %>/products">Sản phẩm</a>
            <a href="<%= contextPath %>/cart">Giỏ hàng</a>

            <% if (currentUser == null) { %>
            <a href="<%= contextPath %>/login">Đăng nhập</a>
            <% } else { %>
            <% if ("ADMIN".equalsIgnoreCase(currentUser.getRole())) { %>
            <a href="<%= contextPath %>/admin/products">Admin</a>
            <% } %>
            <span class="nav-user-chip">Xin chào, <%= currentUser.getFullName() %></span>
            <a href="<%= contextPath %>/logout">Đăng xuất</a>
            <% } %>
        </div>
    </div>
</header>

