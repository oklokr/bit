package com.project.controller.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;

@Controller
public class Board {
    @Autowired
    private BoardDto boardDao;

    @GetMapping("/board")
    public String board(@RequestParam(required=false) String pageNum, Model model) {
        int pageSize=9;
        int pageBlock=10;
        
        int count=0; //전체 글 개수
        int currentPage=0; //계산용
        int start=0;
        int end=0;
        int number=0;   //출력되는 글번호
        int pageCount=0; //페이지 개수

        
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/board.jsp");
        return "layout/app";
    }
}
