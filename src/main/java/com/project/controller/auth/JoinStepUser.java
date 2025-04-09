package com.project.controller.auth;

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
        System.out.println("Received ID: " + id); // 요청 데이터 확인

        if (id == null || id.trim().isEmpty()) {
            System.out.println("ID is empty or null");
            return ResponseEntity.badRequest().body(Map.of(
                "status", "error",
                "message", "아이디를 입력해주세요.",
                "isDuplicate", false
            ));
        }

        boolean isDuplicate = userService.isUserIdDuplicate(id);
        System.out.println("Is Duplicate: " + isDuplicate); // 중복 여부 확인

        return ResponseEntity.ok(Map.of(
            "status", "success",
            "message", isDuplicate ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.",
            "isDuplicate", isDuplicate
        ));
    }

    @PostMapping("/checkDuplicateEmail")
    public ResponseEntity<Map<String, Object>> checkDuplicateEmail(@RequestBody Map<String, String> request) {
        System.out.println("Request received: " + request); // 요청 데이터 확인
        String email = request.get("email");
        if (email == null || email.trim().isEmpty()) {
            System.out.println("Email is empty or null");
            return ResponseEntity.badRequest().body(Map.of(
                "isDuplicate", false,
                "message", "이메일을 입력해주세요."
            ));
        }

        boolean isDuplicate = userService.existsByEmail(email);
        return ResponseEntity.ok(Map.of(
            "isDuplicate", isDuplicate,
            "message", isDuplicate ? "이미 사용 중인 이메일입니다." : "사용 가능한 이메일입니다."
        ));
    }

    @PostMapping("/checkDuplicatePhone")
    public ResponseEntity<Map<String, Object>> checkDuplicatePhone(@RequestBody Map<String, String> request) {
        System.out.println("Request received: " + request); // 요청 데이터 확인

        String phoneNumber = request.get("phoneNumber");
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            System.out.println("Phone number is empty or null");
            return ResponseEntity.badRequest().body(Map.of(
                "isDuplicate", false,
                "message", "전화번호를 입력해주세요."
            ));
        }

        boolean isDuplicate = userService.existsByPhoneNumber(phoneNumber);
        System.out.println("Is Duplicate: " + isDuplicate); // 중복 여부 확인

        return ResponseEntity.ok(Map.of(
            "isDuplicate", isDuplicate,
            "message", isDuplicate ? "이미 사용 중인 전화번호입니다." : "사용 가능한 전화번호입니다."
        ));
    }
}