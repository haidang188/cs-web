package haidang.casestudy.service.auth_service;

import haidang.casestudy.model.user_model.User;

import java.util.Optional;

public interface IAuthService {
    Optional<User> login(String email, String password);
    boolean register(User user);
}
