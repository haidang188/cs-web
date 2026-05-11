package haidang.casestudy.service.order_service;

import haidang.casestudy.model.cart_model.Cart;
import haidang.casestudy.model.cart_model.CartItem;
import haidang.casestudy.model.order_model.Order;
import haidang.casestudy.model.order_model.OrderItem;
import haidang.casestudy.repository.cart_repository.CartItemRepository;
import haidang.casestudy.repository.cart_repository.CartRepository;
import haidang.casestudy.repository.cart_repository.ICartItemRepository;
import haidang.casestudy.repository.cart_repository.ICartRepository;
import haidang.casestudy.repository.order_repository.IOrderRepository;
import haidang.casestudy.repository.order_repository.OrderRepository;
import haidang.casestudy.service.cart_service.CartService;
import haidang.casestudy.service.cart_service.ICartService;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderService implements IOrderService {
    private final IOrderRepository orderRepository;
    private final ICartService cartService;
    private final ICartRepository cartRepository;
    private final ICartItemRepository cartItemRepository;

    public OrderService() {
        orderRepository = new OrderRepository();
        cartService = new CartService();
        cartRepository = new CartRepository();
        cartItemRepository = new CartItemRepository();
    }

    @Override
    public int checkout(int userId, String address, String phone) {
        Cart cart = cartService.getCartByUserId(userId);
        if (cart.getItems() == null || cart.getItems().isEmpty()) {
            return -1;
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setStatus("PENDING");
        order.setAddress(address);
        order.setPhone(phone);
        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem cartItem : cart.getItems()) {
            OrderItem item = new OrderItem();
            item.setVariantId(cartItem.getVariant().getId());
            item.setProductName(cartItem.getVariant().getProduct().getName());
            item.setPrice(cartItem.getVariant().getPrice());
            item.setQuantity(cartItem.getQuantity());
            total = total.add(item.getSubtotal());
            orderItems.add(item);
        }
        order.setItems(orderItems);
        order.setTotal(total);

        int orderId = orderRepository.createOrder(order);
        if (orderId > 0) {
            for (CartItem cartItem : cart.getItems()) {
                cartItemRepository.removeItem(cart.getId(), cartItem.getVariant().getId());
            }
        }
        return orderId;
    }

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public void updateOrderStatus(int orderId, String status) {
        orderRepository.updateStatus(orderId, status);
    }
}
