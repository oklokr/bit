<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>아이디 찾기 결과</h2>

<c:if test="${not empty userId}">
    <p>아이디: ${id}</p>
</c:if>

<c:if test="${not empty errorMessage}">
    <p>${errorMessage}</p>
</c:if>