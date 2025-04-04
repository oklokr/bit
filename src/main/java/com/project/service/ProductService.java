package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.CommonCodeDto;
import com.project.repository.ProductMapper;

@Service
public class ProductService {
    @Autowired 
    private ProductMapper productMapper;

    public List<CommonCodeDto> getCommonCode(String commonCode) {
        return productMapper.getCommonCode(commonCode);
    }
}