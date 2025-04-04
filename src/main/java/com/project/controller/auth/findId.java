package com.project.controller.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.model.UserDto;
import com.project.service.UserService;




@Controller
public class FindId {
    @GetMapping("/findId")
    public String pageRender(Model model) {
        model.addAttribute("title", "Login Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/findId.jsp");
        return "layout/app";
    }

    @PostMapping("/findId")
    public String findIdProcess( UserDto userdto, Model model ) {
        
        FindIdResult result = UserService.findId( userdto );
        if( "SUCCESS".equals(result)) {
            return "redirect:/findIdResult";
        } else {
            return "layout/app";
        }
    }
    
}
