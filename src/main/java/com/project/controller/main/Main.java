package com.project.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.project.model.UserDto;
import com.project.service.UserService;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
public class Main {
    @Autowired
    private UserService userService;

    @GetMapping("/main")
    public String pageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/main/main.jsp");
        return "layout/app";
    }

    // RESTful API 처리
    @PostMapping("/api/user")
    @ResponseBody
    public UserDto getUserById(@RequestBody UserDto userDto) {
        System.out.println("요청 받은 UserDto: " + userDto);
        if (userDto.getId() == null) {
            throw new IllegalArgumentException("ID가 null입니다.");
        }
        UserDto result = userService.getUserById(userDto.getId());
        System.out.println("조회된 UserDto: " + result);
        return result;
    }
}
