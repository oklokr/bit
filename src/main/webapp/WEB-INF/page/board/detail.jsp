<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
    

    <div class="board-detail-page container">
        <h3> 자유게시판</h3>
        <br>
        <table class="table">
            <tr>
                <th colspan="2" class="title">${boardDto.title}</th>
            </tr>
            <tr>
                <td>작성자 : ${boardDto.author}</td>
                <td>작성날짜 : <fmt:formatDate value="${boardDto.creationDate}" pattern="yyyy-MM-dd HH:mm"/></td>
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
                    <c:forEach var="replyDto" items="${replyDtos}">
                        <div class="reply <c:if test='${replyDto.replyLevel == 1}'>reply-indent</c:if>">
                            <div class="meta d-flex justify-content-between align-items-center">
                                <div>
                                    작성자 : ${replyDto.author}
                                    &nbsp;&nbsp;|&nbsp;&nbsp;
                                    작성날짜 : <fmt:formatDate value="${replyDto.creationDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </div>
                                
                                <c:if test="${replyDto.replyLevel == 0}">
                                    <button class="btn btn-sm btn-outline-secondary py-0 px-2" 
                                            style="font-size: 0.75rem;" 
                                            onclick="nestedReplyForm('${replyDto.replyRef}')">답글</button>
                                </c:if>
                            </div>
                            <div class="title">
                                ${replyDto.replyTitle}
                            </div>
                            <div class="content">
                                ${replyDto.replyContent}
                            </div>
                        </div>
                        <!-- 대댓글 작성 -->
                        <div id="reply-form-${replyDto.replyRef}" class="reply-form nested-reply-form mt-2" style="display: none;">
                            <form action="${pageContext.request.contextPath}/board/reply/write" method="post" name="replyform">
                                <input type="hidden" name="boardId" value="${boardId}">
                                <input type="hidden" name="replyLevel" value="1">
                                <input type="hidden" name="pageNum" value="${pageNum}">
                                <input type="hidden" name="replyRef" value="${replyDto.replyRef}" />
                        
                                <div class="small text-muted mb-2">
                                    작성자: ${"User"} &nbsp;&nbsp;|&nbsp;&nbsp;
                                    작성일자: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy.MM.dd HH:mm"/>
                                </div>
                        
                                <div class="mb-2">
                                    <input type="text" name="replyTitle" class="form-control" placeholder="제목을 입력해주세요">
                                </div>
                        
                                <div class="mb-2">
                                    <textarea name="replyContent" class="form-control" placeholder="내용을 입력해주세요" rows="5" maxlength="250"></textarea>
                                </div>
                        
                                <div class="text-end">
                                    <button type="submit" name="submit" class="btn btn-sm btn-secondary">답글 작성</button>
                                </div>
                            </form>
                        </div>

                    </c:forEach>
                </c:if>
            </table>

            <!-- 답글 작성 폼 -->
            <form action="${pageContext.request.contextPath}/board/reply/write" method="POST" class="mt-4" name="replyform">
                <input type="hidden" name="boardId" value="${boardId}">
                <input type="hidden" name="replyLevel" value="0">
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
                                <input type="text" name="replyTitle" class="form-control" placeholder="제목을 입력해주세요">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea name="replyContent" class="form-control" placeholder="내용을 입력해주세요" rows="5" maxlength="250"></textarea>
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
                onclick="location='/board/edit?boardId=${boardId}&result=${-1}&pageNum=${pageNum}'">수정</button>
                <button class="btn btn-primary"
                onclick="location='/board/delete?boardId=${boardId}&pageNum=${pageNum}'">삭제</button>
            </div>
        </div>
    
    </div>


</body>
</html>

<script>
    window.onload = function() {
        const deleteResult = "${deleteResult}";
        if (deleteResult === "1" || deleteResult === "0") {
            showResultModal(
                deleteResult,
                "처리 결과",
                "게시글이 삭제되었습니다.",
                "게시글 삭제에 실패했습니다.",
                function() {
                    location.href = "/board?pageNum=${pageNum}";
                },
                null // 또는 그냥 생략 가능
            );
        }
    }
    
    let replyform = document.querySelector("form[name='replyform']");
    replyform.addEventListener("submit", (event) => {
        let title = document.querySelector("input[name='replyTitle']").value.trim();
        let content = document.querySelector("textarea[name='replyContent']").value.trim();
        let tag = /<[^>]*>/;

        if (!title) {
            event.preventDefault();
            showResultModal(
                "0",
                "입력 오류",
                "",
                "제목을 입력하세요.",
                function() {
                    document.querySelector("input[name='replyTitle']").focus();
                }
            );
        } else if (!content) {
            event.preventDefault();
            showResultModal(
                "0",
                "입력 오류",
                "",
                "답글 내용을 입력하세요.",
                function() {
                    document.querySelector("textarea[name='replyContent']").focus();
                }
            );
        } else if (tag.test(title) || tag.test(content)) {
            event.preventDefault();
            showResultModal(
                "0",
                "입력 오류",
                "",
                "제목과 내용에 태그를 포함할 수 없습니다.",
                null
            );
        }
    });

    function nestedReplyForm(replyId) {
        const form = document.getElementById('reply-form-' + replyId);
        if (form.style.display === 'none') {
            form.style.display = 'block';
        } else {
            form.style.display = 'none';
        }
    }

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

    .nested-reply-form {
    margin-left: 20px;       /* 댓글보다 오른쪽으로 들여쓰기 */
    padding: 10px;
    font-size: 0.95rem;       /* 글자도 살짝 작게 */
    margin-bottom: 20px;
}
</style>

