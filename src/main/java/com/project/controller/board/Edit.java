package com.project.controller.board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;
import com.project.service.BoardService;

import jakarta.servlet.http.HttpSession;

@Controller
public class Edit {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board/edit")
    public String boardEdit(@RequestParam int boardId, @RequestParam String pageNum, 
        @RequestParam int result, Model model) {
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("result", result);
        model.addAttribute("title", "main page");
        BoardDto boardDto = boardService.getArticle(boardId);

        model.addAttribute("boardId", boardId);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("contentPage", "/WEB-INF/page/board/edit.jsp");
        return "layout/app";
    }

    @PostMapping("/board/edit")
    public String postBoardEdit(@ModelAttribute BoardDto boardDto, @RequestParam String pageNum, Model model, HttpSession session){
        int result = boardService.modifyPost(boardDto);
        int id = boardDto.getBoardId();
        session.setAttribute("editResult", result);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("boardId", id);
        model.addAttribute("contentPage", "/WEB-INF/page/board/edit.jsp");
        return "layout/app";
    }

}
