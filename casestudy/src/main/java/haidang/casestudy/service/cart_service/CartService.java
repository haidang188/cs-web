package haidang.casestudy.service.cart_service;

import haidang.casestudy.model.cart_model.Cart;
import haidang.casestudy.model.cart_model.CartItem;
import haidang.casestudy.repository.cart_repository.CartItemRepository;
import haidang.casestudy.repository.cart_repository.CartRepository;
import haidang.casestudy.repository.cart_repository.ICartItemRepository;
import haidang.casestudy.repository.cart_repository.ICartRepository;

import java.util.List;
import java.util.Optional;

public class CartService implements ICartService{
    private final ICartRepository cartRepository;

    private final ICartItemRepository
            cartItemRepository;

    public CartService() {

        cartRepository =
                new CartRepository();

        cartItemRepository =
                new CartItemRepository();
    }

    @Override
    public Cart getCartByUserId(int userId) {

        Optional<Cart> optionalCart =
                cartRepository.findByUserId(
                        userId
                );

        // CREATE CART IF NOT EXISTS

        if (optionalCart.isEmpty()) {

            cartRepository.createCart(userId);

            optionalCart =
                    cartRepository.findByUserId(
                            userId
                    );
        }

        Cart cart = optionalCart.orElse(
                new Cart()
        );

        // LOAD ITEMS

        List<CartItem> items =
                cartItemRepository.findByCartId(
                        cart.getId()
                );

        cart.setItems(items);

        return cart;
    }

    @Override
    public void addToCart(int userId,
                          int variantId,
                          int quantity) {

        Cart cart =
                getCartByUserId(userId);

        boolean exists =
                cartItemRepository.exists(
                        cart.getId(),
                        variantId
                );

        // ITEM EXISTS → UPDATE QUANTITY

        if (exists) {

            CartItem existingItem =
                    cart.getItems()
                            .stream()
                            .filter(item ->
                                    item.getVariant()
                                            .getId()
                                            == variantId
                            )
                            .findFirst()
                            .orElse(null);

            if (existingItem != null) {

                int newQuantity =
                        existingItem.getQuantity()
                                + quantity;

                cartItemRepository.updateQuantity(
                        cart.getId(),
                        variantId,
                        newQuantity
                );
            }

        } else {

            // INSERT NEW ITEM

            cartItemRepository.addToCart(
                    cart.getId(),
                    variantId,
                    quantity
            );
        }
    }

    @Override
    public void updateQuantity(int userId,
                               int variantId,
                               int quantity) {

        Cart cart =
                getCartByUserId(userId);

        if (quantity <= 0) {

            cartItemRepository.removeItem(
                    cart.getId(),
                    variantId
            );

            return;
        }

        cartItemRepository.updateQuantity(
                cart.getId(),
                variantId,
                quantity
        );
    }

    @Override
    public void removeItem(int userId,
                           int variantId) {

        Cart cart =
                getCartByUserId(userId);

        cartItemRepository.removeItem(
                cart.getId(),
                variantId
        );
    }
}
