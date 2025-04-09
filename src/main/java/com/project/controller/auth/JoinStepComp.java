package com.project.controller.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.model.UserDto;
import com.project.service.UserService;


@Controller
public class JoinStepComp {

    @Autowired
    private UserService userService; // UserService 의존성 주입

    @GetMapping("/joinStepComp")
    public String pageRender(Model model) {
        model.addAttribute("title", "JoinStepComp Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepComp.jsp");
        return "layout/app";
    }
    @PostMapping("/joinStepComp")
    public String handleJoinStepComp(@RequestParam Map<String, String> params, Model model) {
        System.out.println("Received params: " + params);

        model.addAttribute("title", "JoinStepComp Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepComp.jsp");
        
        return "layout/app";
    }
    
    @PostMapping("/checkBusinessNumber")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkBusinessNumber(@RequestBody Map<String, String> request) {
        String businessNumber = request.get("businessNumber");
        boolean isValid = userService.validateBusinessNumber(businessNumber); // UserService의 메서드 호출
        Map<String, Boolean> response = new HashMap<>();
        response.put("isValid", isValid);
        return ResponseEntity.ok(response);
    }
    @PostMapping("/joinResult")
public String handleJoinResult(@RequestParam Map<String, String> params, Model model) {
    // 입력 데이터 추출
    String companyName = params.get("companyName");
    String id = params.get("id");
    String password = params.get("password");
    String email = params.get("email");
    String phoneNumber = params.get("phoneNumber");
    String businessNumber = params.get("businessNumber1") + "-" +
                            params.get("businessNumber2") + "-" +
                            params.get("businessNumber3");
    String address = params.get("address");
    String detailedAddress = params.get("detailedAddress");
    String postalCode = params.get("postalCode");

    // UserDto 객체 생성
    UserDto user = new UserDto();
    user.setCompanyName(companyName);
    user.setId(id);
    user.setPassword(password);
    user.setEmail(email);
    user.setPhoneNumber(phoneNumber);
    user.setBusinessNumber(businessNumber);
    user.setAddress(address);
    user.setDetailedAddress(detailedAddress);
    user.setPostalCode(postalCode);

    // DB에 저장
    userService.saveUser(user);

    // 결과 페이지로 이동
    model.addAttribute("user", user);
    return "auth/joinResult"; // joinResult.jsp로 이동
}
}