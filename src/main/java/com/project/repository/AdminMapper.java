package com.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.model.UserDto;

@Mapper
public interface AdminMapper {
    public int getCount(String searchName);
    public List<UserDto > getUsers(Map<String, Object> map);
    public int countAll();
    public int countByName(String searchName);


}
