package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FindIdResult {

    @GetMapping("/findIdResult")
    public String showResult(Model model) {
        // RedirectAttributes로 전달된 user 객체는 모델에 자동 추가됨
        if (!model.containsAttribute("user")) {
            // user가 없으면 findId로 리다이렉트
            return "redirect:/findId";
        }
        model.addAttribute("title", "아이디 찾기 결과");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findIdResult.jsp");
        return "layout/app";
    }
}