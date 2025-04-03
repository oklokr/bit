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
    <div class="board-edit-page container">
        <h3> 자유게시판 게시글 작성 / 수정</h3>
        <br>
        <table class="table">
            <tr>
                <th colspan="2">
                    <input class="form-control form-control-lg" type="text" placeholder="원래 제목" name="title" maxlength="100">

                </th>
            </tr>
            <tr>
                <td>작성자 : dto.author</td>
                <td>작성날짜 : dto.create_date</td>
            </tr>
        </table>

        <div id ="editor">
            <p>글을 작성하세여 </p>
        </div>

        <table class="table">
            <!-- 버튼 그룹 -->
            <div class="button-group d-flex">
                <div class="ms-auto">
                    <button class="btn btn-primary" onclick="submitPost()">작성</button>
                    <button class="btn btn-primary">취소</button>
                </div>
            </div>
        </table>
        
    </div>
</body>
</html>

<style>
    .table {
        width: 100%;
        table-layout: fixed; /* 고정 레이아웃 */
        border-color:#fff
    }
    
    .board-edit-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        padding: 20px;
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