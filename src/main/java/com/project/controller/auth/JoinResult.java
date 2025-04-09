package com.project.controller.auth;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.UserDto;


@Controller
public class JoinResult {

    @GetMapping("/joinResult")
public String pageRender(Model model) {
    // FlashAttribute로 전달된 데이터 확인
    if (!model.containsAttribute("user")) {
        // 데이터가 없으면 에러 페이지로 이동하거나 기본 처리
        return "redirect:/error";
    }

    // 전달된 UserDto 객체에서 companyName을 추출하여 추가
    Object userObj = model.getAttribute("user");
    if (userObj instanceof UserDto) {
        UserDto user = (UserDto) userObj;
        model.addAttribute("companyName", user.getCompanyName());
    } else {
        // user 객체가 없거나 잘못된 경우 에러 처리
        return "redirect:/error";
    }

    model.addAttribute("title", "JoinResult Page");
    model.addAttribute("contentPage", "/WEB-INF/page/auth/joinResult.jsp");
    return "layout/app";
}
    @PostMapping("/joinResult")
    public String handleJoinStepComp(@RequestParam Map<String, String> params, Model model) {
        System.out.println("Received params: " + params);

        model.addAttribute("title", "JoinResult Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinResult.jsp");
        
        return "layout/app";
    }
}