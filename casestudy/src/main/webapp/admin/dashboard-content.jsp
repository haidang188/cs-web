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

<main class="admin-page">
    <section class="section-block">
        <div class="container">

            <div class="section-head">
                <p class="section-kicker">Quản trị hệ thống</p>
                <h2>Admin có quyên quản lý sản phẩm</h2>
            </div>

            <div class="admin-grid">

                <a class="admin-card"
                   href="${pageContext.request.contextPath}/admin/products">
                    <h3>Quản lý sản phẩm</h3>
                    <p>Xem, thêm, sửa và xóa sản phẩm</p>
                </a>

                     <a class="admin-card"
                         href="${pageContext.request.contextPath}/admin/users">
                          <h3>Quản lý người dùng</h3>
                          <p>Xem danh sách tài khoản trong hệ thống</p>
                     </a>

                     <a class="admin-card"
                         href="${pageContext.request.contextPath}/admin/orders">
                          <h3>Quản lý đơn hàng</h3>
                          <p>Xem toàn bộ đơn và cập nhật trạng thái xử lý</p>
                     </a>

                <a class="admin-card"
                   href="${pageContext.request.contextPath}/products">
                    <h3>Về trang người dùng</h3>
                    <p>Chuyển sang giao diện cho khách hàng</p>
                </a>

            </div>

        </div>
    </section>
</main>


