package com.project.repository;

import com.project.model.UserDto;

public interface UserMapper {
    public UserDto getUserById(String id);
}
