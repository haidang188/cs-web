package haidang.casestudy.repository.product_repository;

import haidang.casestudy.model.product_model.Brand;

import java.util.List;
import java.util.Optional;

public interface IBrandRepository {
    List<Brand> findAll();

    Optional<Brand> findById(int id);

    void save(Brand brand);

    void update(Brand brand);

    void delete(int id);
}
