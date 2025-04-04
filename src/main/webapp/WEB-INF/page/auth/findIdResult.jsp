<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>아이디 찾기 결과</h2>
<% 
    com.project.dto.UserDto user = (com.project.dto.UserDto) request.getAttribute("user");
    if (user != null) { 
%>
    <p>당신의 아이디는 <strong><%= user.getUserId() %></strong> 입니다.</p>
<% } else { %>
    <p>오류가 발생했습니다. 다시 시도해주세요.</p>
<% } %>
<a href="/findId">돌아가기</a>