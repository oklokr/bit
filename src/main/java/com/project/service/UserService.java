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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

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

    // 회원정보 조회
    public UserDto getUserById(String id) {
        System.out.println("UserService - 조회할 ID: " + id);
        UserDto user = userMapper.getUserById(id);
        System.out.println("UserService - 조회된 UserDto: " + user);
        return user;
    }
    // 아이디 && 비밀번호 유효성 검사
    public int authenticate(String id, String password) {
        UserDto user = userMapper.getUserById(id);
        if (user == null || !user.getPassword().equals(password)) {
            return 0;
        }
        return 1;
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
    public int clearSessionInfo(String sessionId) {
        int result = userMapper.clearSessionInfo(sessionId);
        return result;
    }
    public void refreshSession(UserDto user, HttpSession session) {
        Date now = new Date();
        Date newExpiryTime = new Date(now.getTime() + (30 * 60 * 1000));
        userMapper.updateSessionInfo(user.getId(), session.getId(), now, newExpiryTime);
        session.setAttribute("user", userMapper.getUserById(user.getId()));
    }
    
    // 세션 토큰으로 회원정보 조회
    public UserDto getUserInfo(String sessionId) {
        UserDto userInfo = userMapper.getUserInfo(sessionId);
        return userInfo;
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
    public boolean isUserIdDuplicate(String id) {
        System.out.println("Checking duplicate ID: " + id);
        return userMapper.existsByUserId(id);
    }
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

    public boolean existsByEmail(String email) {
        System.out.println("Checking email in database: " + email); // 로그 추가
        boolean result = userMapper.existsByEmail(email);
        System.out.println("Email exists: " + result); // 로그 추가
        return result;
    }
    
    public boolean existsByPhoneNumber(String phoneNumber) {
        System.out.println("Checking phone number in database: " + phoneNumber); // 로그 추가
        boolean result = userMapper.existsByPhoneNumber(phoneNumber);
        System.out.println("Phone number exists: " + result); // 로그 추가
        return result;
    }
    public boolean validateBusinessNumber(String businessNumber) {
        // 사업자 번호 형식: 123-45-67890
        String regex = "^[0-9]{3}-[0-9]{2}-[0-9]{5}$";
        if (businessNumber == null || !businessNumber.matches(regex)) {
            return false;
        }

        // 추가적인 유효성 검사 로직 (예: 사업자 번호의 체크섬 계산)
        // 여기서는 간단히 형식만 검사합니다.
        return true;
    }

    public int saveUser(UserDto user) {
        return userMapper.insertUser(user); // UserMapper를 통해 DB에 저장
    }

    public int saveTermsAgreement(String userId, int termsId) {
        return userMapper.insertTermsAgreement(userId, termsId);
    }

    public boolean verifyPassword(String sessionId, String inputPassword) {
        UserDto user = getUserInfo(sessionId);
        return user.getPassword().equals(inputPassword);
    }

    public boolean isEmailDuplicate(String email) {
        return userMapper.existsByEmail(email);
    }
    
    public boolean isPhoneNumberDuplicate(String phoneNumber) {
        return userMapper.existsByPhoneNumber(phoneNumber);
    }

    public void updateUserInfo(UserDto userDto) {
        userMapper.updateUser(userDto);
    }

    public void deleteUser(String id) {
        userMapper.deleteUserById(id);
        userMapper.modifyBoard(id);
        userMapper.modifyReply(id);
    }

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