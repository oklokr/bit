package com.project.repository;

import com.project.model.UserDto;

public interface UserMapper {
    public UserDto getUserById(String id);
    // 이메일로 사용자 조회
    UserDto findByCompanyNameAndEmail(String companyName, String email);

    // 전화번호로 사용자 조회
    UserDto findByCompanyNameAndPhoneNumber(String companyName, String phoneNumber);
}
