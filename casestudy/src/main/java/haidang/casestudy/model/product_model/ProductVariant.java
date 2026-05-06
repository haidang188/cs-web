package haidang.casestudy.model.product_model;

import java.math.BigDecimal;

public class ProductVariant {
    private int id;
    private int productId;
    private String ram;
    private String storage;
    private BigDecimal price;
    private int stock;
    private Product product;


    public ProductVariant() {
    }

    public ProductVariant(int id, int productId,
                          String ram, String storage,
                          BigDecimal price, int stock) {
        this.id = id;
        this.productId = productId;
        this.ram = ram;
        this.storage = storage;
        this.price = price;
        this.stock = stock;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
