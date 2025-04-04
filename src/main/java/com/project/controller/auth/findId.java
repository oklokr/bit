package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.model.UserDto;
import com.project.service.UserService;




@Controller
public class FindId {
    @Autowired
    private UserService userService;

    @GetMapping("/findId")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }
    // 아이디 찾기 처리
    @PostMapping("/findId")
    public String findId(@RequestParam String company_name, 
                         @RequestParam String certification, 
                         @RequestParam String cert_value, 
                         Model model) {
        // 인증 방식에 따라 DB에서 아이디 조회
        UserDto userDto = userService.findUserByCertification(company_name, certification, cert_value);

        if (userDto != null) {
            model.addAttribute("userId", userDto.getId());
            model.addAttribute("message", "아이디가 성공적으로 조회되었습니다.");
        } else {
            model.addAttribute("errorMessage", "해당 정보로 아이디를 찾을 수 없습니다.");
        }
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findIdResult.jsp");
        return "layout/app";
    }
} 

