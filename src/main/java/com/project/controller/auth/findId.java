package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.UserDto;
import com.project.service.UserService;






@Controller
public class FindId {
    @Autowired
    private UserService userService; // UserService 의존성 주입

    @GetMapping("/findId")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }
    // POST 요청: 폼 제출 처리
    @PostMapping("/findId")
    public String processFindId(
            @RequestParam("company_name") String companyName,
            @RequestParam("certification") String certification,
            @RequestParam("cert_value") String certValue,
            Model model) {

        // 서버 측 유효성 검사
        if (companyName == null || companyName.trim().isEmpty() || 
            certification == null || certValue == null || certValue.trim().isEmpty()) {
            model.addAttribute("error", "모든 필드를 입력해주세요.");
            model.addAttribute("title", "아이디 찾기");
            model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
            return "layout/app";
        }

        UserDto user = null;
        if ("1".equals(certification)) { // 이메일 인증
            user = userService.findUserByEmail(companyName, certValue);
        } else if ("2".equals(certification)) { // 휴대폰 인증
            user = userService.findUserByPhone(companyName, certValue);
        }

        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("title", "아이디 찾기 결과");
            model.addAttribute("contentPage", "/WEB-INF/page/auth/findIdResult.jsp");
        } else {
            model.addAttribute("error", "일치하는 사용자가 없습니다.");
            model.addAttribute("title", "아이디 찾기");
            model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        }
        return "layout/app";
    }
} 

