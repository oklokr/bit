package com.project.controller.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class FindId {
    @GetMapping("/auth/findId")
    public String pageRender(Model model) {
        model.addAttribute("title", "아이디 찾기");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        model.addAttribute("defaultLayout", "false");
        return "layout/app";
    }
}

@RestController
class FindIdApiController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/auth/findId")
    public Map<String, Object> postMethodName(@RequestBody Map<String, String> requestBody) {
        String companyName = requestBody.get("companyName");
        String email = requestBody.get("email");
        String phoneNumber = requestBody.get("phoneNumber"); // 오타 수정
        String type = requestBody.get("type");
        UserDto userData = null;

        Map<String, Object> result = new HashMap<>();
        
        if (type.equals("email")) {
            userData = userService.findByCompanyNameAndEmail(companyName, email);
        } else if (type.equals("phone")) {
            userData = userService.findByCompanyNameAndPhone(companyName, phoneNumber);
        }
        if (userData == null) {
            result.put("data", null);
            return result;
        }
        result.put("data", userData.getId());
        return result;
    }
}