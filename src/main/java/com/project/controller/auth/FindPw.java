package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class FindPw {
    @GetMapping("/findPw")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findPw.jsp");
        return "layout/app";
    }
}

