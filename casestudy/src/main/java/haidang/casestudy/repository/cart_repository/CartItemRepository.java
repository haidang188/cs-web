package haidang.casestudy.repository.cart_repository;

import haidang.casestudy.model.cart_model.CartItem;
import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.model.product_model.ProductVariant;
import haidang.casestudy.ultis.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartItemRepository implements ICartItemRepository{
    private static final String FIND_BY_CART_ID = """
            SELECT ci.cart_id,
                   ci.quantity,

                   pv.id AS variant_id,
                   pv.ram,
                   pv.storage,
                   pv.price,
                   pv.stock,

                   p.id AS product_id,
                   p.name,

                   pi.image_url

            FROM cart_items ci

            JOIN product_variants pv
                ON ci.variant_id = pv.id

            JOIN products p
                ON pv.product_id = p.id

            LEFT JOIN product_images pi
                ON p.id = pi.product_id
                AND pi.is_primary = TRUE

            WHERE ci.cart_id = ?
            """;

    private static final String INSERT = """
            INSERT INTO cart_items(
                cart_id,
                variant_id,
                quantity
            )
            VALUES (?, ?, ?)
            """;

    private static final String UPDATE_QUANTITY = """
            UPDATE cart_items
            SET quantity = ?
            WHERE cart_id = ?
            AND variant_id = ?
            """;

    private static final String DELETE = """
            DELETE FROM cart_items
            WHERE cart_id = ?
            AND variant_id = ?
            """;

    private static final String EXISTS = """
            SELECT 1
            FROM cart_items
            WHERE cart_id = ?
            AND variant_id = ?
            """;

    @Override
    public List<CartItem> findByCartId(int cartId) {

        List<CartItem> items = new ArrayList<>();

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                FIND_BY_CART_ID
                        )
        ) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Product product = new Product();

                    product.setId(
                            rs.getInt("product_id")
                    );

                    product.setName(
                            rs.getString("name")
                    );

                    ProductVariant variant =
                            new ProductVariant();

                    variant.setId(
                            rs.getInt("variant_id")
                    );

                    variant.setRam(
                            rs.getString("ram")
                    );

                    variant.setStorage(
                            rs.getString("storage")
                    );

                    variant.setPrice(
                            rs.getBigDecimal("price")
                    );

                    variant.setStock(
                            rs.getInt("stock")
                    );

                    variant.setProduct(product);

                    CartItem item = new CartItem();

                    item.setCartId(
                            rs.getInt("cart_id")
                    );

                    item.setVariant(variant);

                    item.setQuantity(
                            rs.getInt("quantity")
                    );

                    items.add(item);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    @Override
    public void addToCart(int cartId,
                          int variantId,
                          int quantity) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                INSERT
                        )
        ) {

            ps.setInt(1, cartId);

            ps.setInt(2, variantId);

            ps.setInt(3, quantity);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateQuantity(int cartId,
                               int variantId,
                               int quantity) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                UPDATE_QUANTITY
                        )
        ) {

            ps.setInt(1, quantity);

            ps.setInt(2, cartId);

            ps.setInt(3, variantId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void removeItem(int cartId,
                           int variantId) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                DELETE
                        )
        ) {

            ps.setInt(1, cartId);

            ps.setInt(2, variantId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean exists(int cartId,
                          int variantId) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                EXISTS
                        )
        ) {

            ps.setInt(1, cartId);

            ps.setInt(2, variantId);

            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
