package haidang.casestudy.controller.auth_controller;

import haidang.casestudy.model.user_model.User;
import haidang.casestudy.service.auth_service.AuthService;
import haidang.casestudy.service.auth_service.IAuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
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
                "/views/auth/register.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter(
                        "confirmPassword"
                );

        // VALIDATE PASSWORD MATCH

        if (!password.equals(confirmPassword)) {

            request.setAttribute(
                    "errorMessage",
                    "Passwords do not match"
            );

            request.setAttribute(
                    "enteredFullName",
                    fullName
            );

            request.setAttribute(
                    "enteredEmail",
                    email
            );

            request.setAttribute(
                    "enteredPhone",
                    phone
            );

            request.getRequestDispatcher(
                    "/views/auth/register.jsp"
            ).forward(request, response);

            return;
        }

        // CREATE USER

        User user = new User();

        user.setFullName(fullName);

        user.setEmail(email);

        user.setPhone(phone);

        user.setPassword(password);

        user.setRole("USER");

        boolean success =
                authService.register(user);

        // EMAIL EXISTS

        if (!success) {

            request.setAttribute(
                    "errorMessage",
                    "Email already exists"
            );

            request.setAttribute(
                    "enteredFullName",
                    fullName
            );

            request.setAttribute(
                    "enteredEmail",
                    email
            );

            request.setAttribute(
                    "enteredPhone",
                    phone
            );

            request.getRequestDispatcher(
                    "/views/auth/register.jsp"
            ).forward(request, response);

            return;
        }

        // SUCCESS

        response.sendRedirect(
                request.getContextPath()
                        + "/login"
        );
    }
}
