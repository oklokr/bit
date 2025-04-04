package com.project.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.model.CommonCodeDto;

@Mapper
public interface ProductMapper {
    public List<CommonCodeDto> getCommonCode(String commonCode);
}