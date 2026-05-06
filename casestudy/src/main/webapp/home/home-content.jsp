<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main>
  <!-- HERO -->
  <section class="hero">
    <div class="container hero-grid">
      <div class="hero-content">
        <p class="badge">Mua sắm thong minh 2026</p>
        <h1>Nâng cấp điện thoại đẹp, mạnh, đúng gu của bạn</h1>

        <p class="hero-text">
          Chọn ngay các dòng smartphone mới nhất với hỗ trợ trả góp 0%,
          bảo hành chính hãng và giao nhanh trong nội thành trong 2 giờ.
        </p>

        <form class="search-bar" action="${pageContext.request.contextPath}/products" method="get">
          <input name="keyword" type="text" placeholder="Tim iPhone, Samsung, Xiaomi..." />
          <button type="submit">Tim ngay</button>
        </form>

        <div class="hero-actions">
          <a href="#san-pham" class="btn btn-primary">Mua ngay</a>
          <a href="${pageContext.request.contextPath}/products" class="btn btn-ghost">Xem sản phẩm</a>
        </div>

        <ul class="hero-stats">
          <li><strong>12K+</strong><span>Khách hàng hài lòng</span></li>
          <li><strong>500+</strong><span>May ban moi thang</span></li>
          <li><strong>99%</strong><span>Đánh giá 5 sao</span></li>
        </ul>
      </div>

      <div class="hero-card">
        <div class="phone-shape">
          <div class="camera"></div>
          <div class="screen-glow"></div>
        </div>
        <div class="price-tag">
          <span>Từ</span>
          <strong>7.990.000d</strong>
        </div>
        <div class="floating-chip chip-left">Freeship 2h</div>
        <div class="floating-chip chip-right">Trả góp 0%</div>
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
        <p class="section-kicker">Sản phẩm bán chạy</p>
        <h2>Top smartphone được mua nhiều nhất</h2>
      </div>

      <div class="filter-row">
        <a class="filter-btn" href="${pageContext.request.contextPath}/products">Tất cả</a>
        <a class="filter-btn" href="${pageContext.request.contextPath}/products?brand=apple">Apple</a>
        <a class="filter-btn" href="${pageContext.request.contextPath}/products?brand=samsung">Samsung</a>
        <a class="filter-btn" href="${pageContext.request.contextPath}/products?brand=xiaomi">Xiaomi</a>
        <a class="filter-btn" href="${pageContext.request.contextPath}/products?brand=oppo">OPPO</a>
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

  <!-- ACCESSORY -->
  <section class="accessory section-block">
    <div class="container">
      <div class="section-head">
        <p class="section-kicker">Combo phụ kiện</p>
        <h2>Bán chạy trong tuần</h2>
      </div>

      <div class="accessory-grid">
        <article class="accessory-card">
          <h3>Tai nghe TWS</h3>
          <p>Tự động kết nối, chống ồn chủ động, pin 28 gio.</p>
          <strong>1.290.000d</strong>
        </article>
        <article class="accessory-card">
          <h3>Củ sạc GaN 65W</h3>
          <p>Sạc nhanh đa thiết bị, gọn nhẹ, an toàn nhiệt độ.</p>
          <strong>690.000d</strong>
        </article>
        <article class="accessory-card">
          <h3>Pin dự phòng 20.000mAh</h3>
          <p>PD 22.5W, màn hình LED, sạc nhanh 2 chiều.</p>
          <strong>790.000d</strong>
        </article>
      </div>
    </div>
  </section>

  <!-- REVIEWS -->
  <section id="danh-gia" class="reviews section-block">
    <div class="container">
      <div class="section-head">
        <p class="section-kicker">Đánh giá khách hàng</p>
        <h2>Phản hồi thực tế sau khi mua</h2>
      </div>

      <div class="review-grid">
        <blockquote class="review-card">
          <p>"Đặt hàng buổi sáng, 2 tiếng sau có máy."</p>
          <cite>- Minh Quân</cite>
        </blockquote>
      </div>
    </div>
  </section>

  <!-- NEWS -->
  <section class="news section-block">
    <div class="container">
      <div class="section-head">
        <p class="section-kicker">Tin công nghệ</p>
        <h2>Cập nhật xu hướng smartphone mới</h2>
      </div>
    </div>
  </section>

</main>


