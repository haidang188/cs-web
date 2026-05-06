package haidang.casestudy.model.cart_model;

import haidang.casestudy.model.product_model.ProductVariant;

public class CartItem {
    private int cartId;

    private ProductVariant variant;

    private int quantity;

    public CartItem() {
    }

    public CartItem(int cartId,
                    ProductVariant variant,
                    int quantity) {

        this.cartId = cartId;
        this.variant = variant;
        this.quantity = quantity;
    }

    public double getSubtotal() {

        if (variant == null) {
            return 0;
        }

        return variant.getPrice().doubleValue()
                * quantity;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
