package haidang.casestudy.service.product_service;

import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.model.product_model.ProductPageResponse;

import java.util.List;
import java.util.Optional;

public interface IProductService {
    List<Product> getAllProducts();

    Optional<Product> getProductById(int id);

    void createProduct(Product product);

    void updateProduct(Product product);

    void deleteProduct(int id);

    ProductPageResponse searchProducts(
            String keyword,
            Integer brandId,
            Integer categoryId,
            int page,
            int size
    );
    Optional<Product> findDetailById(int id);
}
