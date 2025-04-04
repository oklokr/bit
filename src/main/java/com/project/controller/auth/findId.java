package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    @PostMapping("/findId")
    public String processFindId(
        @RequestParam("company_name") String companyName,
        @RequestParam("certification") String certification,
        @RequestParam("cert_value") String certValue,
        Model model,
        RedirectAttributes redirectAttributes) {

    System.out.println("Received - companyName: '" + companyName + "', certification: '" + certification + "', certValue: '" + certValue + "'");

    if (companyName == null || companyName.trim().isEmpty() || 
        certification == null || certValue == null || certValue.trim().isEmpty()) {
        model.addAttribute("error", "모든 필드를 입력해주세요.");
        model.addAttribute("title", "아이디 찾기");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }

    UserDto user = null;
    if ("1".equals(certification)) {
        user = userService.findUserByEmail(companyName, certValue);
        System.out.println("findUserByEmail result: " + (user != null ? user.getId() : "null"));
    } else if ("2".equals(certification)) {
        user = userService.findUserByPhoneNumber(companyName, certValue);
        System.out.println("findUserByPhone result: " + (user != null ? user.getId() : "null"));
    }

    if (user != null) {
        redirectAttributes.addFlashAttribute("user", user);
        return "redirect:/findIdResult";
    } else {
        model.addAttribute("error", "일치하는 사용자가 없습니다.");
        model.addAttribute("title", "아이디 찾기");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }
}
} 

