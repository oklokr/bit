package com.project.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SubTerms {

    @GetMapping("/subTerms")
    public String showMainTerms(Model model) {
        // mainTerms.jsp 파일을 반환
        model.addAttribute("title", "SubTerms Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/subTerms.jsp");

        return "layout/app";
    }
}