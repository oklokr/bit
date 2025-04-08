package com.project.repository;

import java.util.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.project.model.UserDto;

public interface UserMapper {
    UserDto getUserById(String id);

    void updateSessionInfo(@Param("id") String id, @Param("sessionId") String sessionId,
        @Param("lastAccessTime") Date lastAccessTime, @Param("expiryTime") Date expiryTime);

    void clearSessionInfo(@Param("sessionId") String sessionId);
    
    UserDto findBySessionId(@Param("sessionId") String sessionId);
    
    UserDto findByCompanyName(String companyName);

    UserDto findByCompanyNameAndEmail(Map<String, String> params);

    UserDto findByCompanyNameAndPhone(Map<String, String> params); // 이 메서드가 정의되어 있어야 합니다.

    UserDto findByIdAndEmail(Map<String, String> params);

    UserDto findByIdAndPhone(Map<String, String> params);

    void updatePassword(Map<String, String> params);

    UserDto getUserInfo(String sessionId);
}

