package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class JoinStepUser {
    @GetMapping("/joinStepUser")
    public String pageRender(Model model) {
        model.addAttribute("title", "JoinStepUser Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepUser.jsp");
        return "layout/app";
    }
}