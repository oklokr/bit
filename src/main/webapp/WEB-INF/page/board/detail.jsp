<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board_detail</title>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/common.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <div class="board-detail-page container">
        <h3> 자유게시판 ${deleteResult}</h3>
        <br>
        <table class="table">
            <tr>
                <th colspan="2" class="title">${boardDto.title}</th>
            </tr>
            <tr>
                <td>작성자 : ${boardDto.author}</td>
                <td>작성날짜 : <fmt:formatDate value="${boardDto.creation_date}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            <tr>
                <td colspan="2" class="content">${boardDto.content}</td>
            </tr>

        </table>

        <!-- 답글 섹션 -->
        <div class="reply-section">
            <h5>답글 <span>(${replyCount}개)</span></h5>
            <table class="reply-table">
                <c:if test="${replyCount eq 0}">
                    <tr>
                        <td colspan = "2">
                            답글이 존재하지 않습니다
                        </td>
                    </tr>
                </c:if>
                <c:if test="${replyCount ne 0}">
                    <c:forEach var="dto" items="${dtos}">
                        <tr>
                            
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>  

        <!-- 버튼 그룹 -->
        <div class="button-group d-flex">
            <button class="btn btn-secondary"
            onclick="location='/board?pageNum=${pageNum}'">목록</button>

            <div class="ms-auto">
                <button class="btn btn-primary"
                onclick="location='/board/edit?board_id=${board_id}&result=${-1}&pageNum=${pageNum}'">수정</button>
                <button class="btn btn-primary"
                onclick="location='/board/delete?board_id=${board_id}&pageNum=${pageNum}'">삭제</button>
            </div>
        </div>
    
    </div>


</body>
</html>

<script>
    window.onload = function() {
        let deleteResult = "${deleteResult}";
        
        if (deleteResult === "1") {
            alert("게시글이 삭제되었습니다.");
            location.href = "/board?pageNum=${pageNum}"; // 목록 페이지로 이동
        } else if (deleteResult === "0") {
            alert("게시글 삭제에 실패했습니다.");
        }

    }
</script>

<%-- JSP에서 세션 값 삭제 (JavaScript 실행 이후) --%>
<% session.removeAttribute("deleteResult"); %>

<style>
    .table {
        width: 100%;
        table-layout: fixed; /* 고정 레이아웃 */
    }
    th.title {
        font-size: 1.4rem;
        font-weight: bold;
    }
    .board-detail-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        padding: 20px;
        background: #fff; /* 배경 흰색 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .reply-table {
        margin-bottom: 50px; /* 바닥에서 20px 떨어지도록 설정 */
    }

    .reply-section h5 {
        font-size: 1.2rem; /* 제목 크기 키우기 */
        font-weight: bold; /* 제목 굵게 */
    }

    .reply-section h5 span {
        font-size: 1rem; /* 총 답글 수는 작은 글씨 */
        font-weight: normal; /* 기본 글씨 두께 */
        color: #666; /* 회색 계열로 가독성 조절 */
    }

    .board-detail-page h3 {
        text-align: center;
        margin: 20px 0; /* 위아래 여백 */
        align-items: center;
        font-weight: bold;
    }

    td.content {
        min-height: 100px; /* 최소 높이 */
        height: 100px; /* 높이 설정 */
        padding: 10px; /* 내부 여백 */
        word-wrap: break-word; /* 긴 단어 줄 바꿈 */
        vertical-align: top; /* 내용이 위쪽 정렬되도록 설정 */
    }


</style>
