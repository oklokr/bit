package com.project.controller.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.ProductDto;
import com.project.model.ProductRequestParam;
import com.project.service.ProductService;

@Controller
public class Main {
    @Autowired
    private ProductService productService;

    @GetMapping("/main")
    public String pageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/main.jsp");
        model.addAttribute("commonCodes", productService.getCommonCode("CATEGORY_TYPE"));
        return "layout/app";
    }
}
@RestController
class ProductApiController {
    @Autowired
    private ProductService productService;
    @PostMapping("/api/main/product")
    public List<ProductDto> getProductList(@RequestBody ProductRequestParam filterRequest) {
        return productService.getProductList(
            filterRequest.getId(), 
            filterRequest.getProductName(), 
            filterRequest.getProductRegistrationDate(), 
            filterRequest.getCategoryCode(), 
            filterRequest.getPage(), 
            filterRequest.getSize()
        );
    }
}