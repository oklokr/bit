<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main</title>
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/common.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <div class="error-page container">
        <h1>404 - Page Not Found</h1>
        <p>죄송합니다. 요청하신 페이지를 찾을 수 없습니다.</p>
        <a href="/main" class="btn btn-outline-secondary" role="button">홈으로 돌아가기</a>
    </div>
</body>
</html>

<style>
    .error-page.container {
        padding-top: 20vh;
        height: 100vh;
    }

    .error-page.container > p {
        display: block;
        width: 100%;
        text-align: center;
    }

    .error-page h1 {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .error-page h1::before {
        display: block;
        content: "";
        width: 120px;
        height: 120px;
        background: url('/images/icons/error.png') no-repeat center center;
        background-size: 100%;
    }
    .error-page .btn {
        display: block;
        width: fit-content;
        margin: 0 auto;
    }
</style>