package com.project.controller.board;

import java.sql.Timestamp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.project.model.BoardDto;
import com.project.model.UserDto;
import com.project.service.BoardService;
import com.project.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class Write{
    @Autowired
    private BoardService boardService;

    @Autowired
    private UserService userService;

    @GetMapping("/board/write")
    public String pageRender(Model model, HttpSession session) {
        String user = userService.getUserInfo(session.getId()).getCompanyName();
        model.addAttribute("user", user);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/write.jsp");
        return "layout/app";
    }

    @PostMapping("/board/write")
    public String postBoard(@ModelAttribute BoardDto boardDto, Model model, HttpSession session) {
        UserDto userDto = userService.getUserInfo(session.getId());
        boardDto.setAuthor(userDto.getCompanyName());
        boardDto.setId(userDto.getId());
        boardDto.setCreationDate(new Timestamp(System.currentTimeMillis()));

        int result = boardService.insertPost(boardDto);
        session.setAttribute("writeResult", result);
        model.addAttribute("contentPage", "/WEB-INF/page/board/write.jsp");
        return "layout/app";
    }
    
}
