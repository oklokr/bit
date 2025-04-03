<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            margin: 0;
            height: 100vh; /* 뷰포트 높이 100% */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 헤더, 콘텐츠, 푸터를 수직으로 배치 */
            align-items: center; /* 수평 중앙 정렬 */
            font-family: Arial, sans-serif;
        }

        /* 헤더 스타일 */
        header {
            width: 100%;
            text-align: center;
            padding: 20px 0;
            background-color: #f0f0f0;
        }

        /* 푸터 스타일 */
        footer {
            width: 100%;
            text-align: center;
            padding: 20px 0;
            background-color: #f0f0f0;
        }

        /* 메인 콘텐츠 스타일 */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1; /* 남은 공간을 채움 */
        }

        /* 테이블 스타일 */
        table {
            border-collapse: collapse;
            border: 1px solid rgb(13, 125, 177);
            margin: 0 auto;
        }
        th, td {
            border: 1px solid black;
            padding: 15px; /* 패딩을 늘려 셀 크기 키움 */
            text-align: center;
        }
        th {
            width: 100px; /* ID, PW 라벨 너비 증가 */
        }
        td {
            width: 300px; /* 입력 필드 너비 증가 */
        }

        /* 입력 필드 스타일 */
        .input {
            width: 100%;
            padding: 8px; /* 입력 필드 패딩 증가 */
            box-sizing: border-box;
            border: 1px solid black;
        }

        /* 버튼 스타일 */
        .inputbutton {
            padding: 8px 15px; /* 버튼 크기 증가 */
            border: 1px solid black;
            cursor: pointer;
            margin: 5px;
        }
        .inputbutton[type="submit"] {
            background-color: #d3d3d3;
            width: 100%;
            box-sizing: border-box;
        }
        .inputbutton[type="button"] {
            background-color: #f0f0f0;
        }

        /* 로고 스타일 */
        .logo {
            width: 150px; /* 로고 크기 증가 */
            height: auto;
        }
    </style>
</head>
<body>
    <header>
        <h1>Login Page</h1>
    </header>

    <div class="container">
        <form name="login" method="post">
            <table>
                <tr>
                    <th colspan="2">
                        <img src="/images/icons/logoEx.png" alt="Logo" class="logo">
                    </th>
                </tr>
                <tr