package com.project.controller.example;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Example {
    @GetMapping("/example")
    public String pageRender(Model model) {
        model.addAttribute("contentPage", "/WEB-INF/page/example/index.jsp");
        return "layout/app";
    }
}
