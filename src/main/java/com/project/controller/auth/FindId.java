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
    private UserService userService;

    @GetMapping("/findId")
    public String pageRender(Model model) {
        model.addAttribute("title", "아이디 찾기");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }

    @PostMapping("/findId")
    public String findId(@RequestParam String company_name,
                         @RequestParam String cert_value,
                         @RequestParam(required = false) String email,
                         @RequestParam(required = false) String tel1,
                         @RequestParam(required = false) String tel2,
                         @RequestParam(required = false) String tel3,
                         Model model) {
        System.out.println("회사명: " + company_name);
        System.out.println("인증 방법: " + cert_value);

        if ("1".equals(cert_value)) { // 이메일 인증
            if (email != null && !email.isEmpty()) {
                UserDto user = userService.findByCompanyNameAndEmail(company_name, email);
                System.out.println("조회된 사용자: " + user);
                if (user != null) {
                    model.addAttribute("userId", user.getId());
                    return "auth/findidResult";
                } else {
                    model.addAttribute("errorMessage", "일치하는 정보가 없습니다.");
                    return "auth/findidResult";
                }
            } else {
                model.addAttribute("errorMessage", "이메일을 입력해 주세요.");
                return "auth/findidResult";
            }
        } else if ("2".equals(cert_value)) { // 휴대폰 인증
            if (tel1 != null && !tel1.isEmpty() &&
                tel2 != null && !tel2.isEmpty() &&
                tel3 != null && !tel3.isEmpty()) {
                String phoneNumber = tel1 + "-" + tel2 + "-" + tel3;
                UserDto user = userService.findByCompanyNameAndPhoneNumber(company_name, phoneNumber);
                System.out.println("조회된 사용자: " + user);
                if (user != null) {
                    model.addAttribute("userId", user.getId());
                    return "auth/findidResult";
                } else {
                    model.addAttribute("errorMessage", "일치하는 정보가 없습니다.");
                    return "auth/findidResult";
                }
            } else {
                model.addAttribute("errorMessage", "휴대폰 번호를 모두 입력해 주세요.");
                return "auth/findidResult";
            }
        } else {
            model.addAttribute("errorMessage", "잘못된 인증 방법입니다.");
            return "auth/findidResult";
        }
    }
}

