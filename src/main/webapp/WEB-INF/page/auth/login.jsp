<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    로그인페이지
</div>

<style>
    body {
            margin: 0;
            height: 100vh; /* 뷰포트 높이 100% */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 헤더, 콘텐츠, 푸터를 수직으로 배치 */
            align-items: center; /* 수평 중앙 정렬 */
            font-family: Arial, sans-serif;
    }
    table {
            border-collapse: collapse;
            border: 1px solid rgb(13, 125, 177);
            margin: 0 auto;
        }

    th, td{
        border: 1px solid black
        padding 15px;
        text-align: center;
    }

    th{
        width : 80px;
    }

    td{
        width : 200px;
    }

    .input {
        width : 100%
        padding 5px;
        box-sizing: border-box;
        border: 1px solid black;
    }

    .inputbutton {
        padding: 8px 15px;
            border: 1px solid rgb(122, 122, 122)
            cursor pointer;
            box-sizing: border-box;
        }
        .inputbutton[type="submit"] {
            background-color: #d3d3d3;
            width: 100%;
            box-sizing: border-box;
        }
        .inputbutton[type="button"] {
            background-color: #f0f0f0;
            display: inline-block;
            margin: 5px;
        }

        .logo {
            width: 50px;
            height: auto;
        }
        /* 링크 스타일 */
        .link-group {
            display: flex;
            justify-content: center;
            gap: 10px; /* 링크 간 간격 */
        }
        .link-group a {
            color: #0000EE; /* 기본 파란색 */
            text-decoration: underline; /* 밑줄 추가 */
            cursor: pointer;
        }
        .link-group a:hover {
            color: #FF0000; /* 마우스 오버 시 빨간색 */
        }
        .link-group span {
            color: #000; /* 구분선 색상 */
        }
</style>
<form name="login" method="post">
    <table>
        <tr>
            <th colspan="2" style="text-align: center;">
                <img src="/images/icons/logoEx.png" class="logo">
            </th>
        </tr>
        <tr>
            <th style="text-align: left;">ID</th>
            <td><input class="input" type="text" name="id" maxlength="15" autofocus placeholder="아이디를 입력하세요." autofocus></td>
        </tr>
        <tr>
            <th style="text-align: left;">PW</th>
            <td><input class="input" type="password" name="passwd" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
        </tr> 
        <tr>
            <td colspan="2" style="text-align: center;">
                <input class="inputbutton" type="submit" value="로그인">
            </td>
        </tr>
        <tr>
            <td class="link-group">
                <a href="http://localhost:8080/findId">아이디 찾기</a>
                <a href="http://localhost:8080/findPw">비밀번호 찾기</a>
                <a href="http://localhost:8080/join">회원가입</a>
            </td>
        </tr>
    </table>
</form>