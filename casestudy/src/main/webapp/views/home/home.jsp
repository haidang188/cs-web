<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Trang chủ - DT PhoneStore</title>

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

<!-- MAIN CONTENT -->

<main class="site-main">

    <jsp:include page="/views/user/home/home-content.jsp"/>

</main>

<!-- FOOTER -->

<jsp:include page="/views/common/footer.jsp"/>

<!-- JS -->

<script src="${pageContext.request.contextPath}/jquery/jquery-3.5.1.min.js"></script>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.js"></script>

</body>

</html>