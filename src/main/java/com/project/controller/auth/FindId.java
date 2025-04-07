package com.project.controller.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

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
@ResponseBody
public Map<String, Object> findId(@RequestBody Map<String, String> requestBody) {
    System.out.println("요청 받은 데이터: " + requestBody);

    Map<String, Object> response = new HashMap<>();

    try {
        if (requestBody == null || requestBody.isEmpty()) {
            response.put("success", false);
            response.put("message", "요청 데이터가 비어 있습니다.");
            return response;
        }

        String companyName = requestBody.get("company_name");
        String certType = requestBody.get("cert_type"); // 인증 방법 (1: 이메일, 2: 휴대폰)
        String certValue = requestBody.get("cert_value"); // 인증 값 (이메일 또는 휴대폰 번호)

        System.out.println("요청 받은 업체명: " + companyName);
        System.out.println("인증 방법: " + certType);
        System.out.println("인증 값: " + certValue);

        if (companyName == null || companyName.isEmpty()) {
            response.put("success", false);
            response.put("message", "업체명을 입력해주세요.");
            return response;
        }

        if (certType == null || certType.isEmpty() || certValue == null || certValue.isEmpty()) {
            response.put("success", false);
            response.put("message", "인증 정보를 입력해주세요.");
            return response;
        }

        UserDto user = null;
        if ("1".equals(certType)) { // 이메일 인증
            user = userService.findByCompanyNameAndEmail(companyName, certValue);
        } else if ("2".equals(certType)) { // 휴대폰 인증
            user = userService.findByCompanyNameAndPhone(companyName, certValue);
        }

        System.out.println("조회된 사용자: " + user);

        if (user != null) {
            response.put("success", true);
            response.put("id", user.getId());
        } else {
            response.put("success", false);
            response.put("message", "일치하는 정보가 없습니다.");
        }
    } catch (Exception e) {
        System.err.println("오류 발생: " + e.getMessage());
        e.printStackTrace();
        response.put("success", false);
        response.put("message", "서버 처리 중 오류가 발생했습니다.");
    }

    System.out.println("서버 응답 데이터: " + response);
    return response;
    }
}