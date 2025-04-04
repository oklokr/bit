package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.project.model.UserDto;
import com.project.repository.UserMapper;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public UserDto getUserById(String id ) {
        System.out.println("UserService - 조회할 ID: " + id);
        UserDto user = userMapper.getUserById(id);
        System.out.println("UserService - 조회된 UserDto: " + user);
        return user;
    }

    public String authenticate(String id, String password) {
        if (id == null || id.isEmpty()) {
            return "아이디를 입력해주세요.";
        }
        if (password == null || password.isEmpty()) {
            return "비밀번호를 입력해주세요.";
        }

        UserDto user = userMapper.getUserById(id);
        if (user == null) {
            return "존재하지 않는 아이디입니다.";
        }
        if (!user.getPassword().equals(password)) {
            return "비밀번호가 틀렸습니다.";
        }

        return "SUCCESS";
    }
    public UserDto findUserByEmail(String companyName, String email) {
        UserDto user = new UserDto();
        if (companyName.equals("테스트업체") && email.equals("test@example.com")) {
            user.setId("test123");
            user.setCompanyName(companyName);
            user.setEmail(email);
            return user;
        }
        return null;
    }

    public UserDto findUserByPhone(String companyName, String phone) {
        UserDto user = new UserDto();
        if (companyName.equals("테스트업체") && phone.equals("01012345678")) {
            user.setId("test123");
            user.setCompanyName(companyName);
            user.setPhoneNumber(phone);
            return user;
        }
        return null;
    }
}