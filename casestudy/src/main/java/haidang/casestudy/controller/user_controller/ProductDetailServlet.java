package haidang.casestudy.controller.user_controller;

import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.service.product_service.IProductService;
import haidang.casestudy.service.product_service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/product-detail")
public class ProductDetailServlet
        extends HttpServlet {

    private IProductService productService;

    @Override
    public void init() {

        productService =
                new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id;

        // VALIDATE ID

        try {

            id = Integer.parseInt(
                    request.getParameter("id")
            );

        } catch (Exception e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/products"
            );

            return;
        }

        // GET PRODUCT DETAIL

        Optional<Product> optionalProduct =
                productService.findDetailById(id);

        // NOT FOUND

        if (optionalProduct.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/products"
            );

            return;
        }

        // SET ATTRIBUTE

        request.setAttribute(
                "product",
                optionalProduct.get()
        );

        // FORWARD

        request.getRequestDispatcher(
                "/views/user/product/product-detail.jsp"
        ).forward(request, response);
    }

}
