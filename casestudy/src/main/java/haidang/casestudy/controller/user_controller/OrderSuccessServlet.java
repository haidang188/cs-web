package haidang.casestudy.controller.user_controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("placed", true);
        request.setAttribute("pageTitle", "Đặt hàng thành công");
        request.setAttribute("contentPage", "/order/order-content.jsp");

        request.getRequestDispatcher(
                "/layouts/main.jsp"
        ).forward(request, response);
    }

}
