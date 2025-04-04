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
        UserDto user = userMapper.findUserByEmail(companyName, email);
        System.out.println("findUserByEmail - companyName: " + companyName + ", email: " + email + ", result: " + (user != null ? user.getId() : "null"));
        return user;
    }

    public UserDto findUserByPhoneNumber(String companyName, String phoneNumber) {
        UserDto user = userMapper.findUserByPhoneNumber(companyName, phoneNumber);
        System.out.println("findUserByPhoneNumber - companyName: " + companyName + ", phoneNumber: " + phoneNumber + ", result: " + (user != null ? user.getId() : "null"));
        return user;
    }
}