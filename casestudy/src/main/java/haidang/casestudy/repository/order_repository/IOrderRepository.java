package haidang.casestudy.repository.order_repository;

import haidang.casestudy.model.order_model.Order;

import java.util.List;

public interface IOrderRepository {
    int createOrder(Order order);
    List<Order> findAll();

    void updateStatus(int orderId,
                      String status);
}
