package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class FindPwResult {
    @GetMapping("/findPwResult")
    public String pageRender(Model model) {
        model.addAttribute("title", "FindPwResult Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findPwResult.jsp");
        return "layout/app";
    }
}
