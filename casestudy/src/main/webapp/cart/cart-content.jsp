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
    <div class="container">

      <div class="section-head">
        <p class="section-kicker">Giỏ hàng</p>
        <h2>Các sản phẩm bạn đang chọn</h2>
      </div>

      <!-- EMPTY -->
      <c:if test="${empty cartItems}">
        <p class="catalog-empty">Giỏ hàng đang trống</p>
      </c:if>

      <!-- LIST -->
      <c:if test="${not empty cartItems}">

        <div class="cart-grid">

          <c:forEach var="item" items="${cartItems}">

            <article class="cart-card">

              <img class="cart-thumb"
                   src="${item.variant.product.thumbnailOrDefault}"
                   alt="${item.variant.product.name}" />

              <div class="cart-info">

                <h3>${item.variant.product.name}</h3>
                <p>RAM ${item.variant.ram} - ${item.variant.storage}</p>

                <p>
                  <fmt:formatNumber value="${item.variant.price}" type="number"/> đ
                </p>

                <!-- UPDATE -->
                <form action="${pageContext.request.contextPath}/cart"
                      method="post"
                      class="cart-inline-form">

                  <input type="hidden" name="action" value="update"/>
                  <input type="hidden" name="variantId" value="${item.variant.id}"/>

                  <input type="number"
                         name="quantity"
                         value="${item.quantity}"
                         min="1"/>

                  <button type="submit" class="btn btn-ghost">
                    Cập nhật
                  </button>
                </form>

                <!-- DELETE -->
                <form action="${pageContext.request.contextPath}/cart"
                      method="post"
                      class="inline-form">

                  <input type="hidden" name="action" value="remove"/>
                  <input type="hidden" name="variantId" value="${item.variant.id}"/>

                  <button type="submit" class="btn btn-danger">
                    Xóa
                  </button>
                </form>

              </div>

              <strong class="cart-subtotal">
                <fmt:formatNumber value="${item.subtotal}" type="number"/> đ
              </strong>

            </article>

          </c:forEach>

        </div>

        <!-- TOTAL -->
        <div class="checkout-bar">
          <strong>
            Tổng tiền:
            <fmt:formatNumber value="${cartTotal}" type="number"/> đ
          </strong>

          <a class="btn btn-primary"
             href="${pageContext.request.contextPath}/checkout">
            Tiến hành đặt hàng
          </a>
        </div>

      </c:if>

    </div>
  </section>
</main>


