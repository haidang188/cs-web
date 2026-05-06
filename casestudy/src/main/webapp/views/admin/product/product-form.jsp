<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/common/header.jsp"/>
<!DOCTYPE html>
<html>

<head>

  <title>Product Form</title>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css">

</head>

<body>

<div class="container mt-5 mb-5">

  <div class="row justify-content-center">

    <div class="col-lg-8">

      <div class="card shadow">

        <div class="card-header">

          <h3 class="mb-0">

            <c:choose>

              <c:when test="${editing}">
                Edit Product
              </c:when>

              <c:otherwise>
                Create Product
              </c:otherwise>

            </c:choose>

          </h3>

        </div>

        <div class="card-body">

          <!-- ERROR MESSAGE -->

          <c:if test="${not empty errorMessage}">

            <div class="alert alert-danger">

                ${errorMessage}

            </div>

          </c:if>

          <!-- FORM -->

          <form method="post"
                action="${pageContext.request.contextPath}/admin/products"
                class="needs-validation"
                novalidate>

            <!-- ACTION -->

            <input type="hidden"
                   name="action"
                   value="${editing ? 'edit' : 'create'}">

            <!-- PRODUCT ID -->

            <c:if test="${editing}">

              <input type="hidden"
                     name="id"
                     value="${product.id}">

            </c:if>

            <!-- PRODUCT NAME -->

            <div class="mb-3">

              <label class="form-label">

                Product Name

              </label>

              <input type="text"
                     name="name"
                     class="form-control"
                     value="${product.name}"
                     required
                     minlength="3"
                     maxlength="255">

              <div class="invalid-feedback">

                Product name must be 3-255 characters.

              </div>

            </div>

            <!-- MODEL -->

            <div class="mb-3">

              <label class="form-label">

                Model

              </label>

              <input type="text"
                     name="model"
                     class="form-control"
                     value="${product.model}"
                     required>

              <div class="invalid-feedback">

                Model is required.

              </div>

            </div>

            <!-- CATEGORY -->

            <div class="mb-3">

              <label class="form-label">

                Category

              </label>

              <select name="categoryId"
                      class="form-select"
                      required>

                <option value="">

                  Select Category

                </option>

                <c:forEach items="${categories}"
                           var="category">

                  <option value="${category.id}"

                          <c:if test="${product.category.id == category.id}">
                            selected
                          </c:if>>

                      ${category.name}

                  </option>

                </c:forEach>

              </select>

              <div class="invalid-feedback">

                Please select category.

              </div>

            </div>

            <!-- BRAND -->

            <div class="mb-3">

              <label class="form-label">

                Brand

              </label>

              <select name="brandId"
                      class="form-select"
                      required>

                <option value="">

                  Select Brand

                </option>

                <c:forEach items="${brands}"
                           var="brand">

                  <option value="${brand.id}"

                          <c:if test="${product.brand.id == brand.id}">
                            selected
                          </c:if>>

                      ${brand.name}

                  </option>

                </c:forEach>

              </select>

              <div class="invalid-feedback">

                Please select brand.

              </div>

            </div>

            <!-- DESCRIPTION -->

            <div class="mb-3">

              <label class="form-label">

                Description

              </label>

              <textarea name="description"
                        class="form-control"
                        rows="4"
                        minlength="10"
                        required>${product.description}</textarea>

              <div class="invalid-feedback">

                Description must be at least 10 characters.

              </div>

            </div>

            <!-- VARIANT SECTION -->

            <hr>

            <h5 class="mb-3">

              Product Variant

            </h5>

            <div class="row">

              <!-- RAM -->

              <div class="col-md-6 mb-3">

                <label class="form-label">

                  RAM

                </label>

                <input type="text"
                       name="ram"
                       class="form-control"
                       placeholder="8GB"
                       required>

              </div>

              <!-- STORAGE -->

              <div class="col-md-6 mb-3">

                <label class="form-label">

                  Storage

                </label>

                <input type="text"
                       name="storage"
                       class="form-control"
                       placeholder="256GB"
                       required>

              </div>

            </div>

            <div class="row">

              <!-- PRICE -->

              <div class="col-md-6 mb-3">

                <label class="form-label">

                  Price

                </label>

                <input type="number"
                       name="price"
                       class="form-control"
                       min="1"
                       required>

              </div>

              <!-- STOCK -->

              <div class="col-md-6 mb-3">

                <label class="form-label">

                  Stock

                </label>

                <input type="number"
                       name="stock"
                       class="form-control"
                       min="0"
                       required>

              </div>

            </div>

            <!-- IMAGE -->

            <hr>

            <h5 class="mb-3">

              Product Image

            </h5>

            <div class="mb-3">

              <label class="form-label">

                Image URL

              </label>

              <input type="url"
                     name="imageUrl"
                     class="form-control"
                     placeholder="https://example.com/image.jpg"
                     required>

              <div class="invalid-feedback">

                Please enter valid image URL.

              </div>

            </div>

            <!-- STATUS -->

            <c:if test="${editing}">

              <div class="mb-3">

                <label class="form-label">

                  Status

                </label>

                <select name="status"
                        class="form-select">

                  <option value="ACTIVE"
                    ${product.status == 'ACTIVE' ? 'selected' : ''}>

                    ACTIVE

                  </option>

                  <option value="INACTIVE"
                    ${product.status == 'INACTIVE' ? 'selected' : ''}>

                    INACTIVE

                  </option>

                </select>

              </div>

            </c:if>

            <!-- BUTTONS -->

            <div class="d-flex gap-2">

              <button type="submit"
                      class="btn btn-primary">

                Save Product

              </button>

              <a href="${pageContext.request.contextPath}/admin/products"
                 class="btn btn-secondary">

                Back

              </a>

            </div>

          </form>

        </div>

      </div>

    </div>

  </div>

</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>

<script>

  (() => {

    'use strict';

    const forms =
            document.querySelectorAll('.needs-validation');

    Array.from(forms).forEach(form => {

      form.addEventListener('submit', event => {

        if (!form.checkValidity()) {

          event.preventDefault();
          event.stopPropagation();
        }

        form.classList.add('was-validated');

      }, false);

    });

  })();

</script>

</body>
</html>