package com.project.controller.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Inventory {
    @GetMapping("/mypage/inventory")
    public String getMethodName(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/mypage/inventory.jsp");
        return "layout/app";
    }
}
