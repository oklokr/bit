package com.project.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/board/write")
public class Write{
    @GetMapping
    public String pageRender(@RequestParam(defaultValue="0") int board_id, Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/write.jsp");
        return "layout/app";
    }
}
