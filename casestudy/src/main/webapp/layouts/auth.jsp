<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>

  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>${pageTitle}</title>

  <!-- CSS riêng cho auth -->
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/login.css" />

</head>

<body>

<!-- CONTENT -->
<jsp:include page="${contentPage}" />

</body>
</html>

