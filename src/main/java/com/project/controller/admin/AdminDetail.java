package com.project.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.model.UserDto;
import com.project.service.AdminService;
import com.project.service.UserService;

import jakarta.servlet.http.HttpSession;


@Controller
public class AdminDetail {
    @Autowired
    private UserService userDao;
    
    @Autowired
    private AdminService adminDao;

    @Value("${kakao.map.js-key}")
    private String kakaoMapJsKey;

    @GetMapping("/admin/detail")
    public String pageRender(@RequestParam String id, @RequestParam int pageNum, Model model) {
        UserDto userDto = userDao.getUserById(id);
        model.addAttribute("kakaoMapJsKey", kakaoMapJsKey);
        model.addAttribute("userDto", userDto);
        model.addAttribute("id", userDto.getId());
        model.addAttribute("companyName", userDto.getCompanyName());
        model.addAttribute("address", userDto.getAddress());
        model.addAttribute("detailedAddress", userDto.getDetailedAddress());
        model.addAttribute("postalCode", userDto.getPostalCode());
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("title", "main page");
        model.addAttribute("contentPage", "/WEB-INF/page/admin/detail.jsp");
        return "layout/app";
    }

    // @PostMapping("/admin/resetPassword")
    // public String resetPassword(@RequestParam String id, @RequestParam int pageNum, Model model, HttpSession session){
    //     UserDto user = userDao.getUserById(id);
    //     String name = user.getCompanyName();
    //     int result = adminDao.resetPassword(id);
    //     session.setAttribute("resetResult", result);
    //     model.addAttribute("name", name);
    //     model.addAttribute("id", id);
    //     model.addAttribute("pageNum", pageNum);
    //     model.addAttribute("title", "main page");
    //     model.addAttribute("contentPage", "/WEB-INF/page/admin/detail.jsp");
    //     return "layout/app";
    // }

    // @PostMapping("/admin/deleteUser")
    // public String deleteUser(@RequestParam String id, Model model, HttpSession session){
    //     UserDto user = userDao.getUserById(id);
    //     String name = user.getCompanyName();
    //     int result = adminDao.deleteUser(id);
    //     session.setAttribute("deleteResult", result);
    //     model.addAttribute("deletedName", name);
    //     model.addAttribute("failedId", id);
    //     model.addAttribute("title", "main page");
    //     model.addAttribute("contentPage", "/WEB-INF/page/admin/admin.jsp");
    //     return "layout/app";
    // }

    // @PostMapping("/admin/changeMemberType")
    // public String changeMemberType(@RequestParam String id, @RequestParam int pageNum, Model model, HttpSession session){
    //     UserDto user = userDao.getUserById(id);
    //     Map<String,Object> map = new HashMap<>();
    //     map.put("id", id);
    //     map.put("memberType", user.getMemberType());
    //     int result = adminDao.changeMemberType(map);

    //     model.addAttribute("name", user.getCompanyName());
    //     session.setAttribute("changeResult", result);
    //     model.addAttribute("pageNum", pageNum);
    //     model.addAttribute("id", id);
    //     model.addAttribute("title", "main page");
    //     model.addAttribute("contentPage", "/WEB-INF/page/admin/detail.jsp");
    //     return "layout/app";
    // }

    
}

@RestController
class AdminApiController {
    @Autowired
    private AdminService adminDao;

    @Autowired
    private UserService userDao;

    @PostMapping("/api/admin/delete")
    public int deleteUser(@RequestBody String id){
        System.out.println("아이디는"+id);
        id = id.replace("\"", "");
        int result = adminDao.deleteUser(id);
        System.out.println("실행결과: "+result);
        return result;
    }

    @PostMapping("/api/admin/reset")
    public int resetPw(@RequestBody String id){
        System.out.println("비밀번호 리셋"+id);
        id = id.replace("\"", "");
        int result=adminDao.resetPassword(id);
        System.out.println("비밀번호 리셋 실행결과:"+result);
        return result;
    }

    @PostMapping("/api/admin/change")
    public int changeMemberType(@RequestBody Map<String, Object> userMap){
        int result = adminDao.changeMemberType(userMap);
        return result;
    }
}