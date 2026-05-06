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

  <title>Thanh toán</title>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

<main class="admin-page">

  <section class="section-block">

    <div class="container checkout-layout">

      <!-- LEFT -->

      <div>

        <div class="section-head">

          <p class="section-kicker">

            Thanh toán

          </p>

          <h2>

            Xác nhận thông tin đơn hàng

          </h2>

        </div>

        <!-- ERROR -->

        <c:if test="${not empty errorMessage}">

          <div class="error-box">

              ${errorMessage}

          </div>

        </c:if>

        <!-- EMPTY CART -->

        <c:if test="${empty cartItems}">

          <div class="catalog-empty">

            <h3>

              Giỏ hàng đang trống

            </h3>

            <a href="${pageContext.request.contextPath}/products"
               class="btn btn-primary">

              Mua sắm ngay

            </a>

          </div>

        </c:if>

        <!-- FORM -->

        <c:if test="${not empty cartItems}">

          <form class="admin-form"
                action="${pageContext.request.contextPath}/checkout"
                method="post">

            <!-- CUSTOMER -->

            <label>

              Người nhận

              <input type="text"
                     value="${sessionScope.loggedInUser.fullName}"
                     readonly />

            </label>

            <!-- PHONE -->

            <label>

              Số điện thoại

              <input type="tel"
                     name="phone"
                     value="${param.phone}"
                     pattern="[0-9]{10,11}"
                     required />

            </label>

            <!-- ADDRESS -->

            <label>

              Địa chỉ giao hàng

              <textarea name="address"
                        rows="4"
                        required>${param.address}</textarea>

            </label>

            <!-- PAYMENT -->

            <label>

              Phương thức thanh toán

              <select name="paymentMethod">

                <option value="COD">

                  COD

                </option>

                <option value="BANK">

                  Chuyển khoản

                </option>

                <option value="MOMO">

                  Momo

                </option>

              </select>

            </label>

            <!-- ACTION -->

            <div class="checkout-actions">

              <a href="${pageContext.request.contextPath}/cart"
                 class="btn btn-ghost">

                Quay lại giỏ hàng

              </a>

              <button type="submit"
                      class="btn btn-primary">

                Đặt hàng ngay

              </button>

            </div>

          </form>

        </c:if>

      </div>

      <!-- RIGHT -->

      <aside class="summary-panel">

        <h3>

          Đơn hàng của bạn

        </h3>

        <c:forEach var="item"
                   items="${cartItems}">

          <div class="summary-row">

                        <span>

                            ${item.productName}
                            x
                            ${item.quantity}

                        </span>

            <strong>

              <fmt:formatNumber
                      value="${item.subtotal}"
                      type="number" />

              đ

            </strong>

          </div>

        </c:forEach>

        <!-- TOTAL -->

        <div class="summary-total">

                    <span>

                        Tổng tiền

                    </span>

          <strong>

            <fmt:formatNumber
                    value="${cartTotal}"
                    type="number" />

            đ

          </strong>

        </div>

      </aside>

    </div>

  </section>

</main>

</body>
</html>