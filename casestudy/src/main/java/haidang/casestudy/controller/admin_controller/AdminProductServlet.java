package haidang.casestudy.controller.admin_controller;

import haidang.casestudy.model.product_model.Brand;
import haidang.casestudy.model.product_model.Category;
import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.repository.product_repository.BrandRepository;
import haidang.casestudy.repository.product_repository.CategoryRepository;
import haidang.casestudy.repository.product_repository.IBrandRepository;
import haidang.casestudy.repository.product_repository.ICategoryRepository;
import haidang.casestudy.service.product_service.IProductService;
import haidang.casestudy.service.product_service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet({"/admin/products", "/admin/products/*"})
public class AdminProductServlet extends HttpServlet {
    private IProductService productService;

    private ICategoryRepository categoryRepository;

    private IBrandRepository brandRepository;

    @Override
    public void init() {

        productService = new ProductService();

        categoryRepository =
                new CategoryRepository();

        brandRepository =
                new BrandRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            action = pathInfo.substring(1);
        }

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "create":
                showCreateForm(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "delete":
                deleteProduct(request, response);
                break;

            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.length() > 1) {
            action = pathInfo.substring(1);
        }

        if ("create".equals(action)) {

            createProduct(request, response);

        } else if ("edit".equals(action)) {

            updateProduct(request, response);
        } else if ("delete".equals(action)) {

            deleteProduct(request, response);
        }
    }

    private void listProducts(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products =
                productService.getAllProducts();

        request.setAttribute("products", products);
        request.setAttribute("pageTitle", "Quản lý sản phẩm");
        request.setAttribute("contentPage", "/admin/products-content.jsp");

        request.getRequestDispatcher(
                "/layouts/admin.jsp"
        ).forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories =
                categoryRepository.findAll();

        List<Brand> brands =
                brandRepository.findAll();

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("pageTitle", "Thêm sản phẩm");
        request.setAttribute("contentPage", "/admin/product-form-content.jsp");

        request.getRequestDispatcher(
                "/layouts/admin.jsp"
        ).forward(request, response);
    }

    private void createProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");

        String model = request.getParameter("model");

        int categoryId =
                Integer.parseInt(
                        request.getParameter("categoryId")
                );

        int brandId =
                Integer.parseInt(
                        request.getParameter("brandId")
                );

        String description =
                request.getParameter("description");

        Product product = new Product();

        product.setName(name);
        product.setModel(model);
        product.setDescription(description);
        product.setStatus(true);

        Category category = new Category();
        category.setId(categoryId);

        Brand brand = new Brand();
        brand.setId(brandId);

        product.setCategory(category);
        product.setBrand(brand);

        productService.createProduct(product);

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/products"
        );
    }

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(
                request.getParameter("id")
        );

        Optional<Product> optionalProduct =
                productService.getProductById(id);

        if (optionalProduct.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

            return;
        }

        List<Category> categories =
                categoryRepository.findAll();

        List<Brand> brands =
                brandRepository.findAll();

        request.setAttribute(
                "product",
                optionalProduct.get()
        );

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("editing", true);
        request.setAttribute("pageTitle", "Sửa sản phẩm");
        request.setAttribute("contentPage", "/admin/product-form-content.jsp");

        request.getRequestDispatcher(
                "/layouts/admin.jsp"
        ).forward(request, response);
    }

    private void updateProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(
                request.getParameter("id")
        );

        String name = request.getParameter("name");

        String model = request.getParameter("model");

        int categoryId =
                Integer.parseInt(
                        request.getParameter("categoryId")
                );

        int brandId =
                Integer.parseInt(
                        request.getParameter("brandId")
                );

        String description =
                request.getParameter("description");

        String status =
                request.getParameter("status");

        Product product = new Product();

        product.setId(id);

        product.setName(name);
        product.setModel(model);

        product.setDescription(description);

        product.setStatus("true".equals(status));

        Category category = new Category();
        category.setId(categoryId);

        Brand brand = new Brand();
        brand.setId(brandId);

        product.setCategory(category);
        product.setBrand(brand);

        productService.updateProduct(product);

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/products"
        );
    }

    private void deleteProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(
                request.getParameter("id")
        );

        productService.deleteProduct(id);

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/products"
        );
    }
}
