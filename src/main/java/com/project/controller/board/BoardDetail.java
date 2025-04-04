package com.project.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;
import com.project.service.BoardService;


@Controller
public class BoardDetail {
    @Autowired
    private BoardService boardDao;

    @GetMapping("/board/detail")
    public String pageRender(@RequestParam int board_id, @RequestParam String pageNum, @RequestParam int number,
    Model model) throws Exception {
        BoardDto boardDto = boardDao.getArticle(board_id);
        boardDao.addCount(board_id);

        model.addAttribute("board_id", board_id);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("number", number);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }

    // @PostMapping("/board/detail")
    // public String editPost(@RequestParam("content") String content, Model model) {
    //     System.out.println("받은 데이터: " + content);

    //     model.addAttribute("title", "main page");
    //     model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
    //     return "layout/app";
    // }
}
