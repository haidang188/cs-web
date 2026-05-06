package haidang.casestudy.service.product_service;

import haidang.casestudy.model.product_model.Product;
import haidang.casestudy.model.product_model.ProductImage;
import haidang.casestudy.model.product_model.ProductPageResponse;
import haidang.casestudy.model.product_model.ProductVariant;
import haidang.casestudy.repository.product_repository.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public class ProductService implements IProductService {

    private final IProductRepository productRepository;

    private final IProductVariantRepository
            variantRepository;

    private final IProductImageRepository
            imageRepository;

    public ProductService() {

        this.productRepository =
                new ProductRepository();

        this.variantRepository =
                new ProductVariantRepository();

        this.imageRepository =
                new ProductImageRepository();
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> products =
                productRepository.findAll();

        for (Product product : products) {

            List<ProductImage> images =
                    imageRepository.findByProductId(
                            product.getId()
                    );

            product.setImages(images);
        }

        return products;
    }

    @Override
    public Optional<Product> getProductById(int id) {
        Optional<Product> optionalProduct =
                productRepository.findById(id);

        if (optionalProduct.isPresent()) {

            Product product = optionalProduct.get();

            List<ProductVariant> variants =
                    variantRepository.findByProductId(
                            product.getId()
                    );

            List<ProductImage> images =
                    imageRepository.findByProductId(
                            product.getId()
                    );

            product.setVariants(variants);
            product.setImages(images);
        }

        return optionalProduct;
    }

    @Override
    public void createProduct(Product product) {

                int productId =
                                productRepository.save(product);

                if (productId <= 0) {

                        return;
                }

                BigDecimal price = product.getMinPrice();

                if (price != null) {

                        ProductVariant variant = new ProductVariant();
                        variant.setProductId(productId);
                        variant.setRam("Mặc định");
                        variant.setStorage("Mặc định");
                        variant.setPrice(price);
                        variant.setStock(999);

                        variantRepository.save(variant);
                }

                String imageUrl = product.getThumbnail();

                if (imageUrl != null && !imageUrl.isBlank()) {

                        ProductImage image = new ProductImage();
                        image.setProductId(productId);
                        image.setImageUrl(imageUrl);
                        image.setPrimary(true);

                        imageRepository.save(image);
                }
    }

    @Override
    public void updateProduct(Product product) {

                productRepository.update(product);

                BigDecimal price = product.getMinPrice();

                if (price != null) {

                        Optional<Product> optionalProduct =
                                        getProductById(product.getId());

                        if (optionalProduct.isPresent()) {

                                Product currentProduct = optionalProduct.get();

                                if (currentProduct.getVariants() != null
                                                && !currentProduct.getVariants().isEmpty()) {

                                        ProductVariant variant =
                                                        currentProduct.getVariants().get(0);

                                        variant.setPrice(price);
                                        variantRepository.update(variant);
                                } else {

                                        ProductVariant variant = new ProductVariant();
                                        variant.setProductId(product.getId());
                                        variant.setRam("Mặc định");
                                        variant.setStorage("Mặc định");
                                        variant.setPrice(price);
                                        variant.setStock(999);

                                        variantRepository.save(variant);
                                }

                                String imageUrl = product.getThumbnail();

                                if (imageUrl != null && !imageUrl.isBlank()) {

                                        if (currentProduct.getImages() != null
                                                        && !currentProduct.getImages().isEmpty()) {

                                                ProductImage image =
                                                                currentProduct.getImages().get(0);

                                                image.setImageUrl(imageUrl);

                                                imageRepository.delete(image.getId());
                                                imageRepository.save(image);
                                        } else {

                                                ProductImage image = new ProductImage();
                                                image.setProductId(product.getId());
                                                image.setImageUrl(imageUrl);
                                                image.setPrimary(true);

                                                imageRepository.save(image);
                                        }
                                }
                        }
                }
    }

    @Override
    public void deleteProduct(int id) {
        productRepository.delete(id);
    }

    @Override
    public ProductPageResponse searchProducts(String keyword, Integer brandId, Integer categoryId, int page, int size) {
        int offset =
                (page - 1) * size;

        List<Product> products =
                productRepository.searchProducts(
                        keyword,
                        brandId,
                        categoryId,
                        offset,
                        size
                );

        int totalItems =
                productRepository.countSearchProducts(
                        keyword,
                        brandId,
                        categoryId
                );

        int totalPages =
                (int) Math.ceil(
                        (double) totalItems / size
                );

        ProductPageResponse response =
                new ProductPageResponse();

        response.setProducts(products);

        response.setCurrentPage(page);

        response.setTotalItems(totalItems);

        response.setTotalPages(totalPages);

        return response;
    }

    @Override
    public Optional<Product> findDetailById(int id) {
        return productRepository
                .findDetailById(id);
    }
}
