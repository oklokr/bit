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


    <div class="board-edit-page container">
        <h3> 자유게시판 게시글 작성</h3>
        <br>
        <form name="writeform" method="post" action="board/write">
            <table class="table">
                <tr>
                    <th colspan="2">
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">제목</span>
                            <input type="text" class="form-control" name = "title" aria-label="Username" aria-describedby="basic-addon1">
                          </div>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <jsp:useBean id="now" class="java.util.Date"/>
                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="today"/>
                        <div class="input-group">
                            <span class="input-group-text" id="basic-addon1">작성자</span>
                            <input type="text" class="form-control" placeholder="작성자" name="author" aria-label="Username" aria-describedby="basic-addon1" readonly>
                            <span class="input-group-text" id="basic-addon1">작성일</span>
                            <input type="text" class="form-control" placeholder="${today}" aria-label="Username" aria-describedby="basic-addon1" readonly>
                        </div>
                    </th>

                </tr>
            </table>

            <div id ="editor">
                <p>글을 작성하세여 </p>
            </div>

            <table class="table">
                <!-- 버튼 그룹 -->
                <div class="button-group d-flex">
                    <div class="ms-auto">
                        <button type="button" class="btn btn-primary" onclick="submitPost()">작성</button>
                        <button type="reset" class="btn btn-primary">취소</button>
                    </div>
                </div>
            </table>
        </form>
    </div>
</body>
</html>

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

    .board-edit-page h3 {
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
<script>
    const quill=new Quill('#editor',{
        theme: 'snow'
    })

    function submitPost(){
        const content = quill.root.innerHTML;
        
        console.log("글 내용:", content);
        
        axios.post('/board/detail', {content:content})
            .then(response => {
                alert('게시글 저장 성공!');
                window.location.href="/board/list";
            })
            .catch(error=>{
                console.error('Error:' , error);
                alert('게시글 저장 실패');
            })
    }

</script>