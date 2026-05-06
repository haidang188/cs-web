package haidang.casestudy.repository.cart_repository;

import haidang.casestudy.model.cart_model.CartItem;

import java.util.List;

public interface ICartItemRepository {
    List<CartItem> findByCartId(int cartId);

    void addToCart(int cartId,
                   int variantId,
                   int quantity);

    void updateQuantity(int cartId,
                        int variantId,
                        int quantity);

    void removeItem(int cartId,
                    int variantId);

    boolean exists(int cartId,
                   int variantId);
}
