<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    로그인페이지
</div>
<div style="color: red; text-align: center;">
    <c:if test="${not empty errorMessage}">
        ${errorMessage}
    </c:if>
</div>
<style>
    body {
            margin: 0;
            height: 100vh; 
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            font-family: Arial, sans-serif;
    }
    table {
            border-collapse: collapse;
            border: 2px solid rgb(13, 125, 177);
            margin: 0 auto;
        }

    th, td{
        border: 1px solid black
        padding-top 10px;
        padding-bottom : 20px;
        padding-left : 10px;
        padding-right : 10px;

        text-align: center;
    }

    th{
        width: 60px;
    }

    td{
        width : 150%;
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
            width: 50%;
            height: 50%;
            margin : 5px;
            box-sizing : border-box;
        }

        .logo {
            width: 50px;
            height: auto;
        }

        .link-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            font-size : 12px;
            width : 100%;
            white-space: nowrap;
            margin: 5px;
        }
        .link-group a {
            color: #000000;
            text-decoration: underline;
            cursor: pointer;
        }
        .link-group a:hover {
            color: #FF0000;
        }
</style>
<form name="login" method="post">
    <table>
        <tr>
            <th colspan="2" style="text-align: center;">
                <img src="/images/logo.png" class="logo">
            </th>
        </tr>
        <tr>
            <td> ID <input class="input" type="text" name="id" maxlength="15" autofocus placeholder="아이디를 입력해주세요."></td>
        </tr>
        <tr>
            <td> PW <input class="input" type="password" name="password" maxlength="20" placeholder="비밀번호를 입력해주세요."></td>
        </tr> 
        <tr>
            <td colspan="2" style="text-align: center;">
                <input class="inputbutton" type="submit" value="로그인">
            </td>
        </tr>
        <tr>
            <td class="link-group" style="text-align: center;">
                <a href="http://localhost:8080/findId">아이디찾기</a>
                <a href="http://localhost:8080/findPw">비밀번호찾기</a>
                <a href="http://localhost:8080/join">회원가입</a>
            </td>
        </tr>
    </table>
</form>