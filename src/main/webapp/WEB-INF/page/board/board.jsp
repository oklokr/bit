<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board</title>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/common.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <div class="board-page countainer">
        
        <h3> 자유게시판 </h3>
        <br>
        
        <table class="table">
            <tr>
                <th colspan="4">총 ${count}개</th>
                <th><input class="btn btn-primary"
                    onclick="location='/board/write?result=${-1}'" type="button" value="글쓰기"/></th>
            </tr>
            <tr class="col-title">
                <th style="width:7%">No</th>
                <th style="width:50%">제목</th>
                <th style="width:13%">작성자</th>
                <th style="width:18%; white-space: nowrap;">작성일</th>
                <th style="width:8%">조회수</th>
            </tr>
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
                        <td>
                            &nbsp; &nbsp;
                            <a href="/board/detail?boardId=${dto.boardId}&pageNum=${pageNum}" 
                                class="board-title-link">
                                ${dto.title}
                            </a>    
                        </td> 
                        <td>
                            ${dto.author}
                        </td>
                        <td>
                            ${dto.creationDate}
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
                            ${dto.view_count}
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>

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

    
</body>
</html>

<style>
    body {
        padding-bottom: 50px; /* 페이지 아래쪽 여백 추가 */
    }

    .board-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        padding: 20px;
        background: #fff; /* 배경 흰색 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .col-title{
        text-align: center; /* 가운데 정렬 */
        font-weight: bold;  /* 글씨 굵게 */
    }

        /* 기본 상태: 검은색 */
    .board-title-link {
        color: black;
        text-decoration: none;
        display: inline-block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* 마우스 올릴 때: 파란색 */
    .board-title-link:hover {
        color: RoyalBlue;
        text-decoration: underline;
    }

    /* 방문한 링크: 보라색 */
    .board-title-link:visited {
        color: Purple;
    }

    .btn.btn-primary {
        float: right;
    }

    .table {
        margin-top: 10px; /* 위쪽 여백 */
        padding: 10px;
    }

    .board-page h3 {
        text-align: center;
        margin: 20px 100px; /* 위아래 여백 */
        align-items: center;
        font-weight: bold;
    }

    td:not(:nth-child(2)) {
        text-align: center;
    }
    
</style>
