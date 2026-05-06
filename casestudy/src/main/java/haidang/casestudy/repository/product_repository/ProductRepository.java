package haidang.casestudy.repository.product_repository;

import java.sql.Connection;

import haidang.casestudy.model.product_model.*;
import haidang.casestudy.ultis.DBConnection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class ProductRepository implements IProductRepository {

    private static final String FIND_ALL = """
            SELECT p.*,
                   c.id AS category_id,
                   c.name AS category_name,
                   b.id AS brand_id,
                   b.name AS brand_name,
                   pv.id AS default_variant_id,
                   pv.price AS min_price,
                   pi.image_url AS thumbnail
            FROM products p
            JOIN categories c ON p.category_id = c.id
            JOIN brands b ON p.brand_id = b.id
            LEFT JOIN product_variants pv
                ON pv.id = (
                    SELECT pv2.id
                    FROM product_variants pv2
                    WHERE pv2.product_id = p.id
                    ORDER BY pv2.price ASC, pv2.id ASC
                    LIMIT 1
                )
            LEFT JOIN product_images pi
                ON pi.id = (
                    SELECT pi2.id
                    FROM product_images pi2
                    WHERE pi2.product_id = p.id
                    ORDER BY pi2.is_primary DESC, pi2.id ASC
                    LIMIT 1
                )
            ORDER BY p.id DESC
            """;

    private static final String FIND_BY_ID = """
            SELECT p.*,
                   c.id AS category_id,
                   c.name AS category_name,
                   b.id AS brand_id,
                   b.name AS brand_name,
                   pv.id AS default_variant_id,
                   pv.price AS min_price,
                   pi.image_url AS thumbnail
            FROM products p
            JOIN categories c ON p.category_id = c.id
            JOIN brands b ON p.brand_id = b.id
            LEFT JOIN product_variants pv
                ON pv.id = (
                    SELECT pv2.id
                    FROM product_variants pv2
                    WHERE pv2.product_id = p.id
                    ORDER BY pv2.price ASC, pv2.id ASC
                    LIMIT 1
                )
            LEFT JOIN product_images pi
                ON pi.id = (
                    SELECT pi2.id
                    FROM product_images pi2
                    WHERE pi2.product_id = p.id
                    ORDER BY pi2.is_primary DESC, pi2.id ASC
                    LIMIT 1
                )
            WHERE p.id = ?
            """;

    private static final String INSERT = """
            INSERT INTO products(
                name,
                model,
                category_id,
                brand_id,
                description,
                status
            )
            VALUES (?, ?, ?, ?, ?, ?)
            """;

    private static final String UPDATE = """
            UPDATE products
            SET name = ?,
                model = ?,
                category_id = ?,
                brand_id = ?,
                description = ?,
                status = ?
            WHERE id = ?
            """;

    private static final String DELETE =
            "DELETE FROM products WHERE id = ?";

    private static final String FIND_DETAIL_BY_ID = """
        SELECT
            p.*,

            c.id AS category_id,
            c.name AS category_name,

            b.id AS brand_id,
            b.name AS brand_name,

            pi.image_url,
            pi.is_primary,

            pv.id AS variant_id,
            pv.ram,
            pv.storage,
            pv.price,
            pv.stock

        FROM products p

        LEFT JOIN categories c
            ON p.category_id = c.id

        LEFT JOIN brands b
            ON p.brand_id = b.id

        LEFT JOIN product_images pi
            ON p.id = pi.product_id

        LEFT JOIN product_variants pv
            ON p.id = pv.product_id

        WHERE p.id = ?

        ORDER BY pi.is_primary DESC, pi.id ASC, pv.price ASC, pv.id ASC
        """;
    @Override
    public List<Product> findAll() {

        List<Product> products = new ArrayList<>();

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(FIND_ALL);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name")
                );

                Brand brand = new Brand(
                        rs.getInt("brand_id"),
                        rs.getString("brand_name")
                );

                Product product = new Product();

                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setModel(rs.getString("model"));
                product.setDescription(rs.getString("description"));
                product.setStatus(rs.getBoolean("status"));
                product.setDefaultVariantId(rs.getInt("default_variant_id"));
                product.setMinPrice(rs.getBigDecimal("min_price"));
                product.setThumbnail(rs.getString("thumbnail"));

                product.setCategory(category);
                product.setBrand(brand);

                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public Optional<Product> findById(int id) {

        try (
                Connection connection = (Connection) DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(FIND_BY_ID)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Category category = new Category(
                            rs.getInt("category_id"),
                            rs.getString("category_name")
                    );

                    Brand brand = new Brand(
                            rs.getInt("brand_id"),
                            rs.getString("brand_name")
                    );

                    Product product = new Product();

                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setModel(rs.getString("model"));
                    product.setDescription(rs.getString("description"));
                    product.setStatus(rs.getBoolean("status"));
                    product.setDefaultVariantId(rs.getInt("default_variant_id"));
                    product.setMinPrice(rs.getBigDecimal("min_price"));
                    product.setThumbnail(rs.getString("thumbnail"));

                    product.setCategory(category);
                    product.setBrand(brand);

                    return Optional.of(product);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    @Override
    public void save(Product product) {

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(INSERT)
        ) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getModel());
            ps.setInt(3, product.getCategory().getId());
            ps.setInt(4, product.getBrand().getId());
            ps.setString(5, product.getDescription());
            ps.setBoolean(6, product.isStatus());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Product product) {

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(UPDATE)
        ) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getModel());
            ps.setInt(3, product.getCategory().getId());
            ps.setInt(4, product.getBrand().getId());
            ps.setString(5, product.getDescription());
            ps.setBoolean(6, product.isStatus());

            ps.setInt(7, product.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(DELETE)
        ) {

            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> searchProducts(String keyword, Integer brandId, Integer categoryId, int offset, int limit) {
        List<Product> products =
                new ArrayList<>();

        StringBuilder sql =
                new StringBuilder("""
            SELECT p.*,
                   c.id AS category_id,
                   c.name AS category_name,
                   b.id AS brand_id,
                   b.name AS brand_name,
                   pv.id AS default_variant_id,
                   pv.price AS min_price,
                   pi.image_url AS thumbnail
            FROM products p

            LEFT JOIN brands b
                ON p.brand_id = b.id

            LEFT JOIN categories c
                ON p.category_id = c.id

            LEFT JOIN product_variants pv
                ON pv.id = (
                    SELECT pv2.id
                    FROM product_variants pv2
                    WHERE pv2.product_id = p.id
                    ORDER BY pv2.price ASC, pv2.id ASC
                    LIMIT 1
                )

            LEFT JOIN product_images pi
                ON pi.id = (
                    SELECT pi2.id
                    FROM product_images pi2
                    WHERE pi2.product_id = p.id
                    ORDER BY pi2.is_primary DESC, pi2.id ASC
                    LIMIT 1
                )

            WHERE 1=1
            """);

        List<Object> params =
                new ArrayList<>();

        // KEYWORD

        if (keyword != null
                && !keyword.isBlank()) {

            sql.append("""
                AND (
                    p.name LIKE ?
                    OR p.model LIKE ?
                )
                """);

            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        // BRAND

        if (brandId != null) {

            sql.append("""
                AND p.brand_id = ?
                """);

            params.add(brandId);
        }

        // CATEGORY

        if (categoryId != null) {

            sql.append("""
                AND p.category_id = ?
                """);

            params.add(categoryId);
        }

        // PAGINATION

        sql.append("""
            ORDER BY p.id DESC
            LIMIT ?, ?
            """);

        params.add(offset);
        params.add(limit);

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                sql.toString()
                        )
        ) {

            for (int i = 0;
                 i < params.size();
                 i++) {

                ps.setObject(i + 1,
                        params.get(i));
            }

            try (ResultSet rs =
                         ps.executeQuery()) {

                while (rs.next()) {

                    Product product =
                            mapResultSetToProduct(rs);

                    products.add(product);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return products;
    }

    @Override
    public int countSearchProducts(String keyword, Integer brandId, Integer categoryId) {
        StringBuilder sql =
                new StringBuilder("""
            SELECT COUNT(DISTINCT p.id)

            FROM products p

            WHERE 1=1
            """);

        List<Object> params =
                new ArrayList<>();

        if (keyword != null
                && !keyword.isBlank()) {

            sql.append("""
                AND (
                    p.name LIKE ?
                    OR p.model LIKE ?
                )
                """);

            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if (brandId != null) {

            sql.append("""
                AND p.brand_id = ?
                """);

            params.add(brandId);
        }

        if (categoryId != null) {

            sql.append("""
                AND p.category_id = ?
                """);

            params.add(categoryId);
        }

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                sql.toString()
                        )
        ) {

            for (int i = 0;
                 i < params.size();
                 i++) {

                ps.setObject(i + 1,
                        params.get(i));
            }

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public Optional<Product> findDetailById(int id) {
        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(
                                FIND_DETAIL_BY_ID
                        )
        ) {

            ps.setInt(1, id);

            try (ResultSet rs =
                         ps.executeQuery()) {

                Product product = null;

                Map<String, ProductImage> imageMap =
                        new LinkedHashMap<>();

                Map<Integer, ProductVariant> variantMap =
                        new LinkedHashMap<>();

                while (rs.next()) {

                    // CREATE PRODUCT ONCE

                    if (product == null) {

                        product = new Product();

                        product.setId(
                                rs.getInt("id")
                        );

                        product.setName(
                                rs.getString("name")
                        );

                        product.setModel(
                                rs.getString("model")
                        );

                        product.setDescription(
                                rs.getString("description")
                        );

                        product.setStatus(
                                rs.getBoolean("status")
                        );

                        // CATEGORY

                        Category category =
                                new Category();

                        category.setId(
                                rs.getInt(
                                        "category_id"
                                )
                        );

                        category.setName(
                                rs.getString(
                                        "category_name"
                                )
                        );

                        product.setCategory(
                                category
                        );

                        // BRAND

                        Brand brand =
                                new Brand();

                        brand.setId(
                                rs.getInt(
                                        "brand_id"
                                )
                        );

                        brand.setName(
                                rs.getString(
                                        "brand_name"
                                )
                        );

                        product.setBrand(
                                brand
                        );
                    }

                    // IMAGE

                    String imageUrl =
                            rs.getString(
                                    "image_url"
                            );

                    if (imageUrl != null) {

                        ProductImage image =
                                new ProductImage();

                        image.setImageUrl(
                                imageUrl
                        );

                        image.setPrimary(
                                rs.getBoolean(
                                        "is_primary"
                                )
                        );

                        imageMap.putIfAbsent(imageUrl, image);
                    }

                    // VARIANT

                    int variantId =
                            rs.getInt(
                                    "variant_id"
                            );

                    if (variantId > 0) {

                        if (!variantMap.containsKey(variantId)) {
                            ProductVariant variant =
                                    new ProductVariant();

                            variant.setId(
                                    variantId
                            );

                            variant.setProductId(product.getId());

                            variant.setRam(
                                    rs.getString("ram")
                            );

                            variant.setStorage(
                                    rs.getString(
                                            "storage"
                                    )
                            );

                            variant.setPrice(
                                    rs.getBigDecimal(
                                            "price"
                                    )
                            );

                            variant.setStock(
                                    rs.getInt("stock")
                            );

                            variantMap.put(variantId, variant);
                        }
                    }
                }

                if (product != null) {

                    List<ProductImage> images =
                            new ArrayList<>(imageMap.values());

                    List<ProductVariant> variants =
                            new ArrayList<>(variantMap.values());

                    ProductImage primaryImage =
                            images.stream()
                                    .filter(ProductImage::isPrimary)
                                    .findFirst()
                                    .orElse(images.isEmpty() ? null : images.get(0));

                    ProductVariant defaultVariant =
                            variants.stream()
                                    .findFirst()
                                    .orElse(null);

                    if (primaryImage != null) {
                        product.setThumbnail(primaryImage.getImageUrl());
                    }

                    if (defaultVariant != null) {
                        product.setDefaultVariantId(defaultVariant.getId());
                        product.setMinPrice(defaultVariant.getPrice());
                    }

                    product.setVariants(variants);

                    return Optional.of(product);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return Optional.empty();
    }

    private Product mapResultSetToProduct(ResultSet rs)
            throws SQLException {

        Product product = new Product();

        product.setId(
                rs.getInt("id")
        );

        product.setName(
                rs.getString("name")
        );

        product.setModel(
                rs.getString("model")
        );

        product.setDescription(
                rs.getString("description")
        );

        product.setStatus(
                rs.getBoolean("status")
        );

        product.setDefaultVariantId(
                rs.getInt("default_variant_id")
        );

        product.setMinPrice(
                rs.getBigDecimal("min_price")
        );

        product.setThumbnail(
                rs.getString("thumbnail")
        );

        // CATEGORY

        Category category =
                new Category();

        category.setId(
                rs.getInt("category_id")
        );
        category.setName(
                rs.getString("category_name")
        );

        product.setCategory(category);

        // BRAND

        Brand brand =
                new Brand();

        brand.setId(
                rs.getInt("brand_id")
        );
        brand.setName(
                rs.getString("brand_name")
        );

        product.setBrand(brand);

        return product;
    }
}
