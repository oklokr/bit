<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입 완료</title>
</head>
<body>
    <h1>가입이 완료되었습니다!</h1>
    <p>회사명: ${user.companyName}</p>
    <p>아이디: ${user.id}</p>
    <p>이메일: ${user.email}</p>
    <p>전화번호: ${user.phoneNumber}</p>
    <p>사업자 번호: ${user.businessNumber}</p>
    <p>주소: ${user.address} ${user.detailedAddress}</p>
    <p>우편번호: ${user.postalCode}</p>
    <p>로그인을 진행해주세요.</p>
    <a href="/login">로그인 페이지로 이동</a>
</body>
</html>