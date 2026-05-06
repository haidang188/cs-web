<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="admin-page">
    <section class="section-block">
        <div class="container">
            <div class="section-head">
                <p class="section-kicker">Quản lý tài khoản</p>
                <h2>Danh sách người dùng</h2>
            </div>

            <c:if test="${empty users}">
                <p class="catalog-empty">Chưa có người dùng nào.</p>
            </c:if>

            <c:if test="${not empty users}">
                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                        <tr>
                            <th>Email</th>
                            <th>Họ tên</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.email}</td>
                                <td>${user.displayName}</td>
                                <td>${empty user.phone ? '-' : user.phone}</td>
                                <td>${user.role}</td>
                                <td>${user.status}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </section>
</main>
