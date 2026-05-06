package haidang.casestudy.controller.auth_controller;

import haidang.casestudy.model.user_model.User;
import haidang.casestudy.service.auth_service.AuthService;
import haidang.casestudy.service.auth_service.IAuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private IAuthService authService;

    @Override
    public void init() {

        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/views/auth/login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        Optional<User> optionalUser =
                authService.login(email, password);

        if (optionalUser.isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "Invalid email or password"
            );

            request.getRequestDispatcher(
                    "/views/auth/login.jsp"
            ).forward(request, response);

            return;
        }

        User user = optionalUser.get();

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "loggedInUser",
                user
        );

        if ("ADMIN".equals(user.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/products"
            );
        }
    }
}
