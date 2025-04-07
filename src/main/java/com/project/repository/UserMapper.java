package com.project.repository;

import java.util.Map;

import com.project.model.UserDto;

public interface UserMapper {
    UserDto getUserById(String id);
    
    UserDto findByCompanyName(String companyName);

    UserDto findByCompanyNameAndEmail(Map<String, String> params);
}

