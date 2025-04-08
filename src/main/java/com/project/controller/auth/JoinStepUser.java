package com.project.controller.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.UserService;

@Controller
@RequestMapping("/joinStepUser")
public class JoinStepUser {
    @Autowired
    private UserService userService;

    // 페이지 렌더링
    @GetMapping
    public String pageRender(Model model) {
        model.addAttribute("title", "JoinStepUser Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepUser.jsp");
        return "layout/app";
    }

    @PostMapping("/checkDuplicateId")
    public ResponseEntity<Map<String, Object>> checkDuplicateId(@RequestBody Map<String, String> request) {
        String id = request.get("id");
        System.out.println("Received ID: " + id); // 디버깅 로그 추가
    
        if (id == null || id.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "아이디를 입력해주세요.",
                "isDuplicate", false
            ));
        }
    
        boolean isDuplicate = userService.isUserIdDuplicate(id);
        System.out.println("Is Duplicate: " + isDuplicate); // 디버깅 로그 추가
    
        return ResponseEntity.ok(Map.of(
            "status", "success",
            "message", isDuplicate ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.",
            "isDuplicate", isDuplicate
        ));
    } 
    @PostMapping("/checkDuplicate")
    public ResponseEntity<Map<String, Boolean>> checkDuplicate(@RequestBody Map<String, String> request) {
    String email = request.get("email");
    String phoneNumber = request.get("phoneNumber");

    boolean isDuplicate = false;

    // 이메일과 전화번호 중복 여부 확인 로직
    if (userService.existsByEmail(email) || userService.existsByPhoneNumber(phoneNumber)) {
        isDuplicate = true;
    }

    Map<String, Boolean> response = new HashMap<>();
    response.put("isDuplicate", isDuplicate);
    return ResponseEntity.ok(response);
}
}