<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${pageTitle}</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
</head>

<body>

<div class="page-bg"></div>

<jsp:include page="/fragments/admin-header.jsp"/>

<jsp:include page="${contentPage}"/>

</body>
</html>


