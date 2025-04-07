package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
        HttpServletRequest request,
        Model model) {
        String result = userService.authenticate(id, password);

        if ("SUCCESS".equals(result)) {
            HttpSession session = request.getSession();
            UserDto user = userService.getUserById(id);
            userService.refreshSession(user, session);

            return "redirect:/main";
        } else {
            model.addAttribute("title", "Login Page");
            model.addAttribute("errorMessage", result);
            model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
            return "layout/app";
        }
    }

    @PostMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if(session != null) {
            String sessionId = session.getId();
            userService.clearSessionInfo(sessionId);
            session.invalidate();
        }
        return "redirect:/login";
    }
}