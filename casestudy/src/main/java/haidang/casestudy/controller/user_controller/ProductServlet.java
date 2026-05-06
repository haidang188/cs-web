package haidang.casestudy.controller.user_controller;

import haidang.casestudy.model.product_model.ProductPageResponse;
import haidang.casestudy.service.category_service.CategoryService;

import haidang.casestudy.service.brand_service.BrandService;
import haidang.casestudy.service.brand_service.IBrandService;
import haidang.casestudy.service.category_service.ICategoryService;
import haidang.casestudy.service.product_service.IProductService;
import haidang.casestudy.service.product_service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private IProductService productService;

    private IBrandService brandService;

    private ICategoryService categoryService;

    @Override
    public void init() {

        productService =
                new ProductService();

        brandService =
                new BrandService();

        categoryService = new CategoryService();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // PARAMS

        String keyword =
                request.getParameter("keyword");

        Integer brandId =
                parseInteger(
                        request.getParameter(
                                "brandId"
                        )
                );

        Integer categoryId =
                parseInteger(
                        request.getParameter(
                                "categoryId"
                        )
                );

        int page =
                parsePage(
                        request.getParameter(
                                "page"
                        )
                );

        int size = 16;

        // SEARCH

        ProductPageResponse result =
                productService.searchProducts(
                        keyword,
                        brandId,
                        categoryId,
                        page,
                        size
                );

        // ATTRIBUTES

        request.setAttribute(
                "products",
                result.getProducts()
        );

        request.setAttribute(
                "currentPage",
                result.getCurrentPage()
        );

        request.setAttribute(
                "totalPages",
                result.getTotalPages()
        );

        request.setAttribute(
                "keyword",
                keyword
        );

        request.setAttribute(
                "brandId",
                brandId
        );

        request.setAttribute(
                "categoryId",
                categoryId
        );

        // FILTER DATA

        request.setAttribute(
                "brands",
                brandService.findAll()
        );

        request.setAttribute(
                "categories",
                categoryService.findAll()
        );

        request.setAttribute("pageTitle", "Sản phẩm");
        request.setAttribute("contentPage", "/product/products-content.jsp");

        request.getRequestDispatcher(
                "/layouts/main.jsp"
        ).forward(request, response);
    }

    // PARSE INTEGER

    private Integer parseInteger(
            String value
    ) {

        try {

            if (value == null
                    || value.isBlank()) {

                return null;
            }

            return Integer.parseInt(value);

        } catch (Exception e) {

            return null;
        }
    }

    // PAGE

    private int parsePage(String value) {

        try {

            int page =
                    Integer.parseInt(value);

            return Math.max(page, 1);

        } catch (Exception e) {

            return 1;
        }
    }
}
