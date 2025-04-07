package com.project.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductEdit {
    @GetMapping("/main/productEdit")
    public String PageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/productEdit.jsp");
        return "layout/app";
    }
}
