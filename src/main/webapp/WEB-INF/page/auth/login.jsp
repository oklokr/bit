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
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        /* 테이블 스타일 */
        table {
            border-collapse: collapse;
            border: 1px solid rgb(13, 125, 177);
            margin: 0 auto;
        }
        th, td {
            border: 1px solid black;
            padding: 15px;
            text-align: center;
        }
        th {
            width: 100px; /* ID, PW 라벨 너비 */
        }
        td {
            width: 300px; /* 입력 필드 너비 */
        }

        /* 입력 필드 스타일 */
        .input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid black;
            font-size: 14px;
        }

        /* 버튼 스타일 */
        .inputbutton {
            padding: 8px 15px;
            border: 1px solid black;
            cursor: pointer;
            margin: 5px;
            font-size: 14px;
        }
        .inputbutton[type="submit"] {
            background-color: #d3d3d3; /* 회색 배경 */
            width: 100%;
            box-sizing: border-box;
        }
        .inputbutton[type="button"] {
            background-color: #f0f0f0; /* 연한 회색 배경 */
        }

        /* 로고 스타일 */
        .logo {
            width: 100px;
            height: auto;
        }
    </style>
</head>
<body>
    <form name="login" method="post">
        <table>
            <tr>
                <th colspan="2">
                    <img src="/images/icons/logoEx.png" class="logo">
                </th>
            </tr>
            <tr>
                <th>ID</th>
                <td><input class="input" type="text" name="id" maxlength="15" placeholder="아이디를 입력하세요." autofocus></td>
            </tr>
            <tr>
                <th>PW</th>
                <td><input class="input" type="password" name="passwd" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input class="inputbutton" type="submit" value="로그인">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input class="inputbutton" type="button" value="아이디 찾기" onclick="location.href='http://localhost:8080/findId'">
                    <input class="inputbutton" type="button" value="비밀번호 찾기" onclick="location.href='http://localhost:8080/findPw'">
                    <input class="inputbutton" type="button" value="회원가입" onclick="location.href='http://localhost:8080/join'">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>