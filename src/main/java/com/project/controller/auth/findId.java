package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
    public String findId(UserDto userDto, Model model) {
        // 서비스 호출하여 아이디 찾기
        FindIdResult result = userService.findId(userDto);

        // 결과를 모델에 담기
        if (result.isSuccess()) {
            model.addAttribute("message", "아이디 찾기 성공: " + result.getUserId());
        } else {
            model.addAttribute("message", "아이디를 찾을 수 없습니다.");
        }

        model.addAttribute("title", "아이디 찾기 결과");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findIdResult.jsp");
        return "layout/app";
    }
}
