package com.project.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.ProductService;

@Controller
public class ProductEdit {
    @Autowired
    private ProductService productService;

    @GetMapping("/main/productEdit")
    public String PageRender(@RequestParam(value="id", required = false) Integer id, Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/productEdit.jsp");
        model.addAttribute("commonCodes", productService.getCommonCode("CATEGORY_TYPE"));

        // id가 있을 경우 해당 상품 정보를 가져옴
        if (id != null) {
            model.addAttribute("productInfo", productService.getProductInfo(id));
        } else {
            model.addAttribute("productInfo", null); // 신규 등록일 경우
        }

        return "layout/app";
    }
}
