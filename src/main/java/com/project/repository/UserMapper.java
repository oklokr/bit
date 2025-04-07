package com.project.repository;

import java.util.Map;

import com.project.model.UserDto;

public interface UserMapper {
    UserDto getUserById(String id);
    
    UserDto findByCompanyName(String companyName);

    UserDto findByCompanyNameAndEmail(Map<String, String> params);

    UserDto findByCompanyNameAndPhone(Map<String, String> params); // 이 메서드가 정의되어 있어야 합니다.

    UserDto findByIdAndEmail(Map<String, String> params);

    UserDto findByIdAndPhone(Map<String, String> params);

    void updatePassword(Map<String, String> params);
}

