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
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <div class="board-detail-page container">
        <h3> 자유게시판</h3>
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
            <strong style="display: block; margin-bottom: 10px;">
                답글 (<fmt:formatNumber value="${replyCount}" pattern="###,###"/>개)
            </strong>
            <table class="reply-table">
                <c:if test="${replyCount eq 0}">
                    <tr>
                        <td colspan = "2">
                            답글이 존재하지 않습니다
                        </td>
                    </tr>
                </c:if>
                <c:if test="${replyCount ne 0}">
                    <c:forEach var="replayDto" items="${replyDtos}">
                        <div class="reply <c:if test='${replayDto.reply_level == 1}'>reply-indent</c:if>">
                            <div class="meta">
                                작성자 : ${dto.author}
                                &nbsp;&nbsp;|&nbsp;&nbsp;
                                작성날짜 : <fmt:formatDate value="${replayDto.creation_date}" pattern="yyyy.MM.dd HH:mm"/>
                            </div>
                            <div class="title">
                                ${replayDto.reply_title}
                            </div>
                            <div class="content">
                                ${replayDto.reply_content}
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </table>

            <!-- 답글 작성 폼 -->
            <form action="${pageContext.request.contextPath}/board/reply/write" method="POST" class="mt-4" name="replyform">
                <input type="hidden" name="board_id" value="${board_id}">
                <input type="hidden" name="reply_level" value="0">
                <input type="hidden" name="pageNum" value="${pageNum}">
                <table class="table reply-table">
                    <thead>
                        <tr>
                            <strong style="display: block; margin-bottom: 10px;">답글 작성</strong>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2" class="small text-muted">
                                작성자: ${"User"} &nbsp;&nbsp;|&nbsp;&nbsp;
                                작성일자: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy.MM.dd HH:mm"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="text" name="reply_title" class="form-control" placeholder="제목을 입력해주세요">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea name="reply_content" class="form-control" placeholder="내용을 입력해주세요" rows="5" maxlength="250"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-end">
                                <button type="submit" name="submit" class="btn btn-primary">작성</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
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
    
    let replyform = document.querySelector( "form[name='replyform']" );
    replyform.addEventListener("submit", (event) => {
        let title = document.querySelector("input[name='reply_title']").value.trim();
        let content = document.querySelector("textarea[name='reply_content']").value.trim();
        let tag = /<[^>]*>/;

        if (!title) {
            alert("제목을 입력하세요");
            event.preventDefault();
            document.querySelector("input[name='reply_title']").focus();
        } else if (!content) {
            alert("답글 내용을 입력하세요");
            event.preventDefault();
            document.querySelector("textarea[name='reply_content']").focus();
        } else if (tag.test(title) || tag.test(content)) {
            alert("제목과 내용에 태그를 포함할 수 없습니다");
            event.preventDefault();
        }
    });

</script>

<%-- JSP에서 세션 값 삭제 (JavaScript 실행 이후) --%>
<% session.removeAttribute("deleteResult"); %>

<style>
    /* 기본 테이블 스타일 */
    .table {
        width: 100%;
        table-layout: fixed;
    }

    /* 페이지 레이아웃 */
    .board-detail-page {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
    }

    /* 제목 스타일 */
    .board-detail-page h3 {
        text-align: center;
        margin: 20px 0;
        font-weight: bold;
    }

    th.title {
        font-size: 1.4rem;
        font-weight: bold;
    }

    /* 게시글 내용 스타일 */
    td.content {
        min-height: 100px;
        height: 100px;
        padding: 10px;
        word-wrap: break-word;
        vertical-align: top;
    }

    /* 답글 영역 */
    .reply-section {
        margin-top: 20px;
        margin-bottom: 30px;
    }

    .reply-section span {
        font-size: 1.2rem;
        font-weight: normal;
        color: #666;
        margin-bottom: 10px;
    }

    .reply-table {
        width: 100%;
        margin-top: 10px;
        border-top: 1px solid #ccc;
        padding-top: 10px;
    }

    .reply {
        border-top: 1px solid #eee;
        padding: 10px 0;
    }

    .reply.reply-indent {
        margin-left: 20px;
    }

    .reply .meta {
        font-size: 12px;
        color: #666;
    }

    .reply .title {
        font-weight: bold;
        margin-top: 5px;
    }

    .reply .content {
        margin-top: 3px;
    }

    /* 버튼 그룹 */
    .button-group {
        margin-top: 30px;
    }

    .form-control{
        box-shadow: none !important;
    }
    .reply-table textarea {
    resize: none !important;
    }
</style>

