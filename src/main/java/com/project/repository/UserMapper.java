package com.project.repository;

import com.project.model.UserDto;
import java.util.Map;

public interface UserMapper {
    UserDto getUserById(String id);

    // 이메일로 사용자 조회
    UserDto findByCompanyNameAndEmail(Map<String, Object> params);

    // 전화번호로 사용자 조회
    UserDto findByCompanyNameAndPhoneNumber(Map<String, Object> params);
}