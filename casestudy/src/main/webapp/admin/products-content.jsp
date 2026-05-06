<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="admin-page">

    <h2>Danh sách sản phẩm</h2>

    <a class="btn btn-primary"
       href="${pageContext.request.contextPath}/admin/products/create">
        Thêm sản phẩm
    </a>

    <!-- EMPTY -->
    <c:if test="${empty products}">
        <p>Không có sản phẩm nào.</p>
    </c:if>

    <!-- TABLE -->
    <c:if test="${not empty products}">
        <table class="admin-table">

            <thead>
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Hãng</th>
                <th>Giá</th>
                <th>Tag</th>
                <th>Hành động</th>
            </tr>
            </thead>

            <tbody>

            <c:forEach var="p" items="${products}">
                <tr>

                    <td>${p.id}</td>

                    <td>
                        <img width="50"
                             src="${p.imagePath.startsWith('http')
                                   ? p.imagePath
                                   : pageContext.request.contextPath.concat('/').concat(p.imagePath)}" />

                            ${p.name}
                    </td>

                    <td>${p.brand}</td>

                    <td>
                        <fmt:formatNumber value="${p.price}" type="number"/> đ
                    </td>

                    <td>${p.tag}</td>

                    <td>

                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}">
                            Sửa
                        </a>

                        <form action="${pageContext.request.contextPath}/admin/products/delete"
                              method="post"
                              style="display:inline;">

                            <input type="hidden" name="id" value="${p.id}" />

                            <button type="submit">Xóa</button>

                        </form>

                    </td>

                </tr>
            </c:forEach>

            </tbody>

        </table>
    </c:if>

</main>
