package haidang.casestudy.model.product_model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String model;
    private String description;
    private boolean status;
    private Timestamp createdAt;

    private Category category;
    private Brand brand;

    private List<ProductVariant> variants;
    private List<ProductImage> images;

    private String thumbnail;

    private BigDecimal minPrice;

    private int defaultVariantId;

    public Product() {
    }

    public Product(int id, String name, String model, String description, boolean status, Timestamp createdAt, Category category, Brand brand) {
        this.id = id;
        this.name = name;
        this.model = model;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.category = category;
        this.brand = brand;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public String getModel() {
        return model;
    }

    public String getDescription() {
        return description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Category getCategory() {
        return category;
    }

    public Brand getBrand() {
        return brand;
    }

    public List<ProductVariant> getVariants() {
        return variants;
    }

    public List<ProductImage> getImages() {
        return images;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public void setDescription(String description) {
        this.description = description;
    }



    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public void setVariants(List<ProductVariant> variants) {
        this.variants = variants;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }

    public int getDefaultVariantId() {
        return defaultVariantId;
    }

    public void setDefaultVariantId(int defaultVariantId) {
        this.defaultVariantId = defaultVariantId;
    }
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", model='" + model + '\'' +
                ", minPrice=" + minPrice +
                '}';
    }
    public String getThumbnailOrDefault() {

        if (thumbnail == null
                || thumbnail.isBlank()) {

            return "https://placehold.co/600x420/f8fafc/64748b?text=No+Image";
        }

        return thumbnail;
    }
    public boolean isActive() {
        return status;
    }
}
