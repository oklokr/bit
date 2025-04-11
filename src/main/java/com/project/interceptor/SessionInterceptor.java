package com.project.interceptor;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SessionInterceptor implements HandlerInterceptor {
    
    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull Object handler) throws Exception {
        System.out.println("Request URI: " + request.getRequestURI());
        String requestURI = request.getRequestURI();

        // 로그인 API는 세션 검사 제외
        if ("/api/login".equals(requestURI)) {
            return true;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/login");
            return false;
        }

        UserDto user = (UserDto) session.getAttribute("user");
        if (user.getSessionExpiryTime().before(new Date())) {
            session.invalidate();
            response.sendRedirect("/login");
            return false;
        }

        userService.refreshSession(user, session);
        return true;
    }
}
