package com.project.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.model.UserDto;
import com.project.service.AdminService;
import com.project.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class Admin {
    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;

    @GetMapping("/admin")
    public String pageRender(@RequestParam(required = false) String searchName, 
        @RequestParam(required=false) String pageNum, HttpSession session, Model model) {

        //접근한 사람
        int type = userService.getUserInfo(session.getId()).getMemberType();
        if (type != 2){
            model.addAttribute("contentPage", "/WEB-INF/error.jsp");
            return "layout/app";
        }

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


        count = adminService.getCount(searchName);

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

            Map<String, Object> map = new HashMap<>();
            start -= 1;
            map.put("start", start);
            map.put("pageSize", pageSize);
            map.put("searchName", searchName);

            List<UserDto> memberDtos = adminService.getUsers(map);
            model.addAttribute("memberDtos", memberDtos);
        }
        model.addAttribute("searchName", searchName);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/admin/admin.jsp");
        return "layout/app";
    }

}
