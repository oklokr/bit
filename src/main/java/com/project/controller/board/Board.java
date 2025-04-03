package com.project.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Board {
    @GetMapping("/board")
    public String getMethodName(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/board.jsp");
        return "layout/app";
    }
}
