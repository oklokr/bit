package com.project.controller.mypage;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Mypage {
    @Autowired
    private UserService userService;
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model){
        UserDto userDto = userService.getUserInfo(session.getId());
        model.addAttribute("userDto", userDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/mypage/mypage.jsp");
        return "layout/app";
    }
}

@RestController
class MypageApiController {
    @Autowired
    private UserService userService;

    @PostMapping("/api/mypage/info")
    public Map<String, Object> getMypageInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserDto userInfo = userService.getUserInfo(session.getId());
        Map<String, Object> response = new HashMap<>();
        response.put("id", userInfo.getId());
        response.put("companyName", userInfo.getCompanyName());
        response.put("password", userInfo.getPassword());
        response.put("email", userInfo.getEmail());
        response.put("businessNumber", userInfo.getBusinessNumber());
        response.put("phoneNumber", userInfo.getPhoneNumber());
        response.put("address", userInfo.getAddress());
        response.put("detailedAddress", userInfo.getDetailedAddress());
        response.put("postalCode", userInfo.getPostalCode());
        response.put("memberType", userInfo.getMemberType());
        response.put("joinDate", userInfo.getJoinDate());
        response.put("sessionExpiryTime", userInfo.getSessionExpiryTime());
        return response;
    }
}