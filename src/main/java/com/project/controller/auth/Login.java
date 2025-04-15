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
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class Login {
    @GetMapping("/login")
    public String pageRender(Model model, HttpSession session, HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        UserDto user = (UserDto) session.getAttribute("user");
        if (user != null) return "redirect:/main";

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
    public int login(@RequestBody Map<String, String> requestBody, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String id = requestBody.get("id");
        String passwd = requestBody.get("passwd");
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
