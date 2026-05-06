<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="admin-page">

    <h2>
        <c:choose>
            <c:when test="${editing}">Sua san pham</c:when>
            <c:otherwise>Them san pham moi</c:otherwise>
        </c:choose>
    </h2>

    <!-- ERROR -->
    <c:if test="${not empty errorMessage}">
        <p class="error-box">${errorMessage}</p>
    </c:if>

    <!-- SET ACTION -->
    <c:set var="formAction">
        <c:choose>
            <c:when test="${editing}">/admin/products/edit</c:when>
            <c:otherwise>/admin/products/create</c:otherwise>
        </c:choose>
    </c:set>

    <!-- SET SELECTED BRAND -->
    <c:set var="selectedBrand"
           value="${not empty brand ? brand : product.brand}" />

    <!-- FORM -->
    <form method="post"
          action="${pageContext.request.contextPath}${formAction}">

        <input type="hidden"
               name="id"
               value="${editing ? product.id : 0}" />

        <!-- NAME -->
        <input type="text"
               name="name"
               value="${not empty name ? name : product.name}"
               required />

        <!-- BRAND -->
        <select name="brand">
            <option value="apple" ${selectedBrand == 'apple' ? 'selected' : ''}>Apple</option>
            <option value="samsung" ${selectedBrand == 'samsung' ? 'selected' : ''}>Samsung</option>
            <option value="xiaomi" ${selectedBrand == 'xiaomi' ? 'selected' : ''}>Xiaomi</option>
            <option value="oppo" ${selectedBrand == 'oppo' ? 'selected' : ''}>OPPO</option>
        </select>

        <!-- PRICE -->
        <input type="number"
               name="price"
               value="${not empty price ? price : product.price}"
               required />

        <!-- TAG -->
        <input type="text"
               name="tag"
               value="${not empty tag ? tag : product.tag}"
               required />

        <!-- IMAGE -->
        <input type="url"
               name="imagePath"
               value="${not empty imagePath ? imagePath : product.imagePath}"
               required />

        <!-- DESCRIPTION -->
        <textarea name="description" required>${not empty description ? description : product.description}</textarea>

        <button type="submit">
            <c:choose>
                <c:when test="${editing}">Luu thay doi</c:when>
                <c:otherwise>Tao san pham</c:otherwise>
            </c:choose>
        </button>

    </form>

</main>
