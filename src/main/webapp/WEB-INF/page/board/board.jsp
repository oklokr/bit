<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container page-wrap">
    <h2 class="page-title"> 자유게시판</h2>
    <div class="table-board-wrap">
        <div class="top-area">
            <span>총 ${count}개</span>
            <div class="btns">
                <a class="btn btn-outline-secondary btn-sm" href="/board/write?result=${-1}" role="button">글쓰기</a>
            </div>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th style="width:5%;">No</th>
                    <th style="width:50%;">제목</th>
                    <th style="width:20%;">작성자</th>
                    <th style="width:12%; white-space: nowrap;">작성일</th>
                    <th style="width:5%;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${count eq 0}">
                    <tr>
                        <td colspan = "5">
                            자유게시판 글이 존재하지 않습니다
                        </td>
                    </tr>
                </c:if>
        
                <c:if test="${count ne 0}">
                    <c:set var="number" value="${number+1}"/>
                    <c:forEach var="dto" items="${dtos}">
                        <tr>
                            <td>
                                ${number}
                                <c:set var="number" value="${number+1}"/>
                            </td>
                            <td class="label">
                                <span class="board-title-link">
                                    <c:if test="${dto.viewCount gt 50}">
                                        🦷
                                    </c:if>
                                    ${dto.title}
                                </span>
                                <a href="/board/detail?boardId=${dto.boardId}&pageNum=${pageNum}">상세보기</a>
                            </td> 
                            <td>
                                ${dto.author}
                            </td>
                            <td>
                                <jsp:useBean id="now" class="java.util.Date"/>
                                <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
                                <fmt:formatDate value="${dto.creationDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
                                <c:if test="${formattedDate eq today}">
                                    <fmt:formatDate value="${dto.creationDate}" pattern="HH:mm"/>
                                </c:if>
                                <c:if test="${formattedDate ne today}">
                                    <fmt:formatDate value="${dto.creationDate}" pattern="yyyy-MM-dd"/>
                                </c:if>
                            </td>
                            <td>
                                ${dto.viewCount}
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="d-flex justify-content-center align-items-center gap-3 mt-0">
        <c:if test="${count gt 0}">
            <c:if test="${startPage gt pageBlock}">
                <a href="board">
                    <i class="bi bi-chevron-left"></i>
                </a>
            </c:if>
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <c:if test="${i eq currentPage}">
                    <span class="badge bg-primary" style="font-size: 1rem;">${i}</span>
                </c:if>
                <c:if test="${i ne currentPage}">
                    <a href="board?pageNum=${i}" class="text-decoration-none">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${pageCount gt endPage}">		
                <a href="board?pageNum=${startPage + pageBlock}">
                    <i class="bi bi-chevron-right"></i>
                </a>
            </c:if>
        </c:if>
    </div>
</div>
