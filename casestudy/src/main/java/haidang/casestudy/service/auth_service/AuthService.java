package haidang.casestudy.service.auth_service;

import haidang.casestudy.model.user_model.User;
import haidang.casestudy.repository.user_repository.IUserRepository;
import haidang.casestudy.repository.user_repository.UserRepository;

import java.util.Optional;

public class AuthService implements IAuthService {

    private final IUserRepository userRepository;

    public AuthService() {
        userRepository = new UserRepository();
    }
    @Override
    public Optional<User> login(String email, String password) {
        Optional<User> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isEmpty()) {
            return Optional.empty();
        }
        User user = optionalUser.get();
        if (!user.getPassword().equals(password)) {
            return Optional.empty();
        }
        return Optional.of(user);
    }
    @Override
    public boolean register(User user) {
        Optional<User> existingUser = userRepository.findByEmail(user.getEmail());
        if (existingUser.isPresent()) {
            return false;
        }
        userRepository.save(user);
        userRepository.save(user);
        return true;
    }
}
