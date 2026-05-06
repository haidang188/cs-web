package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.Category;

import java.util.List;
import java.util.Optional;

public interface ICategoryRepository {
    List<Category> findAll();

    Optional<Category> findById(int id);

    void save(Category category);

    void update(Category category);

    void delete(int id);
}
