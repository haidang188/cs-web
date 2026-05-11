package haidang.casestudy.service.brand_service;

import haidang.casestudy.model.product_model.Brand;
import haidang.casestudy.repository.product_repository.BrandRepository;
import haidang.casestudy.repository.product_repository.IBrandRepository;

import java.util.List;

public class BrandService implements IBrandService {
    private final IBrandRepository brandRepository;

    public BrandService() {
        brandRepository = new BrandRepository();
    }

    @Override
    public List<Brand> findAll() {
        return brandRepository.findAll();
    }
}
