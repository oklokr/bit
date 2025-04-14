package com.project.controller.auth;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class Join {
    @Autowired
    private UserService userService;

    @GetMapping("/auth/join")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/join.jsp");
        model.addAttribute("defaultLayout", "false");
        model.addAttribute("termsList", userService.getTermsList(null));
        return "layout/app";
    }
}

@RestController
class JoinRestController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/auth/join")
    public int postMethodName(@RequestBody Map<String, Object> requestBody) {
        return userService.registerUserWithTerms(requestBody);
    }
}