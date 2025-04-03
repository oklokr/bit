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
    <div style="display: none;">
        넘어와야 되는 값: 
        board_count 총 글 개수
        number 출력용 글번호
        count 전체 글 개수
        dtos dto list
    </div>

    <div>
        <c:set var="count" value="0" />
    </div>

    <div class="board-page countainer">
        <h3> 자유게시판 </h3>
        <br>
        
        ${count}개
        <input class="btn btn-primary" type="button" value="글쓰기"/>

        ${str_num}
        <table class="table">
            <tr>
                <th>No</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:if test="${count eq 0}">
                <tr>
                    <td colspan = "5">자유게시판 글이 존재하지 않습니다</td>
                </tr>

            </c:if>
            <!--
            <c:if test="${count ne 0}">
                <c:set var="number" value="${number}"/>
                <c:foreach var="dto" items="${dtos}">
                    <tr>
                        <td>
                            ${number}
                            <c:set var="number" value="${number-1}"/>
                        </td>
                        <td>
                            <a href="board/detail?id=${dto.id}&pageNum=${pageNum}&number=${number+1}">
                                ${dto.title}
                            </a>
                        </td> 
                        <td>
                            ${dto.author}
                        </td>
                        <td>
                            ${dto.creation_date}
                        </td>
                        <td>
                            ${dto.view_count}
                        </td>
                    </tr>
                </c:foreach>
            </c:if>
        -->
        </table>
    </div>
</body>
</html>

<style>
    .board-page {
        margin: 20px; /* 바깥 여백 */
        padding: 20px; /* 안쪽 여백 */
    }

    .btn.btn-primary {
        float: right;
        margin: 10px; /* 버튼 바깥 여백 */
    }

    .table {
        margin-top: 10px; /* 위쪽 여백 */
        margin-bottom: 20px; /* 아래쪽 여백 */
        padding: 10px;
    }

    .board-page h3 {
        text-align: center;
        margin: 20px 0; /* 위아래 여백 */
        align-items: center;
        font-weight: bold;
    }
</style>