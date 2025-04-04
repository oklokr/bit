<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${not empty userId}">
    <p>아이디: ${userId}</p>
    <p>${message}</p>
</c:if>

<c:if test="${not empty errorMessage}">
    <p>${errorMessage}</p>
</c:if>