package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.model.UserDto;
import com.project.repository.AdminMapper;

@Service
public class AdminService {
    //수정필요
    @Autowired
    private AdminMapper userMapper;

    public int getCount(String searchName) {
        if (searchName == null || searchName.isBlank()) {
            return userMapper.countAll();
        } else {
            return userMapper.countByName(searchName);
        }
    }

    public List<UserDto> getUsers(Map<String, Object> map){
        return userMapper.getUsers(map);
    }

    public int deleteUser(String id){
        return userMapper.deleteUser(id);
    }

    public int changeMemberType(Map<String, Object> map){
        return userMapper.changeMemberType(map);
    }
}
