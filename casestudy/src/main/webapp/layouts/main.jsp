<%--
  Created by IntelliJ IDEA.
  User: HAI DANG
  Date: 4/20/2026
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <%
    String contextPath = request.getContextPath();
  %>

  <meta charset="UTF-8" />
  <title>${pageTitle}</title>

  <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css" />
</head>

<body>

<div class="page-bg"></div>

<jsp:include page="/fragments/header.jsp"/>

<jsp:include page="${contentPage}"/>

<jsp:include page="/fragments/footer.jsp"/>

</body>
</html>


