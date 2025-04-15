package com.project.controller.auth;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class Join {
    @Autowired
    private UserService userService;

    @GetMapping("/auth/join")
    public String pageRender(Model model, HttpSession session, HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        UserDto user = (UserDto) session.getAttribute("user");
        System.out.println(user);

        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/join.jsp");
        model.addAttribute("defaultLayout", "false");
        model.addAttribute("termsList", userService.getTermsList(null));
        return "layout/app";
    }
}

@RestController
class JoinRestController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/auth/join")
    public int join(@RequestBody Map<String, Object> requestBody) {
        return userService.registerUserWithTerms(requestBody);
    }

    @PostMapping("/api/auth/checkDuplicateId")
    public ResponseEntity<Map<String, Object>> checkDuplicateId(@RequestBody Map<String, String> request) {
        String id = request.get("id");

        if (id == null || id.trim().isEmpty()) {
            return ResponseEntity.ok(Map.of(
                "status", "error",
                "message", "아이디를 입력해주세요.",
                "isDuplicate", false
            ));
        }
        boolean isDuplicate = userService.isUserIdDuplicate(id);
        return ResponseEntity.ok(Map.of(
            "status", "success",
            "message", isDuplicate ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다.",
            "isDuplicate", isDuplicate
        ));
    }
}