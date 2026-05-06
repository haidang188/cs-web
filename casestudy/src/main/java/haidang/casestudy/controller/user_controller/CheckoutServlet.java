package haidang.casestudy.controller.user_controller;

import haidang.casestudy.model.user_model.User;
import haidang.casestudy.model.cart_model.Cart;
import haidang.casestudy.service.cart_service.CartService;
import haidang.casestudy.service.cart_service.ICartService;
import haidang.casestudy.service.order_service.IOrderService;
import haidang.casestudy.service.order_service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private IOrderService orderService;
    private ICartService cartService;

    @Override
    public void init() {

        orderService =
                new OrderService();
        cartService =
                new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        showCheckout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException, ServletException {

        User user =
                (User) request.getSession()
                        .getAttribute(
                                "loggedInUser"
                        );

        String address =
                request.getParameter("address");

        String phone =
                request.getParameter("phone");

        // VALIDATE

        if (address == null
                || address.isBlank()
                || phone == null
                || phone.isBlank()) {

            request.setAttribute(
                    "errorMessage",
                    "Please fill all fields"
            );

            showCheckout(request, response);

            return;
        }

        // CHECKOUT

        int orderId =
                orderService.checkout(
                        user.getId(),
                        address,
                        phone
                );

        // FAILED

        if (orderId <= 0) {

            request.setAttribute(
                    "errorMessage",
                    "Checkout failed"
            );

            showCheckout(request, response);

            return;
        }

        // SUCCESS

        response.sendRedirect(
                request.getContextPath()
                        + "/order-success?id="
                        + orderId
        );
    }

    private void showCheckout(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        User user =
                (User) request.getSession()
                        .getAttribute("loggedInUser");

        Cart cart =
                cartService.getCartByUserId(user.getId());

        request.setAttribute("cartItems", cart.getItems());
        request.setAttribute("cartTotal", cart.getTotalAmount());
        request.setAttribute("pageTitle", "Thanh toán");
        request.setAttribute("contentPage", "/cart/checkout-content.jsp");

        request.getRequestDispatcher(
                "/layouts/main.jsp"
        ).forward(request, response);
    }
}
