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
                <p class="section-kicker">Lịch sử mua hàng</p>
                <h2>Các đơn hàng đã đặt</h2>
            </div>

            <!-- SUCCESS -->
            <c:if test="${not empty placed}">
                <p class="success-box">
                    Đặt hàng thành công. Đơn hàng đang được xử lý.
                </p>
            </c:if>

            <!-- EMPTY -->
            <c:if test="${empty orders}">
                <p class="catalog-empty">
                    Chưa có đơn hàng nào.
                </p>
            </c:if>

            <!-- LIST -->
            <c:if test="${not empty orders}">
                <div class="order-list">

                    <c:forEach var="order" items="${orders}">
                        <article class="order-card">

                            <div class="order-head">
                                <div>
                                    <h3>Don #${order.id}</h3>
                                    <p>
                                            User #${order.userId} - ${order.phone}
                                    </p>
                                </div>

                                <strong>
                                    <fmt:formatNumber value="${order.total}" type="number" groupingUsed="true"/> đ
                                </strong>
                            </div>

                            <p>Địa chỉ: ${order.address}</p>

                            <p>
                                Trạng thái: ${order.status}
                            </p>

                            <div class="order-items">

                                <c:forEach var="item" items="${order.items}">
                                    <div class="order-item-row">

                                        <span>
                                            ${item.productName} x ${item.quantity}
                                        </span>

                                        <span>
                                            <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> đ
                                        </span>

                                    </div>
                                </c:forEach>

                            </div>

                        </article>
                    </c:forEach>

                </div>
            </c:if>

        </div>
    </section>
</main>

