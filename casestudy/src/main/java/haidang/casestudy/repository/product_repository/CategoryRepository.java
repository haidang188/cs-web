package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.Category;
import haidang.casestudy.ultis.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CategoryRepository implements ICategoryRepository {

    private static final String FIND_ALL = """
            SELECT *
            FROM categories
            ORDER BY id DESC
            """;

    private static final String FIND_BY_ID = """
            SELECT *
            FROM categories
            WHERE id = ?
            """;

    private static final String INSERT = """
            INSERT INTO categories(name)
            VALUES (?)
            """;

    private static final String UPDATE = """
            UPDATE categories
            SET name = ?
            WHERE id = ?
            """;

    private static final String DELETE = """
            DELETE FROM categories
            WHERE id = ?
            """;
    @Override
    public List<Category> findAll() {
        List<Category> categories = new ArrayList<>();

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(FIND_ALL);

                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Category category =
                        mapResultSetToCategory(rs);

                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    @Override
    public Optional<Category> findById(int id) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(FIND_BY_ID)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Category category =
                            mapResultSetToCategory(rs);

                    return Optional.of(category);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    @Override
    public void save(Category category) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(INSERT)
        ) {

            ps.setString(1, category.getName());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Category category) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(UPDATE)
        ) {

            ps.setString(1, category.getName());
            ps.setInt(2, category.getId());

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

    private Category mapResultSetToCategory(ResultSet rs)
            throws SQLException {

        Category category = new Category();

        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));

        return category;
    }
}
