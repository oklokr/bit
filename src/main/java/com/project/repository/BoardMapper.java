package com.project.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
    public int getCount();
}
