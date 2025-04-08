package com.project.controller.board;

import java.sql.Timestamp;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;


import com.project.model.BoardDto;
import com.project.model.UserDto;
import com.project.service.BoardService;
import com.project.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class Write{
    @Autowired
    private BoardService boardDao;

    @Autowired
    private UserService userDao;

    @GetMapping("/board/write")
    public String pageRender(Model model) {
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/write.jsp");
        return "layout/app";
    }

    @PostMapping("/board/write")
    public String postMethodName(@ModelAttribute BoardDto boardDto, Model model, HttpSession session) {
        // 작성일
		boardDto.setCreationDate(new Timestamp(System.currentTimeMillis()));

        UserDto userDto = userDao.getUserInfo(session.getId());
        boardDto.setAuthor(userDto.getCompanyName());
        //boardDto.setMemberNo(userDto.getMem);
        //원래 쿠키에서 가져와야.. 임시
        boardDto.setAuthor("user");
        
        //boardDto.setMemberNo("87b2a914-1389-11f0-899e-c8418a1096fd");
        
        int result = boardDao.insertPost(boardDto);
        session.setAttribute("writeResult", result);
        model.addAttribute("contentPage", "/WEB-INF/page/board/write.jsp");
        return "layout/app";
    }
    
}
