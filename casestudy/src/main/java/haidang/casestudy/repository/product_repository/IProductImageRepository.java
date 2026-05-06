package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.ProductImage;

import java.util.List;

public interface IProductImageRepository {
    List<ProductImage> findByProductId(int productId);

    ProductImage findPrimaryImage(int productId);

    void save(ProductImage image);

    void delete(int id);
}
