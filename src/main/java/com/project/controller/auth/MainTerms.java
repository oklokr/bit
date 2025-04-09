package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainTerms {

    @GetMapping("/mainTerms")
    public String showMainTerms(Model model) {
        // mainTerms.jsp 파일을 반환
        model.addAttribute("title", "MainTerms Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/mainTerms.jsp");

        return "layout/app";
    }
}