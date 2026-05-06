package haidang.casestudy.controller.admin_controller;

import haidang.casestudy.model.order_model.Order;
import haidang.casestudy.service.order_service.IOrderService;
import haidang.casestudy.service.order_service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
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

        List<Order> orders =
                orderService.getAllOrders();

        request.setAttribute(
                "orders",
                orders
        );

        request.getRequestDispatcher(
                "/views/admin/order/order-list.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        int orderId =
                Integer.parseInt(
                        request.getParameter(
                                "orderId"
                        )
                );

        String status =
                request.getParameter(
                        "status"
                );

        orderService.updateOrderStatus(
                orderId,
                status
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/orders"
        );
    }
}
