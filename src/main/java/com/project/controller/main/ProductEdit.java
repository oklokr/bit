package com.project.controller.main;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.ProductDto;
import com.project.model.ProductEditRequestParam;
import com.project.model.UserDto;
import com.project.service.ProductService;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class ProductEdit {
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;

    @GetMapping("/main/productEdit")
    public String PageRender(@RequestParam(value="id", required = false) Integer id, Model model, HttpSession session) {
        String sessionId = session.getId();
        String userId = userService.getUserInfo(sessionId).getId();
        boolean isAdmin = userService.getUserInfo(sessionId).getMemberType() == 2;

        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/productEdit.jsp");
        model.addAttribute("commonCodes", productService.getCommonCode("CATEGORY_TYPE"));
        model.addAttribute("isAdmin", isAdmin);

        // id가 있을 경우 해당 상품 정보를 가져옴
        if (id != null) {
            ProductDto item = productService.getProductInfo(id);
            model.addAttribute("productInfo", item);
            if(!userId.equals(item.getId()) && !isAdmin) {
                return "error";
            }
        } else {
            model.addAttribute("productInfo", null); // 신규 등록일 경우
        }

        return "layout/app";
    }
}

@RestController
class ProductEditController {
    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @PostMapping("/api/main/productEdit")
    public Map<String, Object> productEdit(@RequestBody ProductEditRequestParam productEditRequestParam, HttpServletRequest request) {
        int result;
        HttpSession session = request.getSession();
        UserDto userDto = userService.getUserInfo(session.getId());
        if (productEditRequestParam.getProductId() == null) {
            // 신규 등록
            result = productService.insertProductItem(
                userDto.getId(),
                productEditRequestParam.getImage(),
                productEditRequestParam.getProductName(),
                productEditRequestParam.getCategoryCode(),
                productEditRequestParam.getProductDescription()
            );
        } else {
            // 수정
            result = productService.setProductItem(
                productEditRequestParam.getProductId(),
                productEditRequestParam.getImage(),
                productEditRequestParam.getProductName(),
                productEditRequestParam.getCategoryCode(),
                productEditRequestParam.getProductDescription()
            );
        }

        Map<String, Object> response = new HashMap<>();
        response.put("resultCode", result);
        return response;
    }
    
    @PostMapping("/api/main/productDelete")
    public Map<String, Object> postMethodName(@RequestBody Map<String, Object> requestBody) {
        int result = productService.deleteProduct((int) requestBody.get("productId"));
        Map<String, Object> response = new HashMap<>();
        response.put("resultCode", result);
        return response;
    }
    
}