package haidang.casestudy.service.order_service;

import haidang.casestudy.model.order_model.Order;

import java.util.List;

public interface IOrderService {
    int checkout(int userId,
                 String address,
                 String phone);
    List<Order> getAllOrders();

    void updateOrderStatus(int orderId,
                           String status);
}
