package com.project.controller.mypage;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Mypage {
    @Autowired
    private UserService userService;
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model){
        UserDto userDto = userService.getUserInfo(session.getId());
        model.addAttribute("userDto", userDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/mypage/mypage.jsp");
        return "layout/app";
    }
}

@RestController
class MypageApiController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/mypage/info")
    public Map<String, Object> getMypageInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserDto userInfo = userService.getUserInfo(session.getId());
        Map<String, Object> response = new HashMap<>();
        response.put("id", userInfo.getId());
        response.put("companyName", userInfo.getCompanyName());
        response.put("password", userInfo.getPassword());
        response.put("email", userInfo.getEmail());
        response.put("businessNumber", userInfo.getBusinessNumber());
        response.put("phoneNumber", userInfo.getPhoneNumber());
        response.put("address", userInfo.getAddress());
        response.put("detailedAddress", userInfo.getDetailedAddress());
        response.put("postalCode", userInfo.getPostalCode());
        response.put("memberType", userInfo.getMemberType());
        response.put("joinDate", userInfo.getJoinDate());
        response.put("sessionExpiryTime", userInfo.getSessionExpiryTime());
        return response;
    }

    @PostMapping("/api/mypage/verify-password")
    public Map<String, Object> verifyPassword(HttpServletRequest request, @RequestBody Map<String, String> requestBody) {
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        String inputPassword = requestBody.get("password");

        boolean isPasswordCorrect = userService.verifyPassword(sessionId, inputPassword);

        Map<String, Object> response = new HashMap<>();
        response.put("success", isPasswordCorrect);
        return response;
    }

    @PostMapping("/mypage/update")
    public ResponseEntity<Map<String, Object>> updateUserInfo(@RequestBody UserDto userDto, HttpSession session) {
        String sessionId = session.getId();
        UserDto currentUser = userService.getUserInfo(sessionId);

        if (currentUser == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "사용자 세션이 유효하지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }

        // 비밀번호 업데이트 처리
        if (userDto.getPassword() != null && !userDto.getPassword().equals("********")) {
            currentUser.setPassword(userDto.getPassword()); // 신규 비밀번호 설정
        }
        // 다른 사용자 정보 업데이트
        currentUser.setCompanyName(userDto.getCompanyName());
        currentUser.setEmail(userDto.getEmail());
        currentUser.setPhoneNumber(userDto.getPhoneNumber());
        currentUser.setBusinessNumber(userDto.getBusinessNumber());
        currentUser.setAddress(userDto.getAddress());
        currentUser.setDetailedAddress(userDto.getDetailedAddress());
        currentUser.setPostalCode(userDto.getPostalCode());
        currentUser.setMemberType(userDto.getMemberType());

        // 사용자 정보 업데이트
        userService.updateUserInfo(userDto);

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "사용자 정보가 성공적으로 업데이트되었습니다.");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/api/mypage/delete")
    public ResponseEntity<Map<String, Object>> deleteUser(HttpSession session) {
        String sessionId = session.getId();
        UserDto currentUser = userService.getUserInfo(sessionId);

        if (currentUser == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "사용자 세션이 유효하지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }

        userService.deleteUser(currentUser.getId());
        session.invalidate(); // 세션 무효화

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "회원 탈퇴가 완료되었습니다.");
        return ResponseEntity.ok(response);
    }
}