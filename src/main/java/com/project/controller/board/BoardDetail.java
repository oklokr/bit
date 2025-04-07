package com.project.controller.board;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;
import com.project.service.BoardService;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;



@Controller
public class BoardDetail {
    @Autowired
    private BoardService boardDao;


    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam int boardId, @RequestParam String pageNum,
    Model model) throws Exception {
        BoardDto boardDto = boardDao.getArticle(boardId);
        boardDao.addCount(boardId);
        int replyCount = 0;
        replyCount = boardDao.getReplyCount(boardId);

        List<ReplyDto> replyDtos = boardDao.getReplies(boardId);
        model.addAttribute("replyDtos", replyDtos);

        model.addAttribute("replyCount", replyCount);
        model.addAttribute("boardId", boardId);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }

    @GetMapping("/board/delete")
    public String boardDelete(@RequestParam int boardId, @RequestParam String pageNum, Model model, HttpSession session){
        int result = boardDao.deletePost(boardId);
        session.setAttribute("deleteResult", result);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }

    @PostMapping("/board/reply/write")
    public String postReply(@ModelAttribute ReplyDto replyDto, @RequestParam String pageNum, Model model, HttpSession session) {

        //원래 쿠키에서 가져와야.. 임시
        replyDto.setAuthor("user");
        replyDto.setMemberNo("9379d1ca-1358-11f0-899e-c8418a1096fd");
        
        replyDto.setCreationDate(new Timestamp(System.currentTimeMillis()));
        
        int result=boardDao.insertReply(replyDto);

        session.setAttribute("ReplyResult", result);
        return "redirect:/board/detail?boardId=" + replyDto.getBoardId() + "&pageNum=" + pageNum;
    }
}
