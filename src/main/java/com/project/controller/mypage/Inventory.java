package com.project.controller.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.InventoryDto;
import com.project.model.InventroyRequestParam;
import com.project.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class Inventory {
    @GetMapping("/mypage/inventory")
    public String pageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/mypage/inventory.jsp");
        return "layout/app";
    }
}

@RestController
class InventoryApiController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/mypage/inventory")
    public Map<String, Object> inventoryList(@RequestBody InventroyRequestParam filterRequest, HttpSession session) {
        String sessionId = session.getId();
        String id = userService.getUserInfo(sessionId).getId();

        List<InventoryDto> inventoryList = userService.getInventory(
            id, 
            filterRequest.getProductName(), 
            filterRequest.getPage(), 
            filterRequest.getSize()
        );
        int totalCount = userService.getInventoryCount(
            id,
            filterRequest.getProductName()
        );
        
        Map<String, Object> response = new HashMap<>();
        response.put("data", inventoryList);
        response.put("totalCount", totalCount);
        return response;
    }

    @PostMapping("/api/mypage/setInventory")
    public int addInventory(@RequestBody Map<String, Object> request, HttpSession session) {
        String sessionId = session.getId();
        String id = userService.getUserInfo(sessionId).getId();
        int productId = (int) request.get("productId");

        return userService.insertInventory(id, productId);
    }

    @PostMapping("/api/mypage/updateInventory")
    public int updateInventory(@RequestBody List<Map<String, Object>> updates, HttpSession session) {
        String sessionId = session.getId();
        String id = userService.getUserInfo(sessionId).getId();
        
        int result = 0;
        for (Map<String, Object> update : updates) {
            int productId = Integer.parseInt(update.get("productId").toString());
            int stockQuantity = Integer.parseInt(update.get("stockQuantity").toString());
            result += userService.updateInventory(id, productId, stockQuantity);
        }
        return result;
    }

    @PostMapping("/api/mypage/deleteInventory")
    public int deleteInventory(@RequestBody List<String> productIds, HttpSession session) {
        String sessionId = session.getId();
        String id = userService.getUserInfo(sessionId).getId();
        int result = 0;
        for (String productId : productIds) {
            result += userService.deleteInventory(id, Integer.parseInt(productId));
        }
        return result;
    }
}