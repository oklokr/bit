<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>main</title>
    <script src="/js/common.js"></script>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/reset.css">
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <jsp:include page="header.jsp" />
    
    <div id="app">
        <jsp:include page="${contentPage}" />
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>

<style>
    #app {
        min-height: calc(100vh - 116px);
    }
</style>