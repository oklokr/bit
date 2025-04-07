package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.service.UserService;

@Controller
public class Login {
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
        model.addAttribute("defaultLayout", "false");
        return "layout/app";
    }

    @PostMapping("/login")
    public String loginProcess(@RequestParam String id,
                               @RequestParam String password,
                               Model model) {
        String result = userService.authenticate(id, password);

        if ("SUCCESS".equals(result)) {
            return "redirect:/main";
        } else {
            model.addAttribute("title", "Login Page");
            model.addAttribute("errorMessage", result);
            model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
            return "layout/app";
        }
    }
}