package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.UserService;

@Controller
public class Login {
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
        return "layout/app";
    }

    @PostMapping("/login")
    public String loginProcess(@RequestParam String id,
                               @RequestParam String passwd,
                               Model model) {
        boolean isAuthenticated = userService.authenticate(id, passwd);

        if (isAuthenticated) {
            // 로그인 성공 시 메인 페이지로 리다이렉트
            return "redirect:/main";
        } else {
            // 로그인 실패 시 에러 메시지와 함께 로그인 페이지로 이동
            model.addAttribute("title", "Login Page");
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 틀렸습니다.");
            model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
            return "layout/app";
        }
    }
}