package haidang.casestudy.filter;

import haidang.casestudy.model.user_model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse resp =
                (HttpServletResponse) response;

        HttpSession session =
                req.getSession(false);

        // NOT LOGIN

        if (session == null
                || session.getAttribute(
                "loggedInUser"
        ) == null) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/login"
            );

            return;
        }

        User user =
                (User) session.getAttribute(
                        "loggedInUser"
                );

        // NOT ADMIN

        if (!"ADMIN".equals(user.getRole())) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/home"
            );

            return;
        }

        chain.doFilter(request, response);
    }
}
