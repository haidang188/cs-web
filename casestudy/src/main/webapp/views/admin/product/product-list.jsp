<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

    <title>Product Management</title>

    <!-- BOOTSTRAP -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css">

    <!-- DATATABLE -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/datatables/css/dataTables.bootstrap5.css">

</head>

<body>

<div class="container-fluid mt-4">

    <!-- HEADER -->

    <div class="d-flex justify-content-between
                align-items-center mb-4">

        <div>

            <h2 class="mb-0">

                Product Management

            </h2>

            <p class="text-muted mb-0">

                Manage all products

            </p>

        </div>

        <a href="${pageContext.request.contextPath}/admin/products?action=create"
           class="btn btn-primary">

            + Create Product

        </a>

    </div>

    <!-- ALERT -->

    <c:if test="${not empty successMessage}">

        <div class="alert alert-success alert-dismissible fade show">

                ${successMessage}

            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"></button>

        </div>

    </c:if>

    <!-- TABLE CARD -->

    <div class="card shadow-sm">

        <div class="card-body">

            <div class="table-responsive">

                <table id="productTable"
                       class="table table-hover align-middle">

                    <thead class="table-dark">

                    <tr>

                        <th>ID</th>

                        <th>Image</th>

                        <th>Name</th>

                        <th>Brand</th>

                        <th>Category</th>

                        <th>Status</th>

                        <th>Created</th>

                        <th width="180">
                            Actions
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <c:forEach items="${products}"
                               var="product">

                        <tr>

                            <!-- ID -->

                            <td>

                                #${product.id}

                            </td>

                            <!-- IMAGE -->

                            <td>

                                <c:choose>

                                    <c:when test="${not empty product.images}">

                                        <img src="${product.images[0].imageUrl}"
                                             width="70"
                                             height="70"
                                             class="rounded border object-fit-cover">

                                    </c:when>

                                    <c:otherwise>

                                        <span class="text-muted">

                                            No Image

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <!-- NAME -->

                            <td>

                                <div class="fw-semibold">

                                        ${product.name}

                                </div>

                                <small class="text-muted">

                                        ${product.model}

                                </small>

                            </td>

                            <!-- BRAND -->

                            <td>

                                <span class="badge bg-primary">

                                        ${product.brand.name}

                                </span>

                            </td>

                            <!-- CATEGORY -->

                            <td>

                                <span class="badge bg-secondary">

                                        ${product.category.name}

                                </span>

                            </td>

                            <!-- STATUS -->

                            <td>

                                <c:choose>

                                    <c:when test="${product.status == 'ACTIVE'}">

                                        <span class="badge bg-success">

                                            ACTIVE

                                        </span>

                                    </c:when>

                                    <c:otherwise>

                                        <span class="badge bg-danger">

                                            INACTIVE

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <!-- CREATED -->

                            <td>

                                    ${product.createdAt}

                            </td>

                            <!-- ACTIONS -->

                            <td>

                                <div class="d-flex gap-2">

                                    <!-- EDIT -->

                                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}"
                                       class="btn btn-warning btn-sm">

                                        Edit

                                    </a>

                                    <!-- DELETE -->

                                    <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${product.id}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Delete this product?')">

                                        Delete

                                    </a>

                                </div>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- JQUERY -->

<script src="${pageContext.request.contextPath}/jquery/jquery-3.5.1.min.js"></script>

<!-- BOOTSTRAP -->

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.js"></script>

<!-- DATATABLE -->

<script src="${pageContext.request.contextPath}/datatables/js/jquery.dataTables.js"></script>

<script src="${pageContext.request.contextPath}/datatables/js/dataTables.bootstrap5.js"></script>

<!-- INIT DATATABLE -->

<script>

    $(document).ready(function () {

        $('#productTable').DataTable({

            pageLength: 5,

            lengthMenu: [5, 10, 20, 50],

            ordering: true,

            searching: true,

            responsive: true,

            language: {

                search: "Search:",

                lengthMenu:
                    "Show _MENU_ products",

                info:
                    "Showing _START_ to _END_ of _TOTAL_ products",

                paginate: {
                    previous: "Prev",
                    next: "Next"
                }

            }

        });

    });

</script>

</body>
</html>