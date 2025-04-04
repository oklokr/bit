package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.controller.auth.FindIdResult;
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
    // 아이디 찾기 로직
    public FindIdResult findId(UserDto userDto) {
        // 실제로는 DB에서 해당 정보를 조회하는 로직을 작성해야 함
        // 예시: 회사명과 인증값이 특정 값일 때 아이디를 반환
        if ("exampleCompany".equals(userDto.getCompanyName()) &&
            "exampleEmail@example.com".equals(userDto.getCertificationValue())) {
            // 아이디 찾기 성공
            return new FindIdResult(true, "exampleUserId");
        }
        // 아이디를 찾을 수 없는 경우
        return new FindIdResult(false, null);
    }
}