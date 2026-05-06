<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="admin-page">
    <section class="section-block">
        <div class="container">
            <div class="section-head">
                <p class="section-kicker">Quản lý đơn hàng</p>
                <h2>Cập nhật trạng thái đơn hàng</h2>
            </div>

            <c:if test="${not empty updated}">
                <p class="success-box">Cập nhật trạng thái đơn hàng thành công.</p>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <p class="error-box">${errorMessage}</p>
            </c:if>

            <c:if test="${empty orders}">
                <p class="catalog-empty">Chưa có đơn hàng nào.</p>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Khách hàng</th>
                            <th>Tài khoản</th>
                            <th>Địa chỉ</th>
                            <th>Tổng tiền</th>
                            <th>Thanh toán</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#${order.id}</td>
                                <td>User #${order.userId}<br/>${order.phone}</td>
                                <td>${order.createdAt}</td>
                                <td>${order.address}</td>
                                <td><fmt:formatNumber value="${order.total}" type="number" groupingUsed="true"/> đ</td>
                                <td>COD</td>
                                <td>
                                    <form class="admin-row-actions" method="post" action="${pageContext.request.contextPath}/admin/orders">
                                        <input type="hidden" name="orderId" value="${order.id}"/>
                                        <select name="status">
                                            <c:forEach var="status" items="${allowedStatuses}">
                                                <option value="${status}" ${status == order.status ? 'selected' : ''}>${status}</option>
                                            </c:forEach>
                                        </select>
                                        <button class="btn btn-primary" type="submit">Lưu</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </section>
</main>


