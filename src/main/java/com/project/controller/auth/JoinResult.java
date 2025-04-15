package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpSession;


@Controller
public class JoinResult {
    @Autowired
    private UserService userService;

    @GetMapping("/auth/joinResult")
    public String pageRender(Model model, HttpSession session) {
        UserDto userDto = userService.getUserInfo(session.getId());
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinResult.jsp");
        model.addAttribute("defaultLayout", "false");
        model.addAttribute("companyName", userDto.getCompanyName());
        return "layout/app";
    }
}