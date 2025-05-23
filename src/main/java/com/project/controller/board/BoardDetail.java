package com.project.controller.board;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.BoardDto;
import com.project.model.ReplyDto;
import com.project.model.UserDto;
import com.project.service.BoardService;
import com.project.service.UserService;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
public class BoardDetail {
    @Autowired
    private BoardService boardService;

    @Autowired
    private UserService userService;


    @GetMapping("/board/detail")
    public String pageRender(@RequestParam int boardId, @RequestParam String pageNum, HttpSession session,
    Model model) throws Exception {
        BoardDto boardDto = boardService.getArticle(boardId);
        boardService.addCount(boardId);
        int replyCount = 0;
        replyCount = boardService.getReplyCount(boardId);

        List<ReplyDto> replyDtos = boardService.getReplies(boardId);
        model.addAttribute("replyDtos", replyDtos);

        String user = userService.getUserInfo(session.getId()).getCompanyName();
        int userType = userService.getUserInfo(session.getId()).getMemberType();
        model.addAttribute("user", user);
        model.addAttribute("userType", userType);
        model.addAttribute("replyCount", replyCount);
        model.addAttribute("boardId", boardId);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("boardDto", boardDto);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/detail.jsp");
        return "layout/app";
    }

    @PostMapping("/board/reply/write")
    public String postReply(@ModelAttribute ReplyDto replyDto, @RequestParam String pageNum, Model model, HttpSession session) {
        UserDto userDto = userService.getUserInfo(session.getId());
        replyDto.setAuthor(userDto.getCompanyName());
        replyDto.setId(userDto.getId());
        
        replyDto.setCreationDate(new Timestamp(System.currentTimeMillis()));
        
        int result=boardService.insertReply(replyDto);

        session.setAttribute("ReplyResult", result);
        return "redirect:/board/detail?boardId=" + replyDto.getBoardId() + "&pageNum=" + pageNum;
    }
}


@RestController
class BoardApiController {
    @Autowired
    private BoardService boardService;

    @PostMapping("/api/board/delete")
    public int boardDelete(@RequestBody int boardId){
        int result = boardService.deletePost(boardId);
        return result;
    }

    @PostMapping("/api/board/reply/delete")
    public int replyDelete(@RequestBody int replyId){
        int result = boardService.deleteReply(replyId);
        return result;
    }
}