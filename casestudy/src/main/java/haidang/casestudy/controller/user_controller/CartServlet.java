package haidang.casestudy.controller.user_controller;

import haidang.casestudy.model.cart_model.Cart;
import haidang.casestudy.model.user_model.User;
import haidang.casestudy.service.cart_service.CartService;
import haidang.casestudy.service.cart_service.ICartService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() {

        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if (action == null) {

            showCart(request, response);

            return;
        }

        switch (action) {

            case "remove":

                removeItem(request, response);

                break;

            default:

                showCart(request, response);

                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if ("add".equals(action)) {

            addToCart(request, response);

        } else if ("update".equals(action)) {

            updateQuantity(request, response);
        }
    }

    // SHOW CART

    private void showCart(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        User user = getLoggedInUser(request);

        Cart cart =
                cartService.getCartByUserId(
                        user.getId()
                );

        request.setAttribute("cart", cart);

        request.getRequestDispatcher(
                "/views/user/cart/cart.jsp"
        ).forward(request, response);
    }

    // ADD TO CART

    private void addToCart(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        User user = getLoggedInUser(request);

        int variantId =
                Integer.parseInt(
                        request.getParameter(
                                "variantId"
                        )
                );

        int quantity =
                Integer.parseInt(
                        request.getParameter(
                                "quantity"
                        )
                );

        cartService.addToCart(
                user.getId(),
                variantId,
                quantity
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }

    // UPDATE QUANTITY

    private void updateQuantity(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        User user = getLoggedInUser(request);

        int variantId =
                Integer.parseInt(
                        request.getParameter(
                                "variantId"
                        )
                );

        int quantity =
                Integer.parseInt(
                        request.getParameter(
                                "quantity"
                        )
                );

        cartService.updateQuantity(
                user.getId(),
                variantId,
                quantity
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }

    // REMOVE ITEM

    private void removeItem(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        User user = getLoggedInUser(request);

        int variantId =
                Integer.parseInt(
                        request.getParameter(
                                "variantId"
                        )
                );

        cartService.removeItem(
                user.getId(),
                variantId
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/cart"
        );
    }

    // GET SESSION USER

    private User getLoggedInUser(
            HttpServletRequest request
    ) {

        HttpSession session =
                request.getSession(false);

        return (User) session.getAttribute(
                "loggedInUser"
        );
    }
}
