<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 찾기 결과</title>
</head>
<body>
    <h2>비밀번호 찾기 결과</h2>
    <p>아이디: <%= request.getParameter("id") %></p>
    <p>인증 방법: <%= "1".equals(request.getParameter("cert_type")) ? "이메일" : "휴대폰" %></p>
    <p>인증 값: <%= request.getParameter("cert_value") %></p>
    <p>임시 비밀번호: <strong><%= request.getParameter("password") %></strong></p>
    <button onclick="location.href='/login'">로그인 페이지로 이동</button>
</body>
</html>