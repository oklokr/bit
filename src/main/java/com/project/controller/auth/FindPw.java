package com.project.controller.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.UserService;

@Controller
public class FindPw {
    @GetMapping("/auth/findPw")
    public String pageRender(Model model) {
        model.addAttribute("title", "비밀번호 찾기");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findPw.jsp");
        model.addAttribute("defaultLayout", "false");
        return "layout/app";
    }
}

@RestController
class FindPwApiController {
    @Autowired
    private UserService userService;
    
    @PostMapping("/api/auth/findPw")
    public Map<String, Object> postMethodName(@RequestBody Map<String, String> requestBody) {
        String id = requestBody.get("id");
        String email = requestBody.get("email");
        String phoneNumber = requestBody.get("phoneNumber");
        String type = requestBody.get("type");
        UserDto userData = null;
        String newPassword = userService.generateRandomPassword(15);
    
        Map<String, Object> result = new HashMap<>();
        
        if (type.equals("email")) {
            userData = userService.findByIdAndEmail(id, email);
        } else if (type.equals("phone")) {
            userData = userService.findByIdAndPhone(id, phoneNumber);
        }
        if (userData == null) {
            result.put("data", null);
            return result;
        }

        userService.updatePassword(userData.getId(), newPassword);
        result.put("data", newPassword);
        return result;
    }
}