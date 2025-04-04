package com.project.repository;

import com.project.model.UserDto;

public interface UserMapper {
    public UserDto getUserById(String id);
    public UserDto findUserByEmail(String companyName, String email); // 추가
    public UserDto findUserByPhoneNumber(String companyName, String phoneNumber); // 추가
}
