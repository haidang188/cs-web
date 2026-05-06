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

  <title>Sản phẩm - DT PhoneStore</title>

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

<main class="catalog-page">

  <section class="section-block">

    <div class="container">

      <!-- HEADING -->

      <div class="section-head">

        <p class="section-kicker">

          Danh sách sản phẩm

        </p>

        <h2>

          Tìm smartphone phù hợp với nhu cầu

        </h2>

        <p class="section-desc">

          Khám phá các dòng điện thoại mới nhất
          từ Apple, Samsung, Xiaomi, OPPO...

        </p>

      </div>

      <!-- FILTER -->

      <form class="catalog-form"
            action="${pageContext.request.contextPath}/products"
            method="get">

        <!-- KEYWORD -->

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Tìm theo tên hoặc mô tả..." />

        <!-- BRAND -->

        <select name="brandId">

          <option value="">
            Tất cả thương hiệu
          </option>

          <c:forEach items="${brands}"
                     var="brand">

            <option value="${brand.id}"
              ${param.brandId == brand.id.toString() ? 'selected' : ''}>

                ${brand.name}

            </option>

          </c:forEach>

        </select>

        <!-- CATEGORY -->

        <select name="categoryId">

          <option value="">
            Tất cả danh mục
          </option>

          <c:forEach items="${categories}"
                     var="category">

            <option value="${category.id}"
              ${param.categoryId == category.id.toString() ? 'selected' : ''}>

                ${category.name}

            </option>

          </c:forEach>

        </select>

        <!-- BUTTON -->

        <button type="submit">

          Tìm kiếm

        </button>

      </form>

      <!-- EMPTY -->

      <c:if test="${empty products}">

        <div class="catalog-empty-box">

          <h3>

            Không tìm thấy sản phẩm phù hợp

          </h3>

          <p>

            Hãy thử tìm kiếm bằng từ khóa khác.

          </p>

        </div>

      </c:if>

      <!-- PRODUCT LIST -->

      <c:if test="${not empty products}">

        <div class="product-grid">

          <c:forEach var="product"
                     items="${products}">

            <article class="product-card">

              <!-- IMAGE -->

              <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                 class="product-thumb-wrap">

                <c:choose>

                  <c:when test="${not empty product.thumbnail}">

                    <img class="product-thumb"
                         src="${product.thumbnail}"
                         alt="${product.name}" />

                  </c:when>

                  <c:otherwise>

                    <img class="product-thumb"
                         src="${pageContext.request.contextPath}/assets/images/no-image.png"
                         alt="No image" />

                  </c:otherwise>

                </c:choose>

              </a>

              <!-- BRAND -->

              <div class="product-brand">

                  ${product.brand.name}

              </div>

              <!-- TITLE -->

              <h3 class="product-title">

                  ${product.name}

              </h3>

              <!-- MODEL -->

              <p class="product-model">

                  ${product.model}

              </p>

              <!-- DESCRIPTION -->

              <p class="product-description">

                  ${product.description}

              </p>

              <!-- PRICE -->

              <div class="price-row">

                <strong class="product-price">

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

                </strong>

              </div>

              <!-- ACTION -->

              <div class="product-action-row">

                <!-- DETAIL -->

                <a class="btn-buy"
                   href="${pageContext.request.contextPath}/product-detail?id=${product.id}">

                  Chi tiết

                </a>

                <!-- CART -->

                <form action="${pageContext.request.contextPath}/cart"
                      method="post"
                      class="inline-form">

                  <input type="hidden"
                         name="action"
                         value="add" />

                  <input type="hidden"
                         name="productId"
                         value="${product.id}" />

                  <button type="submit"
                          class="btn-cart">

                    Thêm giỏ

                  </button>

                </form>

              </div>

            </article>

          </c:forEach>

        </div>

      </c:if>

      <!-- PAGINATION -->

      <c:if test="${totalPages > 1}">

        <div class="pagination-wrap">

          <ul class="pagination">

            <!-- PREV -->

            <li class="page-item
                            ${currentPage == 1 ? 'disabled' : ''}">

              <a class="page-link"

                 href="${pageContext.request.contextPath}/products?page=${currentPage - 1}&keyword=${param.keyword}&brandId=${param.brandId}&categoryId=${param.categoryId}">

                Previous

              </a>

            </li>

            <!-- PAGE NUMBER -->

            <c:forEach begin="1"
                       end="${totalPages}"
                       var="page">

              <li class="page-item
                                ${page == currentPage ? 'active' : ''}">

                <a class="page-link"

                   href="${pageContext.request.contextPath}/products?page=${page}&keyword=${param.keyword}&brandId=${param.brandId}&categoryId=${param.categoryId}">

                    ${page}

                </a>

              </li>

            </c:forEach>

            <!-- NEXT -->

            <li class="page-item
                            ${currentPage == totalPages ? 'disabled' : ''}">

              <a class="page-link"

                 href="${pageContext.request.contextPath}/products?page=${currentPage + 1}&keyword=${param.keyword}&brandId=${param.brandId}&categoryId=${param.categoryId}">

                Next

              </a>

            </li>

          </ul>

        </div>

      </c:if>

    </div>

  </section>

</main>

<!-- FOOTER -->

<jsp:include page="/views/common/footer.jsp"/>

<!-- JS -->

<script src="${pageContext.request.contextPath}/jquery/jquery-3.5.1.min.js"></script>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.js"></script>

</body>
</html>