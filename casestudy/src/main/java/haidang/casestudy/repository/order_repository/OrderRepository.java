package haidang.casestudy.repository.order_repository;

import haidang.casestudy.model.order_model.Order;
import haidang.casestudy.model.order_model.OrderItem;
import haidang.casestudy.ultis.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository implements IOrderRepository {
    private static final String INSERT_ORDER = """
            INSERT INTO orders(
                user_id,
                total,
                status,
                address,
                phone
            )
            VALUES (?, ?, ?, ?, ?)
            """;

    private static final String INSERT_ORDER_ITEM = """
            INSERT INTO order_items(
                order_id,
                variant_id,
                product_name,
                price,
                quantity
            )
            VALUES (?, ?, ?, ?, ?)
            """;

    private static final String FIND_ALL = """
        SELECT o.*,
               u.full_name

        FROM orders o

        JOIN users u
            ON o.user_id = u.id

        ORDER BY o.created_at DESC
        """;

    private static final String UPDATE_STATUS = """
        UPDATE orders
        SET status = ?
        WHERE id = ?
        """;

    @Override
    public int createOrder(Order order) {
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            connection.setAutoCommit(false);
            int orderId;
            try (
                    PreparedStatement ps = connection.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS)
            ) {
                ps.setInt(1, order.getUserId());
                ps.setBigDecimal(2, order.getTotal());
                ps.setString(3, order.getStatus());
                ps.setString(4, order.getAddress());
                ps.setString(5, order.getPhone());
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (!rs.next()) {
                        throw new SQLException("Cannot create order");
                    }
                    orderId = rs.getInt(1);
                }
            }
            for (OrderItem item : order.getItems()) {
                try (PreparedStatement ps = connection.prepareStatement(INSERT_ORDER_ITEM)
                ) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getVariantId());
                    ps.setString(3, item.getProductName());
                    ps.setBigDecimal(4, item.getPrice());
                    ps.setInt(5, item.getQuantity());
                    ps.executeUpdate();
                }
            }
            connection.commit();
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();

            if (connection != null) {
                try { connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return -1;
    }

    @Override
    public List<Order> findAll() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(FIND_ALL);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotal(rs.getBigDecimal("total"));
                order.setStatus(rs.getString("status"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public void updateStatus(int orderId, String status) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(UPDATE_STATUS)
        ) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
