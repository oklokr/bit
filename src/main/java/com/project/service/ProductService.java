package com.project.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.CommonCodeDto;
import com.project.model.ProductDto;
import com.project.repository.ProductMapper;

@Service
public class ProductService {
    @Autowired 
    private ProductMapper productMapper;

    public List<CommonCodeDto> getCommonCode(String commonCode) {
        return productMapper.getCommonCode(commonCode);
    }

    public List<ProductDto> getProductList(String id, String productName, Timestamp productRegistrationDate, String categoryCode, int page, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productName", productName);
        params.put("productRegistrationDate", productRegistrationDate);
        params.put("categoryCode", categoryCode);
        params.put("offset", (page - 1) * size);
        params.put("limit", size);

        return productMapper.getProductList(params);
    }

    public int getProductCount(String id, String productName, Timestamp productRegistrationDate, String categoryCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productName", productName);
        params.put("productRegistrationDate", productRegistrationDate);
        params.put("categoryCode", categoryCode);
        return productMapper.getProductCount(params);
    }

    public ProductDto getProductInfo(int productId) {
        return productMapper.getProductInfo(productId);
    }

    public int setProductItem(int productId, String image, String productName, String categoryCode, String productDescription) {
        Map<String, Object> params = new HashMap<>();
        params.put("productId", productId);
        params.put("image", image);
        params.put("productName", productName);
        params.put("categoryCode", categoryCode);
        params.put("productDescription", productDescription);
        return productMapper.setProductItem(params);
    }

    public int insertProductItem(String memberId, String image, String productName, String categoryCode, String productDescription) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", memberId);
        params.put("image", image);
        params.put("productName", productName);
        params.put("categoryCode", categoryCode);
        params.put("productDescription", productDescription);
        return productMapper.insertProductItem(params);
    }
}