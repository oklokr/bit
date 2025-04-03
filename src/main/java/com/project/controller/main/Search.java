package com.project.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Search {
    @GetMapping("/main/search")
    public String getMethodName(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/search.jsp");
        return "layout/app";
    }
}
