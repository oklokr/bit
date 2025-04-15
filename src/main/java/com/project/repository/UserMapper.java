package com.project.repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.project.model.InventoryDto;
import com.project.model.TermsDto;
import com.project.model.UserDto;

public interface UserMapper {
    UserDto getUserById(String id);

    void updateSessionInfo(@Param("id") String id, @Param("sessionId") String sessionId,
        @Param("lastAccessTime") Date lastAccessTime, @Param("expiryTime") Date expiryTime);

    int clearSessionInfo(@Param("sessionId") String sessionId);
    
    UserDto findByCompanyName(String companyName);

    UserDto findByCompanyNameAndEmail(Map<String, String> params);

    UserDto findByCompanyNameAndPhone(Map<String, String> params); // 이 메서드가 정의되어 있어야 합니다.

    UserDto findByIdAndEmail(Map<String, String> params);

    UserDto findByIdAndPhone(Map<String, String> params);

    void updatePassword(Map<String, String> params);

    UserDto getUserInfo(String sessionId);

    boolean existsByUserId(@Param("id") String id);

    boolean existsByEmail(String email); // 이메일 중복 확인 쿼리
    
    boolean existsByPhoneNumber(String phoneNumber); // 전화번호 중복 확인 쿼리

    int insertUser(UserDto user);

    int insertTermsAgreement(String userId, int termsId);

    public List<TermsDto> getTermsList(String termsType); // 약관 리스트 조회

    // 마이페이지 이벤토리 Query Mapper
    public List<InventoryDto> getInventory(Map<String, Object> param);
    public int getInventoryCount(Map<String, Object> param);
    public int insertInventory(Map<String, Object> param);
    public int updateInventory(Map<String, Object> param);
    public int deleteInventory(Map<String, Object> param);

    void updateUser(UserDto userDto);

    void deleteUserById(@Param("id") String id);

    void modifyBoard(String id);

    void modifyReply(String id);
    void forceDeleteInventory(int productId);
}

