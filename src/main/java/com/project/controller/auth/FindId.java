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
            System.err.println("요청 데이터가 비어 있습니다.");
            response.put("success", false);
            response.put("message", "요청 데이터가 비어 있습니다.");
            return response;
        }

        String companyName = requestBody.get("company_name");
        System.out.println("요청 받은 업체명: " + companyName);

        if (companyName == null || companyName.isEmpty()) {
            response.put("success", false);
            response.put("message", "업체명을 입력해주세요.");
            return response;
        }

        // 업체명으로 사용자 조회
        UserDto user = userService.findByCompanyName(companyName);
        System.out.println("조회된 사용자: " + user);

        if (user != null) {
            response.put("success", true);
            response.put("userId", user.getId());
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

    return response;
}
}
