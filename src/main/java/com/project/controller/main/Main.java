package com.project.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Map<String, Object> getProductList(@RequestBody ProductRequestParam filterRequest) {
        List<ProductDto> productList = productService.getProductList(
            filterRequest.getId(), 
            filterRequest.getProductName(), 
            filterRequest.getProductRegistrationDate(), 
            filterRequest.getCategoryCode(), 
            filterRequest.getPage(), 
            filterRequest.getSize()
        );
        int totalCount = productService.getProductCount(
            filterRequest.getId(),
            filterRequest.getProductName(),
            filterRequest.getProductRegistrationDate(),
            filterRequest.getCategoryCode()
        );
        
        Map<String, Object> response = new HashMap<>();
        response.put("data", productList);
        response.put("totalCount", totalCount);
        return response;
    } 
}