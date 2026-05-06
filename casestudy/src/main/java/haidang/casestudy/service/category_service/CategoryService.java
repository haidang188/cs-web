package haidang.casestudy.service.category_service;

import haidang.casestudy.model.product_model.Category;
import haidang.casestudy.repository.product_repository.CategoryRepository;
import haidang.casestudy.repository.product_repository.ICategoryRepository;

import java.util.List;

public class CategoryService implements ICategoryService {

    private final ICategoryRepository
            categoryRepository;

    public CategoryService() {

        categoryRepository =
                new CategoryRepository();
    }

    @Override
    public List<Category> findAll() {

        return categoryRepository.findAll();
    }
}
