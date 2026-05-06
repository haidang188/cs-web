<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<main class="catalog-page">
  <section class="section-block">
    <div class="container">

      <div class="section-head">
        <p class="section-kicker">Danh sách sản phẩm</p>
        <h2>Tìm smartphone phù họp với nhu cầu</h2>
      </div>

      <!-- FORM -->
      <form class="catalog-form"
            action="${pageContext.request.contextPath}/products"
            method="get">

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="Tìm theo tên hoặc mô tả..." />

        <select name="brandId">
          <option value="">Tất cả hãng</option>
          <c:forEach var="brand" items="${brands}">
            <option value="${brand.id}" ${brandId == brand.id ? 'selected' : ''}>${brand.name}</option>
          </c:forEach>
        </select>

        <select name="categoryId">
          <option value="">Tất cả danh mục</option>
          <c:forEach var="category" items="${categories}">
            <option value="${category.id}" ${categoryId == category.id ? 'selected' : ''}>${category.name}</option>
          </c:forEach>
        </select>

        <button type="submit">Lọc</button>
      </form>

      <!-- EMPTY -->
      <c:if test="${empty products}">
        <p class="catalog-empty">
          Không tìm thấy sản phẩm phù hợp. Thử lại với tài khoản khác.
        </p>
      </c:if>

      <!-- LIST -->
      <c:if test="${not empty products}">
        <div class="product-grid">

          <c:forEach var="product" items="${products}">
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
                  Chi tiết
                </a>
              </div>

              <!-- ADD TO CART -->
              <form action="${pageContext.request.contextPath}/cart"
                    method="post"
                    class="inline-form"
                    style="margin-top: 0.6rem;">

                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="variantId" value="${product.defaultVariantId}" />
                <input type="hidden" name="quantity" value="1" />

                <button type="submit" class="btn-buy" ${product.defaultVariantId == 0 ? 'disabled' : ''}>
                  Thêm vào giỏ
                </button>
              </form>

            </article>
          </c:forEach>

        </div>
      </c:if>

      <c:if test="${totalPages > 1}">
        <div class="pagination">
          <c:if test="${currentPage > 1}">
            <c:url var="prevPageUrl" value="/products">
              <c:param name="keyword" value="${keyword}" />
              <c:param name="brandId" value="${brandId}" />
              <c:param name="categoryId" value="${categoryId}" />
              <c:param name="page" value="${currentPage - 1}" />
            </c:url>

            <a class="pagination-link" href="${prevPageUrl}">
              Trang trước
            </a>
          </c:if>

          <span class="pagination-info">
            Trang ${currentPage} / ${totalPages}
          </span>

          <c:if test="${currentPage < totalPages}">
            <c:url var="nextPageUrl" value="/products">
              <c:param name="keyword" value="${keyword}" />
              <c:param name="brandId" value="${brandId}" />
              <c:param name="categoryId" value="${categoryId}" />
              <c:param name="page" value="${currentPage + 1}" />
            </c:url>

            <a class="pagination-link" href="${nextPageUrl}">
              Trang sau
            </a>
          </c:if>
        </div>
      </c:if>

    </div>
  </section>
</main>


