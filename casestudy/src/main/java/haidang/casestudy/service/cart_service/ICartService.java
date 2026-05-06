package haidang.casestudy.service.cart_service;

import haidang.casestudy.model.cart_model.Cart;

public interface ICartService {
    Cart getCartByUserId(int userId);

    void addToCart(int userId,
                   int variantId,
                   int quantity);

    void updateQuantity(int userId,
                        int variantId,
                        int quantity);

    void removeItem(int userId,
                    int variantId);
}
