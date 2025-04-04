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

@Controller
public class Edit {
    @Autowired
    private BoardService boardDao;

    @GetMapping("/board/edit")
    public String boardEdit(@RequestParam int board_id, @RequestParam String pageNum, 
        @RequestParam int result, Model model) {
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("result", result);
        model.addAttribute("title", "main page");
        BoardDto boardDto = boardDao.getArticle(board_id);

        model.addAttribute("board_id", board_id);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("contentPage", "/WEB-INF/page/board/edit.jsp");
        return "layout/app";
    }

    @PostMapping("/board/edit")
    public String postBoardEdit(@ModelAttribute BoardDto boardDto, @RequestParam String pageNum, Model model){
        int result = boardDao.modifyPost(boardDto);
        int id = boardDto.getBoard_id();

        model.addAttribute("pageNum", pageNum);
        model.addAttribute("result", result);
        model.addAttribute("board_id", id);
        model.addAttribute("contentPage", "/WEB-INF/page/board/edit.jsp");
        return "layout/app";
    }

}
