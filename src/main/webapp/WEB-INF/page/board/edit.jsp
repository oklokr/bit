<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board_edit</title>
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

    <div class="board-edit-page container">
        <h3> 자유게시판 게시글 수정</h3>
        <br>
        <form name="editform" method="POST" action="/board/edit">
            <input type="hidden" name="title" id="title">
            <input type="hidden" name="content" id="content">
            <input type="hidden" name="pageNum" value="${pageNum}">
            <input type="hidden" name="boardId" value="${boardDto.boardId}">
            <table class="table">
                <tr>
                    <th colspan="2">
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">제목</span>
                            <input type="text" class="form-control" value="${boardDto.title}" name="titleInput" aria-label="Username" aria-describedby="basic-addon1">
                        </div>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="today"/>
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">작성자</span>
                            <input type="text" class="form-control" value="${boardDto.author}" aria-label="Username" aria-describedby="basic-addon1" readonly>
                            <span class="input-group-text" id="basic-addon1">작성일</span>
                            <input type="text" class="form-control" value="${boardDto.creationDate}" aria-label="Username" aria-describedby="basic-addon1" readonly>
                        </div>
                    </th>
                </tr>
            </table>

            <div id="editor">
                ${boardDto.content}
            </div>
        </form>
        
        <!-- 버튼 그룹 -->
        <div class="button-group d-flex">
            <div class="ms-auto">
                <button type="button" name="submit" class="btn btn-primary">수정</button>
                <button type="reset" class="btn btn-primary" onclick="location='/board/detail?boardId=${boardId}&pageNum=${pageNum}'">취소</button>
            </div>
        </div>
    </div>

</body>
</html>

<script>
    const quill = new Quill('#editor', {
        theme: 'snow',
        modules: {
            toolbar: [
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                ['bold', 'italic', 'underline', 'strike', 'link']
            ]
        }
    });

    window.onload = function() {
        const content = `${boardDto.content}`;  // 기존 게시글 내용
        quill.root.innerHTML = content; // Quill 에디터에 내용 삽입
        
        const editResult = "${editResult}";
        if (editResult == "1") {
            modal({
                content: "게시글이 수정되었습니다.",
                fnClose: () => {
                    location.href = "/board/detail?boardId=${boardId}&pageNum=${pageNum}";
                }
            });
        }
        if (editResult == "0") {
            modal({
                content: "게시글 수정에 실패했습니다."
            });
        }
    }

    document.querySelector('button[name="submit"]').addEventListener("click", function() {
        let title = document.querySelector("input[name='titleInput']").value.trim();
        let content = quill.getText().trim();  
        event.preventDefault();
        // 폼 검증
        if (!title) {
            modal({
                title: "입력 오류",
                content: "제목을 입력하세요.",
                type: "message",
                fnClose: function() {
                    document.querySelector("input[name='replyTitle']").focus();
                }
            });
            return;
        } else if (!content) {
            modal({
                title: "입력 오류",
                content: "답글 내용을 입력하세요.",
                type: "message",
                fnClose: function() {
                    document.querySelector("textarea[name='replyContent']").focus();
                }
            });
            return;
        }
        submitPost();
    });

    function submitPost() {
        const content = quill.root.innerHTML;
        const title = document.querySelector('input[name="titleInput"]').value;
        const boardId = "${boardDto.boardId}";
        document.querySelector('#title').value = title;
        document.querySelector('#content').value = content;
        document.forms["editform"].submit();
    }
</script>

<% session.removeAttribute("editResult"); %>

<style>
    .table {
        width: 100%;
        table-layout: fixed; /* 고정 레이아웃 */
        border-color:#fff;
    }
    
    .board-edit-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        background: #fff; /* 배경 흰색 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .button-group{
        margin-top: 10px;
    }
    .btn.btn-primary{
        width: 120px;
    }

    .form-control:focus {
        box-shadow: none !important; /* 부트스트랩 기본 효과 제거 */
    }

    #editor{
        height: 500px; /* 높이 조절 */
        padding: 10px;
    }

</style>