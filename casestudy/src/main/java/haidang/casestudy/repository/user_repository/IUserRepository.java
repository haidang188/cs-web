package haidang.casestudy.repository.user_repository;

import haidang.casestudy.model.user_model.User;

import java.util.Optional;

public interface IUserRepository {
    Optional<User> findByEmail(String email);
    void save(User user);
}
