package com.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.model.CommonCodeDto;
import com.project.model.ProductDto;

@Mapper
public interface ProductMapper {
    public List<CommonCodeDto> getCommonCode(String commonCode);
    public List<ProductDto> getProductList(Map<String, Object> params);
    public int getProductCount(Map<String, Object> params);
}