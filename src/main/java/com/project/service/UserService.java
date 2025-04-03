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

    public boolean authenticate(String id, String password) {
        throw new UnsupportedOperationException("Unimplemented method 'authenticate'");
    }
}
