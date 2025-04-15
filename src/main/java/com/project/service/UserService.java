package com.project.service;

import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.model.InventoryDto;
import com.project.model.TermsDto;
import com.project.model.UserDto;
import com.project.repository.UserMapper;

import jakarta.servlet.http.HttpSession;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    // 회원정보 조회
    public UserDto getUserById(String id) {
        System.out.println("UserService - 조회할 ID: " + id);
        UserDto user = userMapper.getUserById(id);
        System.out.println("UserService - 조회된 UserDto: " + user);
        return user;
    }
    // 세션 토큰으로 회원정보 조회
    public UserDto getUserInfo(String sessionId) {
        UserDto userInfo = userMapper.getUserInfo(sessionId);
        return userInfo;
    }
    // 아이디 && 비밀번호 유효성 검사
    public int authenticate(String id, String password) {
        UserDto user = userMapper.getUserById(id);
        if (user == null || !user.getPassword().equals(password)) {
            return 0;
        }
        return 1;
    }

    // 세션 초기화
    public int clearSessionInfo(String sessionId) {
        int result = userMapper.clearSessionInfo(sessionId);
        return result;
    }
    // 세션 갱신
    public void refreshSession(UserDto user, HttpSession session) {
        Date now = new Date();
        Date newExpiryTime = new Date(now.getTime() + (30 * 60 * 1000));
        userMapper.updateSessionInfo(user.getId(), session.getId(), now, newExpiryTime);
        session.setAttribute("user", userMapper.getUserById(user.getId()));
    }
    
    // 사업자명 || (email, phoneNumber) 아이디찾기
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

    // 아이디 || (email, phoneNumber) 비밀번호 찾기
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

    // 비밀번호 변경
    public void updatePassword(String id, String randomPassword) {
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("password", randomPassword);
        userMapper.updatePassword(params);
    }
    // 아이디 중복체크
    public boolean isUserIdDuplicate(String id) {
        System.out.println("Checking duplicate ID: " + id);
        return userMapper.existsByUserId(id);
    }
    // 무작위 번호 생성
    public String generateRandomPassword(int length) {
        String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(charSet.length());
            password.append(charSet.charAt(randomIndex));
        }
        return password.toString();
    }

    // 회원가입
    @Transactional
    public int registerUserWithTerms(Map<String, Object> requestBody) {
        UserDto user = new UserDto();
        user.setId((String) requestBody.get("id"));
        user.setCompanyName((String) requestBody.get("companyName"));
        user.setPassword((String) requestBody.get("password"));
        user.setEmail((String) requestBody.get("email"));
        user.setBusinessNumber((String) requestBody.get("businessNumber"));
        user.setPhoneNumber((String) requestBody.get("phoneNumber"));
        user.setAddress((String) requestBody.get("address"));
        user.setDetailedAddress((String) requestBody.get("detailedAddress"));
        user.setPostalCode((String) requestBody.get("postalCode"));

        // 사용자 저장
        if (userMapper.insertUser(user) != 1) return 0;
        Object termsListObj = requestBody.get("termsList");
        if (!(termsListObj instanceof List)) return 0;

        List<?> termsList = (List<?>) termsListObj;
        for (Object itemObj : termsList) {
            if (!(itemObj instanceof Map)) return 0;
            Map<?, ?> item = (Map<?, ?>) itemObj;
            String termsType = String.valueOf(item.get("termsType"));
            String checkedStr = String.valueOf(item.get("checked"));
            int checked = "1".equals(checkedStr) ? 1 : 0;
            if (termsType != null && checked == 1) {
                List<TermsDto> terms = userMapper.getTermsList(termsType);
                for (TermsDto term : terms) {
                    userMapper.insertTermsAgreement(user.getId(), term.getTermsId());
                }
            }
        }
        return 1;
    }
    
    // 현재 id 비밀번호 확인
    public boolean verifyPassword(String sessionId, String inputPassword) {
        UserDto user = getUserInfo(sessionId);
        return user.getPassword().equals(inputPassword);
    }

    // 회원정보 수정
    public void updateUserInfo(UserDto userDto) {
        userMapper.updateUser(userDto);
    }

    // 회원탈퇴
    public void deleteUser(String id) {
        userMapper.modifyBoard(id);
        userMapper.modifyReply(id);
        userMapper.deleteUserById(id);
    }

    // 약관목록
    public List<TermsDto> getTermsList(String termsType) {
        return userMapper.getTermsList(termsType);
    }

    
    // 마이페이지 이벤토리
    public List<InventoryDto> getInventory(String id, String productName, int page, int size) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productName", productName);
        params.put("offset", (page - 1) * size);
        params.put("limit", size);

        return userMapper.getInventory(params);
    }
    public int getInventoryCount(String id, String productName) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productName", productName);
        return userMapper.getInventoryCount(params);
    }
    public int insertInventory(String id, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productId", productId);
        return userMapper.insertInventory(params);
    }
    public int updateInventory(String id, int productId, int stockQuantity) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productId", productId);
        params.put("stockQuantity", stockQuantity);
        return userMapper.updateInventory(params);
    }
    public int deleteInventory(String id, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("productId", productId);
        return userMapper.deleteInventory(params);
    }
}