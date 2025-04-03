package com.project.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class AdminDetail {
    @GetMapping("/admin/detail")
    public String getMethodName(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/admin/detail.jsp");
        return "layout/app";
    }
}
