package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.Brand;
import haidang.casestudy.ultis.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BrandRepository implements IBrandRepository {
    private static final String FIND_ALL = """
            SELECT *
            FROM brands
            ORDER BY id DESC
            """;

    private static final String FIND_BY_ID = """
            SELECT *
            FROM brands
            WHERE id = ?
            """;

    private static final String INSERT = """
            INSERT INTO brands(name)
            VALUES (?)
            """;

    private static final String UPDATE = """
            UPDATE brands
            SET name = ?
            WHERE id = ?
            """;

    private static final String DELETE = """
            DELETE FROM brands
            WHERE id = ?
            """;
    @Override
    public List<Brand> findAll() {
        List<Brand> brands = new ArrayList<>();

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(FIND_ALL);

                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Brand brand =
                        mapResultSetToBrand(rs);

                brands.add(brand);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return brands;
    }

    @Override
    public Optional<Brand> findById(int id) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(FIND_BY_ID)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Brand brand =
                            mapResultSetToBrand(rs);

                    return Optional.of(brand);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    @Override
    public void save(Brand brand) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(INSERT)
        ) {

            ps.setString(1, brand.getName());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Brand brand) {

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(UPDATE)
        ) {

            ps.setString(1, brand.getName());
            ps.setInt(2, brand.getId());

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

    private Brand mapResultSetToBrand(ResultSet rs)
            throws SQLException {

        Brand brand = new Brand();

        brand.setId(rs.getInt("id"));
        brand.setName(rs.getString("name"));

        return brand;
    }
}
