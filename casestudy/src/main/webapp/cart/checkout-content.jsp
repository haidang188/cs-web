<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<main class="admin-page">
    <section class="section-block">
        <div class="container checkout-layout">

            <!-- LEFT: FORM -->
            <div>

                <div class="section-head">
                    <p class="section-kicker">Thanh toán</p>
                    <h2>Xác nhận thông tin đơn hàng</h2>
                </div>

                <form class="admin-form"
                      action="${pageContext.request.contextPath}/checkout"
                      method="post">

                    <label>
                        Số điện thoại
                        <input type="text"
                               name="phone"
                               value="${param.phone}"
                               required />
                    </label>

                    <label>
                        Địa chỉ giao hàng
                        <textarea name="address" rows="4" required>${param.address}</textarea>
                    </label>
                    <button type="submit" class="btn btn-primary">
                        Đặt hàng ngay
                    </button>

                </form>

            </div>

            <!-- RIGHT: SUMMARY -->
            <aside class="summary-panel">

                <h3>Đơn hàng của bạn</h3>

                <c:if test="${empty cartItems}">
                    <p>Giỏ hàng rỗng</p>
                </c:if>

                <c:forEach var="item" items="${cartItems}">
                    <div class="summary-row">
                        <span>${item.variant.product.name} x ${item.quantity}</span>
                        <strong>
                            <fmt:formatNumber value="${item.subtotal}" type="number"/> đ
                        </strong>
                    </div>
                </c:forEach>

                <div class="summary-total">
                    <span>Tổng tiền</span>
                    <strong>
                        <fmt:formatNumber value="${cartTotal}" type="number"/> đ
                    </strong>
                </div>

            </aside>

        </div>
    </section>
</main>


