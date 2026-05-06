package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.ProductVariant;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface IProductVariantRepository {
    List<ProductVariant> findByProductId(int productId);

    Optional<ProductVariant> findById(int id);

    void save(ProductVariant variant);

    void update(ProductVariant variant);

    void delete(int id);

}
