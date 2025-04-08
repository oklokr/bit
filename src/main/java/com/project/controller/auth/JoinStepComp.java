package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class JoinStepComp {
    @GetMapping("/joinStepComp")
    public String pageRender(Model model) {
        model.addAttribute("title", "JoinStepComp Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepComp.jsp");
        return "layout/app";
    }
}