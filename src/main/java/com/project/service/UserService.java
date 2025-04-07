package com.project.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.project.model.UserDto;
import com.project.repository.UserMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    // 아이디 찾기
    public UserDto getUserById(String id ) {
        System.out.println("UserService - 조회할 ID: " + id);
        UserDto user = userMapper.getUserById(id);
        System.out.println("UserService - 조회된 UserDto: " + user);
        return user;
    }
    // 아이디 && 비밀번호 유효성 검사
    public String authenticate(String id, String password) {
        UserDto user = userMapper.getUserById(id);
        if (user == null || !user.getPassword().equals(password)) {
            return "아이디 또는 비밀번호가 잘못되었습니다.";
        }
        return "SUCCESS";
    }
    // 로그아웃 로직
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String sessionId = session.getId();
            this.clearSessionInfo(sessionId);
            session.invalidate();
        }
        return "redirect:/login";
    }
    public void clearSessionInfo(String sessionId) {
        userMapper.clearSessionInfo(sessionId);
    }

    public void refreshSession(UserDto user, HttpSession session) {
        Date now = new Date();
        Date newExpiryTime = new Date(now.getTime() + (30 * 60 * 1000));
        userMapper.updateSessionInfo(user.getId(), session.getId(), now, newExpiryTime);
        session.setAttribute("user", userMapper.getUserById(user.getId()));
    }
    
    public UserDto findByCompanyName(String companyName) {
        System.out.println("UserService - 조회할 업체명: " + companyName);
        return userMapper.findByCompanyName(companyName);
    }
    public UserDto findByCompanyNameAndEmail(String companyName, String email) {
        Map<String, String> params = new HashMap<>();
        params.put("companyName", companyName);
        params.put("email", email);
        return userMapper.findByCompanyNameAndEmail(params);
    }
    public UserDto findByCompanyNameAndPhone(String companyName, String phoneNumber) {
        Map<String, String> params = new HashMap<>();
        params.put("companyName", companyName);
        params.put("phoneNumber", phoneNumber);
        return userMapper.findByCompanyNameAndPhone(params);
    }
    public UserDto findByIdAndEmail(String id, String email) {
        System.out.println("findByIdAndEmail 호출 - ID: " + id + ", Email: " + email);
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("email", email);
        UserDto user = userMapper.findByIdAndEmail(params);
        System.out.println("findByIdAndEmail 결과: " + user);
        return user;
    }
    
    public UserDto findByIdAndPhone(String id, String phoneNumber) {
        System.out.println("findByIdAndPhone 호출 - ID: " + id + ", Phone: " + phoneNumber);
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("phoneNumber", phoneNumber);
        UserDto user = userMapper.findByIdAndPhone(params);
        System.out.println("findByIdAndPhone 결과: " + user);
        return user;
    }
    public void updatePassword(String id, String randomPassword) {
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("password", randomPassword);
        userMapper.updatePassword(params);
    }
}