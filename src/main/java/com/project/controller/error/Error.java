package com.project.controller.error;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class Error {
    @RequestMapping("/error")
    public String pageRender(HttpServletRequest request, Model model) {
        Object status = request.getAttribute("javax.servlet.error.status_code");
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            if (statusCode == 404) {
                return "page/error/404"; // 404 에러 페이지로 이동
            }
        }
        return "error"; // 기타 에러 처리 (필요 시 추가)
    }
}
