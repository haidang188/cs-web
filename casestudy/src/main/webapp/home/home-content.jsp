<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main>
  <!-- HERO -->
  <section class="hero">
    <div class="container hero-grid">
      <div class="hero-content">
        <p class="badge">Điện thoại chính hãng</p>
        <h1>Chọn máy phù hợp, xem giá rõ ràng, mua nhanh gọn</h1>

        <p class="hero-text">
          Tập trung vào sản phẩm, giá bán và trải nghiệm mua sắm gọn gàng.
          Tìm nhanh theo hãng, xem chi tiết và thêm vào giỏ trong vài thao tác.
        </p>

        <form class="search-bar" action="${pageContext.request.contextPath}/products" method="get">
          <input name="keyword" type="text" placeholder="Tìm iPhone, Samsung, Xiaomi..." />
          <button type="submit">Tìm</button>
        </form>

        <div class="hero-actions">
          <a href="#san-pham" class="btn btn-primary">Xem sản phẩm</a>
          <a href="${pageContext.request.contextPath}/products" class="btn btn-ghost">Tất cả sản phẩm</a>
        </div>
      </div>

      <div class="hero-card">
        <div class="phone-shape">
          <div class="camera"></div>
          <div class="screen-glow"></div>
        </div>
      </div>
    </div>
  </section>

  <!-- CATEGORIES -->
  <section id="danh-muc" class="categories section-block">
    <div class="container">
      <div class="section-head">
        <p class="section-kicker">Danh mục mua sắm</p>
        <h2>Chọn nhanh theo nhu cầu</h2>
      </div>

      <div class="category-grid">
        <article class="category-card">
          <h3>Flagship</h3>
          <p>Hiệu năng cao, camera đỉnh, màn hình đẹp.</p>
        </article>
        <article class="category-card">
          <h3>Gaming</h3>
          <p>Chip mạnh, tản nhiệt tốt, tân số quét cao.</p>
        </article>
        <article class="category-card">
          <h3>Camera Phone</h3>
          <p>Tối ưu chụp đêm, quay 4K, selfie chất lượng.</p>
        </article>
        <article class="category-card">
          <h3>Pin Trau</h3>
          <p>Pin lớn 5000mAh+, sạc nhanh, dùng cả ngày.</p>
        </article>
      </div>
    </div>
  </section>

  <!-- BRANDS -->
  <section id="thuong-hieu" class="brands section-block">
    <div class="container">

      <div class="brand-list">
        <span>Apple</span>
        <span>Samsung</span>
        <span>Xiaomi</span>
        <span>OPPO</span>
        <span>vivo</span>
        <span>realme</span>
      </div>
    </div>
  </section>

  <!-- PRODUCTS -->
  <section id="san-pham" class="products section-block">
    <div class="container">

      <div class="section-head">
        <p class="section-kicker">Sản phẩm nổi bật</p>
        <h2>Danh sách điện thoại đang có sẵn</h2>
      </div>

      <div class="product-grid">

        <c:forEach var="product" items="${featuredProducts}">
          <article class="product-card" data-brand="${product.brand.name}">

            <img class="product-thumb"
                 src="${product.thumbnailOrDefault}"
                 alt="${product.name}" />

            <span class="tag">${product.brand.name}</span>

            <h3>${product.name}</h3>

            <p>${product.description}</p>

            <div class="price-row">
              <strong>
                <fmt:formatNumber value="${product.minPrice}" type="number"/> đ
              </strong>

              <a class="btn-buy"
                 href="${pageContext.request.contextPath}/products/detail?id=${product.id}">
                Chi tiet
              </a>
            </div>

          </article>
        </c:forEach>

      </div>

      <div class="section-cta-wrap">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/products">
          Xem toàn bộ sản phẩm
        </a>
      </div>

    </div>
  </section>

</main>


