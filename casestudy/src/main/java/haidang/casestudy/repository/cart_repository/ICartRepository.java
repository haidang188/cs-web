package haidang.casestudy.repository.cart_repository;

import haidang.casestudy.model.cart_model.Cart;

import java.util.Optional;

public interface ICartRepository {
    Optional<Cart> findByUserId(int userId);

    void createCart(int userId);
}
