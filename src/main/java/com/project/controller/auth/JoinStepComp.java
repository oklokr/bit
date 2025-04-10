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
    
    // 전화번호 조합
    String phoneNumber = params.get("tel1") + "-" + params.get("tel2") + "-" + params.get("tel3");
    user.setPhoneNumber(phoneNumber);

    // 사업자 번호 조합
    String businessNumber = params.get("businessNumber1") + "-" + params.get("businessNumber2") + "-" + params.get("businessNumber3");
    user.setBusinessNumber(businessNumber);
    user.setAddress(params.get("address"));
    user.setDetailedAddress(params.get("detailedAddress"));
    user.setPostalCode(params.get("postalCode"));

    // DB에 회원 정보 저장
    userService.saveUser(user);

    // 약관 동의 여부 저장
    boolean requiredTermAgreed = Boolean.parseBoolean(params.get("requiredTermAgreed"));
    boolean optionalTermAgreed = Boolean.parseBoolean(params.get("optionalTermAgreed"));

    System.out.println("Required Term Agreed: " + requiredTermAgreed);
    System.out.println("Optional Term Agreed: " + optionalTermAgreed);

    // 필수 약관 동의 저장
    if (requiredTermAgreed) {
        System.out.println("Saving required terms agreement for user: " + user.getId());
        userService.saveTermsAgreement(user.getId(), 1); // 필수 약관 ID: 1
    }

    // 선택 약관 동의 저장 (체크했을 경우에만)
    if (optionalTermAgreed) {
        System.out.println("Saving optional terms agreement for user: " + user.getId());
        userService.saveTermsAgreement(user.getId(), 2); // 선택 약관 ID: 2
    }

    // 리다이렉트 시 데이터를 전달
    redirectAttributes.addFlashAttribute("user", user);

    return "redirect:/joinResult";
}
}