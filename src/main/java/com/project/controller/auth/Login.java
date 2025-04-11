package com.project.controller.auth;

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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Login {
    @GetMapping("/login")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/login.jsp");
        model.addAttribute("defaultLayout", "false");
        return "layout/app";
    }
}

@RestController
class LoginRestController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/login")
    public int login(@RequestBody Map<String, String> RequestBody, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String id = RequestBody.get("id");
        String passwd = RequestBody.get("passwd");
        int result = userService.authenticate(id, passwd);
        if(result == 1) {
            UserDto user = userService.getUserById(id);
            userService.refreshSession(user, session);
            return 1;
        } else {
            return 0;
        }
    }

    @PostMapping("/api/logout")
    public int logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if(session != null) {
            String sessionId = session.getId();
            int result = userService.clearSessionInfo(sessionId);
            session.invalidate();

            return result;
        }
        return 0;
    }
}
