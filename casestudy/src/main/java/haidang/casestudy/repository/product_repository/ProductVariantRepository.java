package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.ProductVariant;
import haidang.casestudy.ultis.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductVariantRepository implements IProductVariantRepository {

    private static final String FIND_BY_PRODUCT_ID = """
            SELECT *
            FROM product_variants
            WHERE product_id = ?
            ORDER BY price ASC
            """;

    private static final String FIND_BY_ID = """
            SELECT *
            FROM product_variants
            WHERE id = ?
            """;

    private static final String INSERT = """
            INSERT INTO product_variants(
                product_id,
                ram,
                storage,
                price,
                stock
            )
            VALUES (?, ?, ?, ?, ?)
            """;

    private static final String UPDATE = """
            UPDATE product_variants
            SET ram = ?,
                storage = ?,
                price = ?,
                stock = ?
            WHERE id = ?
            """;

    private static final String DELETE = """
            DELETE FROM product_variants
            WHERE id = ?
            """;


    @Override
    public List<ProductVariant> findByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(FIND_BY_PRODUCT_ID)
        ) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductVariant variant = mapResultSetToVariant(rs);
                    variants.add(variant);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    @Override
    public Optional<ProductVariant> findById(int id) {
        try (Connection connection = DBConnection.getConnection();

                PreparedStatement ps = connection.prepareStatement(FIND_BY_ID)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariant variant = mapResultSetToVariant(rs);
                    return Optional.of(variant);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
    @Override
    public void save(ProductVariant variant) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(INSERT)
        ) {
            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getRam());
            ps.setString(3, variant.getStorage());
            ps.setBigDecimal(4, variant.getPrice());
            ps.setInt(5, variant.getStock());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(ProductVariant variant) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(UPDATE)
        ) {
            ps.setString(1, variant.getRam());
            ps.setString(2, variant.getStorage());
            ps.setBigDecimal(3, variant.getPrice());
            ps.setInt(4, variant.getStock());
            ps.setInt(5, variant.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(DELETE)
        ) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private ProductVariant mapResultSetToVariant(ResultSet rs) throws SQLException {
        ProductVariant variant = new ProductVariant();
        variant.setId(rs.getInt("id"));
        variant.setProductId(rs.getInt("product_id"));
        variant.setRam(rs.getString("ram"));
        variant.setStorage(rs.getString("storage"));
        BigDecimal price = rs.getBigDecimal("price");
        variant.setPrice(price);
        variant.setStock(rs.getInt("stock"));
        return variant;
    }
}
