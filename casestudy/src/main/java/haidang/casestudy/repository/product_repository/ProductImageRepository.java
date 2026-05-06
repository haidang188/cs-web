package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.ProductImage;
import haidang.casestudy.ultis.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductImageRepository implements IProductImageRepository {
    private static final String FIND_BY_PRODUCT_ID = """
            SELECT *
            FROM product_images
            WHERE product_id = ?
            ORDER BY is_primary DESC, id ASC
            """;

    private static final String FIND_PRIMARY_IMAGE = """
            SELECT *
            FROM product_images
            WHERE product_id = ?
            AND is_primary = TRUE
            LIMIT 1
            """;

    private static final String INSERT = """
            INSERT INTO product_images(
                product_id,
                image_url,
                is_primary
            )
            VALUES (?, ?, ?)
            """;

    private static final String DELETE = """
            DELETE FROM product_images
            WHERE id = ?
            """;

    @Override
    public List<ProductImage> findByProductId(int productId) {
        List<ProductImage> images = new ArrayList<>();

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                FIND_BY_PRODUCT_ID
                        )
        ) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    ProductImage image =
                            mapResultSetToImage(rs);

                    images.add(image);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return images;
    }

    @Override
    public ProductImage findPrimaryImage(int productId) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                FIND_PRIMARY_IMAGE
                        )
        ) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapResultSetToImage(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void save(ProductImage image) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(INSERT)
        ) {

            ps.setInt(1, image.getProductId());
            ps.setString(2, image.getImageUrl());
            ps.setBoolean(3, image.isPrimary());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(DELETE)
        ) {

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private ProductImage mapResultSetToImage(ResultSet rs)
            throws SQLException {

        ProductImage image = new ProductImage();

        image.setId(rs.getInt("id"));
        image.setProductId(rs.getInt("product_id"));
        image.setImageUrl(rs.getString("image_url"));
        image.setPrimary(rs.getBoolean("is_primary"));

        return image;
    }
}
