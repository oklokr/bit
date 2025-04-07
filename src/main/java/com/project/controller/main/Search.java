package com.project.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.service.ProductService;

@Controller
public class Search {
    @Autowired
    private ProductService productService;
    @GetMapping("/main/search")
    public String PageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/search.jsp");
        model.addAttribute("commonCodes", productService.getCommonCode("CATEGORY_TYPE"));
        return "layout/app";
    }
}
