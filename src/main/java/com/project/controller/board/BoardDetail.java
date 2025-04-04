package com.project.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;
import com.project.service.BoardService;

import jakarta.servlet.http.HttpSession;


@Controller
public class BoardDetail {
    @Autowired
    private BoardService boardDao;

    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam int board_id, @RequestParam String pageNum,
    Model model) throws Exception {
        BoardDto boardDto = boardDao.getArticle(board_id);
        boardDao.addCount(board_id);
        int replyCount = 0;
        replyCount = boardDao.getReplyCount(board_id);
        model.addAttribute("replyCount", replyCount);
        model.addAttribute("board_id", board_id);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }

    @GetMapping("/board/delete")
    public String boardDelete(@RequestParam int board_id, @RequestParam String pageNum, Model model, HttpSession session){
        int result = boardDao.deletePost(board_id);
        session.setAttribute("deleteResult", result);
        model.addAttribute("result", result);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }
}
