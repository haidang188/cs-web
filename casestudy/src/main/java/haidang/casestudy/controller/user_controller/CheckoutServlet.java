package haidang.casestudy.controller.user_controller;

import haidang.casestudy.model.user_model.User;
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

    @Override
    public void init() {

        orderService =
                new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/user/order/checkout.jsp"
        ).forward(request, response);
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

            request.getRequestDispatcher(
                    "/views/user/order/checkout.jsp"
            ).forward(request, response);

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

            request.getRequestDispatcher(
                    "/views/user/order/checkout.jsp"
            ).forward(request, response);

            return;
        }

        // SUCCESS

        response.sendRedirect(
                request.getContextPath()
                        + "/order-success?id="
                        + orderId
        );
    }
}
