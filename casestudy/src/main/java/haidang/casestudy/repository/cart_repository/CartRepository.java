package haidang.casestudy.repository.cart_repository;

import haidang.casestudy.model.cart_model.Cart;
import haidang.casestudy.ultis.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class CartRepository implements ICartRepository{
    private static final String FIND_BY_USER_ID = """
            SELECT *
            FROM carts
            WHERE user_id = ?
            """;

    private static final String INSERT = """
            INSERT INTO carts(user_id)
            VALUES (?)
            """;

    @Override
    public Optional<Cart> findByUserId(int userId) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                FIND_BY_USER_ID
                        )
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Cart cart = new Cart();

                    cart.setId(rs.getInt("id"));

                    cart.setUserId(
                            rs.getInt("user_id")
                    );

                    return Optional.of(cart);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    @Override
    public void createCart(int userId) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                INSERT
                        )
        ) {

            ps.setInt(1, userId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
