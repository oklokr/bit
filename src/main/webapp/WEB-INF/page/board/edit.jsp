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
        <h3> 자유게시판 게시글 작성 / 수정정</h3>
        <br>
        <table class="table">
            <tr>
                <th colspan="2">dto.title</th>
            </tr>
            <tr>
                <td>작성자 : dto.author</td>
                <td>작성날짜 : dto.create_date</td>
            </tr>
        </table>

        <form name="editform" method="post" action="board/edit">
            <table>

                
            </table>

        </form>
    </div>
</body>
</html>

<style>
    .table {
        width: 100%;
        table-layout: fixed; /* 고정 레이아웃 */
    }
    
    .board-detail-page {
        max-width: 800px; /* 페이지 최대 너비 제한 */
        margin: 40px auto; /* 중앙 정렬 */
        padding: 20px;
        background: #fff; /* 배경 흰색 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .board-detail-page h3 {
        text-align: center;
        margin: 20px 0; /* 위아래 여백 */
        align-items: center;
        font-weight: bold;
    }

    td.content {
        min-height: 100px;
    }


</style>