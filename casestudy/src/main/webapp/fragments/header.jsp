<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentUser"
       value="${sessionScope.currentUser}" />

<header class="site-header">

    <div class="container nav-wrap">

        <!-- LOGO -->

        <a href="${pageContext.request.contextPath}/home"
           class="logo">

            <span class="logo-mark">
                DT
            </span>

            <span class="logo-text">
                PhoneStore
            </span>

        </a>

        <!-- NAVIGATION -->

        <nav class="top-nav">

            <a href="#san-pham">
                Sản phẩm
            </a>

            <a href="#danh-muc">
                Danh mục
            </a>

            <a href="#thuong-hieu">
                Thương hiệu
            </a>

            <a href="#danh-gia">
                Đánh giá
            </a>

            <a href="#lien-he">
                Liên hệ
            </a>

            <a href="${pageContext.request.contextPath}/products">
                Tất cả sản phẩm
            </a>

            <!-- GUEST -->

            <c:choose>

                <c:when test="${currentUser == null}">

                    <a href="${pageContext.request.contextPath}/login">
                        Đăng nhập
                    </a>

                </c:when>

                <!-- LOGGED IN -->

                <c:otherwise>

                    <a href="${pageContext.request.contextPath}/cart">
                        Giỏ hàng
                    </a>

                    <a href="${pageContext.request.contextPath}/orders">
                        Đơn hàng
                    </a>

                    <!-- ADMIN -->

                    <c:if test="${currentUser.role == 'ADMIN'}">

                        <a href="${pageContext.request.contextPath}/admin">
                            Admin
                        </a>

                    </c:if>

                    <!-- USER NAME -->

                    <span class="nav-user-chip">

                        Xin chào,
                        ${currentUser.fullName}

                    </span>

                    <!-- LOGOUT -->

                    <a href="${pageContext.request.contextPath}/logout">
                        Đăng xuất
                    </a>

                </c:otherwise>

            </c:choose>

        </nav>

    </div>

</header>