package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class FindIdResult {
    @GetMapping("/findIdResult")
    public String pageRender(Model model) {
        model.addAttribute("title", "FindIdResult Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findIdResult.jsp");
        model.addAttribute("defaultLayout", "false");
        return "layout/app";
    }
} 