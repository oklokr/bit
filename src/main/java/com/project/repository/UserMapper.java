package com.project.repository;

import com.project.model.UserDto;

public interface UserMapper {
    UserDto getUserById(String id);
    
    UserDto findByCompanyName(String companyName);
}

