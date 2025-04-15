package com.project.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.BoardDto;
import com.project.service.BoardService;

@Controller
public class Board {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board")
    public String board(@RequestParam(required=false) String pageNum, Model model) {
        int pageSize=10;
        int pageBlock=3;
        
        int count=0; //전체 글 개수
        int currentPage=0; //계산용
        int start=0;
        int end=0;
        int number=0;   //출력되는 글번호
        int pageCount=0; //페이지 개수
        int startPage = 0; //출력 페이지 시작 
        int endPage = 0; //출력 페이지 끝

        count = boardService.getCount();

        if (pageNum == null || pageNum.equals("")){
            pageNum="1";
        }
        currentPage = Integer.parseInt(pageNum);
        start=(currentPage-1)*pageSize+1;
        end = start+pageSize -1; 
        if(end>count){
            end=count;
        }

        number=(currentPage-1) * pageSize;

        pageCount = (count / pageSize) + (count % pageSize > 0 ? 1 : 0);
        startPage=(currentPage/pageBlock)*pageBlock+1;
        if(currentPage%pageBlock==0)
            startPage-=pageBlock;
        endPage=startPage+pageBlock-1;
        if(endPage>pageCount)
            endPage = pageCount;
        model.addAttribute("pageBlock", pageBlock);
        model.addAttribute("count", count);
        model.addAttribute("number", number);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        if (count>0){
            Map<String,Integer> map = new HashMap<String,Integer>();
            start -= 1;
            map.put("start", start);
            map.put("pageSize", pageSize);

            List<BoardDto> dtos = boardService.getArticles(map);
            model.addAttribute("dtos", dtos);
        }
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/board/board.jsp");
        return "layout/app";
    }
}
