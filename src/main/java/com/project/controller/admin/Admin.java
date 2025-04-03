package com.project.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Admin {
    @GetMapping("/admin")
    public String pageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/admin/admin.jsp");
        return "layout/app";
    }
}
