<%@ page contentType="text/html;charset=UTF-8" %>

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

  <title>${product.name}</title>

  <!-- BOOTSTRAP -->

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css">

  <!-- STYLE -->

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/style.css">

</head>

<body>

<!-- HEADER -->

<jsp:include page="/views/common/header.jsp"/>

<main class="detail-page">

  <section class="section-block">

    <div class="container">

      <!-- NOT FOUND -->

      <c:if test="${product == null}">

        <div class="catalog-empty-box">

          <h3>
            Không tìm thấy sản phẩm
          </h3>

        </div>

      </c:if>

      <!-- DETAIL -->

      <c:if test="${product != null}">

        <div class="detail-layout">

          <!-- IMAGE -->

          <div class="detail-media">

            <c:choose>

              <c:when test="${not empty product.thumbnail}">

                <img class="detail-image"
                     src="${product.thumbnail}"
                     alt="${product.name}" />

              </c:when>

              <c:otherwise>

                <img class="detail-image"
                     src="${pageContext.request.contextPath}/assets/images/no-image.png"
                     alt="No image" />

              </c:otherwise>

            </c:choose>

          </div>

          <!-- INFO -->

          <div class="detail-info">

            <p class="section-kicker">

              Chi tiết sản phẩm

            </p>

            <h1>

                ${product.name}

            </h1>

            <!-- BRAND -->

            <p class="detail-brand">

              Thương hiệu:

              <strong>

                  ${product.brand.name}

              </strong>

            </p>

            <!-- CATEGORY -->

            <p class="detail-brand">

              Danh mục:

              <strong>

                  ${product.category.name}

              </strong>

            </p>

            <!-- MODEL -->

            <p class="detail-model">

              Model:
                ${product.model}

            </p>

            <!-- DESCRIPTION -->

            <p class="detail-desc">

                ${product.description}

            </p>

            <!-- PRICE -->

            <div class="detail-price">

              <c:choose>

                <c:when test="${product.minPrice != null}">

                  <fmt:formatNumber
                          value="${product.minPrice}"
                          type="number" />

                  đ

                </c:when>

                <c:otherwise>

                  Liên hệ

                </c:otherwise>

              </c:choose>

            </div>

            <!-- STATUS -->

            <div class="mt-3">

              <c:choose>

                <c:when test="${product.status}">

                                    <span class="badge bg-success">

                                        Còn hàng

                                    </span>

                </c:when>

                <c:otherwise>

                                    <span class="badge bg-danger">

                                        Hết hàng

                                    </span>

                </c:otherwise>

              </c:choose>

            </div>

            <!-- ACTION -->

            <div class="detail-actions">

              <!-- ADD TO CART -->

              <form action="${pageContext.request.contextPath}/cart"
                    method="post"
                    class="inline-form">

                <input type="hidden"
                       name="action"
                       value="add" />

                <input type="hidden"
                       name="productId"
                       value="${product.id}" />

                <button class="btn btn-primary"
                        type="submit">

                  Thêm vào giỏ

                </button>

              </form>

              <!-- CART -->

              <a class="btn btn-outline-dark"
                 href="${pageContext.request.contextPath}/cart">

                Xem giỏ hàng

              </a>

              <!-- BACK -->

              <a class="btn btn-dark"
                 href="${pageContext.request.contextPath}/products">

                Quay lại

              </a>

            </div>

          </div>

        </div>

      </c:if>

    </div>

  </section>

</main>

<!-- FOOTER -->

<jsp:include page="/views/common/footer.jsp"/>

<script src="${pageContext.request.contextPath}/jquery/jquery-3.5.1.min.js"></script>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.js"></script>

</body>
</html>