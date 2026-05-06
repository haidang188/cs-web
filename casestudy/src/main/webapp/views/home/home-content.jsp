<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>

<main>

  <!-- HERO -->
  <section class="hero">

    <div class="container hero-grid">

      <div class="hero-content">

        <p class="badge">
          Mua sắm thông minh 2026
        </p>

        <h1>
          Nâng cấp điện thoại đẹp, mạnh, đúng gu của bạn
        </h1>

        <p class="hero-text">
          Chọn ngay các dòng smartphone mới nhất với hỗ trợ trả góp 0%,
          bảo hành chính hãng và giao nhanh trong 2 giờ.
        </p>

        <!-- SEARCH -->

        <form class="search-bar"
              action="${pageContext.request.contextPath}/products"
              method="get">

          <input name="keyword"
                 type="text"
                 placeholder="Tìm iPhone, Samsung, Xiaomi..." />

          <button type="submit">
            Tìm ngay
          </button>

        </form>

        <!-- ACTION -->

        <div class="hero-actions">

          <a href="#san-pham"
             class="btn btn-primary">

            Mua ngay

          </a>

          <a href="${pageContext.request.contextPath}/products"
             class="btn btn-ghost">

            Xem sản phẩm

          </a>

        </div>

      </div>

      <!-- HERO CARD -->

      <div class="hero-card">

        <div class="phone-shape"></div>

        <div class="price-tag">
          <span>Từ</span>
          <strong>7.990.000đ</strong>
        </div>

      </div>

    </div>

  </section>

  <!-- PRODUCTS -->

  <section id="san-pham"
           class="products section-block">

    <div class="container">

      <div class="section-head">

        <p class="section-kicker">
          Sản phẩm nổi bật
        </p>

        <h2>
          Top smartphone được mua nhiều
        </h2>

      </div>

      <!-- LIST -->

      <div class="product-grid">

        <c:forEach var="product"
                   items="${featuredProducts}">

          <article class="product-card">

            <!-- IMAGE -->

            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">

              <c:choose>

                <c:when test="${not empty product.thumbnail}">

                  <img class="product-thumb"
                       src="${product.thumbnail}"
                       alt="${product.name}" />

                </c:when>

                <c:otherwise>

                  <img class="product-thumb"
                       src="${pageContext.request.contextPath}/assets/images/no-image.png" />

                </c:otherwise>

              </c:choose>

            </a>

            <!-- BRAND -->

            <span class="tag">
                ${product.brand.name}
            </span>

            <!-- NAME -->

            <h3>
                ${product.name}
            </h3>

            <!-- DESCRIPTION -->

            <p>
                ${product.description}
            </p>

            <!-- PRICE -->

            <div class="price-row">

              <strong>

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

              <a class="btn-buy"
                 href="${pageContext.request.contextPath}/product-detail?id=${product.id}">

                Chi tiết

              </a>

            </div>

          </article>

        </c:forEach>

      </div>

      <!-- CTA -->

      <div class="section-cta-wrap">

        <a class="btn btn-ghost"
           href="${pageContext.request.contextPath}/products">

          Xem toàn bộ sản phẩm

        </a>

      </div>

    </div>

  </section>

</main>