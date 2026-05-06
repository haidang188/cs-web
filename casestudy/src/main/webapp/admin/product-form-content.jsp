<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="admin-page">
    <section class="section-block">
        <div class="container">
            <div class="section-head">
                <p class="section-kicker">Quản lý sản phẩm</p>
                <h2>
                    <c:choose>
                        <c:when test="${editing}">Sửa sản phẩm</c:when>
                        <c:otherwise>Thêm sản phẩm mới</c:otherwise>
                    </c:choose>
                </h2>
            </div>

            <c:if test="${not empty errorMessage}">
                <p class="error-box">${errorMessage}</p>
            </c:if>

            <form class="admin-form"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/products/${editing ? 'edit' : 'create'}">

                <c:if test="${editing}">
                    <input type="hidden" name="id" value="${product.id}" />
                </c:if>

                <label>
                    Tên sản phẩm
                    <input type="text"
                           name="name"
                           value="${product.name}"
                           required />
                </label>

                <label>
                    Model
                    <input type="text"
                           name="model"
                           value="${product.model}"
                           required />
                </label>

                <label>
                    Danh mục
                    <select name="categoryId" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}"
                                    ${editing && product.category.id == category.id ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <label>
                    Thương hiệu
                    <select name="brandId" required>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.id}"
                                    ${editing && product.brand.id == brand.id ? 'selected' : ''}>
                                ${brand.name}
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <label>
                    Mô tả
                    <textarea name="description" rows="5">${product.description}</textarea>
                </label>

                <c:if test="${editing}">
                    <label>
                        Trạng thái
                        <select name="status">
                            <option value="true" ${product.active ? 'selected' : ''}>Đang bán</option>
                            <option value="false" ${not product.active ? 'selected' : ''}>Ẩn</option>
                        </select>
                    </label>
                </c:if>

                <div class="admin-form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${editing}">Lưu thay đổi</c:when>
                            <c:otherwise>Tạo sản phẩm</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/products">Quay lại</a>
                </div>
            </form>
        </div>
    </section>
</main>


