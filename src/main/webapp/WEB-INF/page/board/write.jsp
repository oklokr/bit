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
                            <input type="text" class="form-control" placeholder="작성자" name="authorInput" aria-label="Username" aria-describedby="basic-addon1" readonly>
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
                <button type="button" name="submit" class="btn btn-primary" onclick="submitPost()">작성</button>
                <button type="reset" class="btn btn-primary" onclick="location='/board'">취소</button>
            </div>
        </div>
    </div>

    <c:if test="${param.result == '0'}">
        <script>
            alert("게시글 작성에 실패했습니다.");
        </script>
    </c:if>

    <c:if test="${param.result == '1'}">
        <script>
            alert("게시글 작성에 성공했습니다.");
        </script>
        <meta http-equiv="refresh" content="0; url=/board">
    </c:if>

</body>
</html>

<script>
    const quill = new Quill('#editor', {
        theme: 'snow'
    });

    let submit = document.querySelector("button[name='submit']");
    
    submit.addEventListener("click", (event) => {
        let title = document.querySelector("input[name='titleInput']").value;
        let content = quill.root.innerHTML;
        let tag = /<[^>]*>/; 

        if (!title) {
            alert("제목을 입력하세요");
            event.preventDefault();
            document.querySelector("input[name='titleInput']").focus();
        } else if (!content.trim()) {
            alert("게시글 내용을 입력하세요");
            event.preventDefault();
        } else if (tag.test(title)) {
            alert("제목에 태그를 포함할 수 없습니다");
            event.preventDefault();
        } else {
            submitPost();  // 모든 검증 후 submitPost 함수 실행
        }
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

</script>

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
