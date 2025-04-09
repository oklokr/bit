<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board_write</title>
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

    <div class="board-write-page container">
        <h3> 자유게시판 게시글 작성</h3>
        <br>
        <form name="writeform" method="POST" action="/board/write">
            <input type="hidden" name="title" id="title">
            <input type="hidden" name="content" id="content">
            <input type="hidden" name="author" id="author">
            
            <table class="table">
                <tr>
                    <th colspan="2">
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">제목</span>
                            <input type="text" class="form-control" name="titleInput" aria-label="Username" aria-describedby="basic-addon1">
                        </div>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="today"/>
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">작성자</span>
                            <input type="text" class="form-control" placeholder="${user}" name="authorInput" aria-label="Username" aria-describedby="basic-addon1" readonly>
                            <span class="input-group-text" id="basic-addon1">작성일</span>
                            <input type="text" class="form-control" placeholder="${today}" aria-label="Username" aria-describedby="basic-addon1" readonly>
                        </div>
                    </th>
                </tr>
            </table>

            <div id="editor">
            </div>
        </form>
        
        <!-- 버튼 그룹 -->
        <div class="button-group d-flex">
            <div class="ms-auto">
                <button type="button" name="submit" class="btn btn-primary">작성</button>
                <button type="reset" class="btn btn-primary" onclick="location='/board'">취소</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const quill = new Quill('#editor', {
        theme: 'snow'
    });

    let submit = document.querySelector("button[name='submit']");
    
    submit.addEventListener("click", (event) => {
        event.preventDefault();  // 무조건 먼저 막아주고

        let title = document.querySelector("input[name='titleInput']").value.trim();
        let content = quill.root.innerHTML.trim();
        let tag = /<[^>]*>/;

        if (!title) {
            showResultModal(
                "0",
                "입력 오류",
                "",
                "제목을 입력하세요.",
                () => document.querySelector("input[name='titleInput']").focus()
            );
            return;
        }

        if (!content || content === "<p><br></p>") {
            showResultModal(
                "0",
                "입력 오류",
                "",
                "게시글 내용을 입력하세요.",
                null
            );
            return;
        }

        if (tag.test(title)) {
            showResultModal(
                "0",
                "입력 오류",
                "",
                "제목에 태그를 포함할 수 없습니다.",
                () => document.querySelector("input[name='titleInput']").focus()
            );
            return;
        }

        // 모든 유효성 검사를 통과한 경우에만 제출
        submitPost();
    });

    function submitPost() {
        const content = quill.root.innerHTML;
        const title = document.querySelector('input[name="titleInput"]').value;
        const author = document.querySelector('input[name="authorInput"]').value;
        
        // 숨겨진 input에 값 설정
        document.querySelector('#title').value = title;
        document.querySelector('#content').value = content;
        document.querySelector('#author').value = author;

        // 폼 제출
        document.writeform.submit();
    }

    window.onload = function() {
        const writeResult = "${writeResult}";
        if (writeResult === "1" || writeResult === "0") {
            showResultModal(
                writeResult,
                "처리 결과",
                "게시글이 작성되었습니다.",
                "게시글 작성에 실패했습니다.",
                function() {
                    location.href = "/board";
                },
                null // 또는 그냥 생략 가능
            );
        }
    }
</script>

<% session.removeAttribute("writeResult"); %>

<style>
    .table {
        width: 100%;
        table-layout: fixed; /* 고정 레이아웃 */
        border-color:#fff;
    }
    
    .board-write-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        background: #fff; /* 배경 흰색 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .board-write-page h3 {
        text-align: center;
        margin: 20px 0; /* 위아래 여백 */
        align-items: center;
        font-weight: bold;
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
