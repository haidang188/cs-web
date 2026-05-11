package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.Product;

import java.util.List;
import java.util.Optional;

public interface IProductRepository {
    List<Product> findAll();

    Optional<Product> findById(int id);

        int save(Product product);

    void update(Product product);

    void delete(int id);
    List<Product> searchProducts(
            String keyword,
            Integer brandId,
            Integer categoryId,
            int offset,
            int limit
    );

    int countSearchProducts(
            String keyword,
            Integer brandId,
            Integer categoryId
    );
    Optional<Product> findDetailById(int id);
}
