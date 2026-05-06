<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Giỏ hàng</title>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

<main class="admin-page">

  <section class="section-block">

    <div class="container">

      <!-- HEADER -->

      <div class="section-head">

        <p class="section-kicker">

          Giỏ hàng

        </p>

        <h2>

          Các sản phẩm bạn đang chọn

        </h2>

      </div>

      <!-- CONTINUE SHOPPING -->

      <div class="mb-4">

        <a href="${pageContext.request.contextPath}/products"
           class="btn btn-ghost">

          ← Tiếp tục mua sắm

        </a>

      </div>

      <!-- EMPTY -->

      <c:if test="${empty cartItems}">

        <div class="catalog-empty">

          <h3>

            Giỏ hàng đang trống

          </h3>

          <p>

            Hãy thêm sản phẩm để tiếp tục mua sắm.

          </p>

        </div>

      </c:if>

      <!-- CART LIST -->

      <c:if test="${not empty cartItems}">

        <div class="cart-grid">

          <c:forEach var="item"
                     items="${cartItems}">

            <article class="cart-card">

              <!-- IMAGE -->

              <img class="cart-thumb"
                   src="${item.imagePath}"
                   alt="${item.productName}" />

              <!-- INFO -->

              <div class="cart-info">

                <h3>

                    ${item.productName}

                </h3>

                <p>

                    ${item.brand}

                </p>

                <!-- VARIANT -->

                <p class="cart-variant">

                    ${item.ram}
                  /
                    ${item.storage}

                </p>

                <!-- STOCK -->

                <p class="cart-stock">

                  Còn ${item.stock} sản phẩm

                </p>

                <!-- PRICE -->

                <p class="cart-price">

                  <fmt:formatNumber
                          value="${item.unitPrice}"
                          type="number" />

                  đ

                </p>

                <!-- UPDATE -->

                <form action="${pageContext.request.contextPath}/cart"
                      method="post"
                      class="cart-inline-form">

                  <input type="hidden"
                         name="action"
                         value="update" />

                  <input type="hidden"
                         name="variantId"
                         value="${item.variantId}" />

                  <input type="number"
                         name="quantity"
                         value="${item.quantity}"
                         min="1"
                         class="quantity-input" />

                  <button type="submit"
                          class="btn btn-ghost">

                    Cập nhật

                  </button>

                </form>

                <!-- DELETE -->

                <form action="${pageContext.request.contextPath}/cart"
                      method="post"
                      class="inline-form">

                  <input type="hidden"
                         name="action"
                         value="remove" />

                  <input type="hidden"
                         name="variantId"
                         value="${item.variantId}" />

                  <button type="submit"
                          class="btn btn-danger">

                    Xóa

                  </button>

                </form>

              </div>

              <!-- SUBTOTAL -->

              <strong class="cart-subtotal">

                <fmt:formatNumber
                        value="${item.subtotal}"
                        type="number" />

                đ

              </strong>

            </article>

          </c:forEach>

        </div>

        <!-- CHECKOUT -->

        <div class="checkout-bar">

          <strong>

            Tổng tiền:

            <fmt:formatNumber
                    value="${cartTotal}"
                    type="number" />

            đ

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

</body>
</html>