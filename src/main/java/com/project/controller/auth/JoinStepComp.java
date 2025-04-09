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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    @PostMapping("/joinStepSuccess")
public String JoinStepComphandle(@RequestParam Map<String, String> params, RedirectAttributes redirectAttributes) {
    // 입력 데이터 출력 (디버깅용)
    System.out.println("Received params: " + params);

    // UserDto 객체 생성 및 데이터 설정
    UserDto user = new UserDto();
    user.setCompanyName(params.get("companyName"));
    user.setId(params.get("id"));
    user.setPassword(params.get("password"));
    user.setEmail(params.get("email"));
    user.setPhoneNumber(params.get("phoneNumber"));
    user.setBusinessNumber(params.get("businessNumber1") + "-" + params.get("businessNumber2") + "-" + params.get("businessNumber3"));
    user.setAddress(params.get("address"));
    user.setDetailedAddress(params.get("detailedAddress"));
    user.setPostalCode(params.get("postalCode"));

    // DB에 저장
    userService.saveUser(user);

    // 리다이렉트 시 데이터를 전달
    redirectAttributes.addFlashAttribute("user", user);

    return "redirect:/joinResult";
}
}
