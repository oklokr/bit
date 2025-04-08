package com.project.controller.auth;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class JoinStepComp {
    @GetMapping("/joinStepComp")
    public String pageRender(Model model) {
        model.addAttribute("title", "JoinStepComp Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepComp.jsp");
        return "layout/app";
    }
    @GetMapping("/joinResult")
    public String handleJoinStepComp(@RequestParam Map<String, String> params, Model model) {
        model.addAttribute("title", "JoinStepComp Page");
        model.addAttribute("contentPage", "/WEB-INF/page/auth/joinStepComp.jsp");
        return "layout/app";
    }
}