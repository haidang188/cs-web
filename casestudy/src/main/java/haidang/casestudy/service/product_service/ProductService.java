package haidang.casestudy.service.product_service;

import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.model.product_model.ProductImage;
import haidang.casestudy.model.product_model.ProductPageResponse;
import haidang.casestudy.model.product_model.ProductVariant;
import haidang.casestudy.repository.product_repository.*;

import java.util.List;
import java.util.Optional;

public class ProductService implements IProductService {
    private final IProductRepository productRepository;
    private final IProductVariantRepository variantRepository;
    private final IProductImageRepository imageRepository;
    public ProductService() {
        this.productRepository = new ProductRepository();
        this.variantRepository = new ProductVariantRepository();
        this.imageRepository = new ProductImageRepository();
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> products = productRepository.findAll();
        for (Product product : products) {
            List<ProductImage> images = imageRepository.findByProductId(product.getId());
            product.setImages(images);
        }
        return products;
    }

    @Override
    public Optional<Product> getProductById(int id) {
        Optional<Product> optionalProduct = productRepository.findById(id);

        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            List<ProductVariant> variants = variantRepository.findByProductId(product.getId());
            List<ProductImage> images = imageRepository.findByProductId(product.getId());
            product.setVariants(variants);
            product.setImages(images);
        }
        return optionalProduct;
    }
    @Override
    public void createProduct(Product product) {
        productRepository.save(product);
    }

    @Override
    public void updateProduct(Product product) {
        productRepository.update(product);
    }

    @Override
    public void deleteProduct(int id) {
        productRepository.delete(id);
    }

    @Override
    public ProductPageResponse searchProducts(String keyword, Integer brandId, Integer categoryId, int page, int size) {
        int offset = (page - 1) * size;
        List<Product> products = productRepository.searchProducts(keyword, brandId, categoryId, offset, size);
        int totalItems = productRepository.countSearchProducts(keyword, brandId, categoryId);

        int totalPages = (int) Math.ceil((double) totalItems / size);

        ProductPageResponse response = new ProductPageResponse();
        response.setProducts(products);
        response.setCurrentPage(page);
        response.setTotalItems(totalItems);
        response.setTotalPages(totalPages);
        return response;
    }

    @Override
    public Optional<Product> findDetailById(int id) {
        return productRepository.findDetailById(id);
    }
}
