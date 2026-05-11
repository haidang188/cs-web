<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<main class="detail-page">
  <section class="section-block">
    <div class="container">
      <c:choose>
        <c:when test="${empty product}">
          <p class="catalog-empty">Không tìm thấy thông tin sản phẩm.</p>
        </c:when>
        <c:otherwise>
          <div class="detail-layout">
            <div class="detail-media">
              <c:choose>
                <c:when test="${not empty product.images}">
                  <div class="slider-shell">
                    <button type="button" class="slider-btn slider-btn-prev" aria-label="Ảnh trước">‹</button>

                    <div class="slider-viewport" id="productImageViewport">
                      <div class="slider-track" id="productImageTrack">
                        <c:forEach var="image" items="${product.images}" varStatus="status">
                          <c:if test="${status.index < 3}">
                            <div class="slider-slide">
                              <img class="detail-image"
                                   src="${image.imageUrl}"
                                   alt="${product.name}" />
                            </div>
                          </c:if>
                        </c:forEach>
                      </div>
                    </div>

                    <button type="button" class="slider-btn slider-btn-next" aria-label="Ảnh sau">›</button>
                  </div>
                </c:when>
                <c:otherwise>
                  <img class="detail-image"
                       src="${product.thumbnailOrDefault}"
                       alt="${product.name}" />
                </c:otherwise>
              </c:choose>
            </div>

            <div class="detail-info">
              <p class="section-kicker">${product.brand.name}</p>
              <h1>${product.name}</h1>

              <p class="detail-brand">
                Model: <strong>${product.model}</strong>
                <br/>
                Danh mục: <strong>${product.category.name}</strong>
              </p>

              <p class="detail-desc">${product.description}</p>

              <p class="detail-price">
                Từ <fmt:formatNumber value="${product.minPrice}" type="number"/> đ
              </p>

              <form action="${pageContext.request.contextPath}/cart"
                    method="post"
                    class="admin-form">
                <input type="hidden" name="action" value="add" />

                <label>
                  Phiên bản
                  <select name="variantId" required>
                    <c:forEach var="variant" items="${product.variants}" varStatus="status">
                      <option value="${variant.id}"
                              ${status.first ? 'selected' : ''}
                              ${variant.stock <= 0 ? 'disabled' : ''}>
                        RAM ${variant.ram} - ${variant.storage}
                        -
                        <fmt:formatNumber value="${variant.price}" type="number"/> đ
                        (${variant.stock} còn)
                      </option>
                    </c:forEach>
                  </select>
                </label>

                <label>
                  Số lượng
                  <input type="number" name="quantity" value="1" min="1" required />
                </label>

                <div class="detail-actions">
                  <button class="btn btn-primary" type="submit" ${empty product.variants ? 'disabled' : ''}>
                    Thêm vào giỏ
                  </button>
                  <a class="btn btn-ghost" href="${pageContext.request.contextPath}/cart">Xem giỏ hàng</a>
                  <a class="btn btn-ghost" href="${pageContext.request.contextPath}/products">Quay lại</a>
                </div>
              </form>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </section>
</main>

<script>
  (function () {
    const viewport = document.getElementById('productImageViewport');
    const track = document.getElementById('productImageTrack');

    if (!viewport || !track) {
      return;
    }

    const slides = track.querySelectorAll('.slider-slide');
    if (slides.length <= 1) {
      return;
    }

    const prevButton = document.querySelector('.slider-btn-prev');
    const nextButton = document.querySelector('.slider-btn-next');

    function scrollToIndex(index) {
      const normalizedIndex = (index + slides.length) % slides.length;
      const slideWidth = viewport.clientWidth;

      viewport.scrollTo({
        left: slideWidth * normalizedIndex,
        behavior: 'smooth'
      });
    }

    let currentIndex = 0;

    prevButton.addEventListener('click', function () {
      currentIndex = (currentIndex - 1 + slides.length) % slides.length;
      scrollToIndex(currentIndex);
    });

    nextButton.addEventListener('click', function () {
      currentIndex = (currentIndex + 1) % slides.length;
      scrollToIndex(currentIndex);
    });
  })();
</script>


