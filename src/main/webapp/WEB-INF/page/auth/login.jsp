<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    로그인페이지
</div>

<style>
    .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
    }
    table{
        border-collapse: collapse;
        border: 1px solid rgb(13, 125, 177)
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
            padding: 5px 10px;
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

        .logo {
            width: 50px;
            height: auto;
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
            <th>ID</th>
            <td><input class="input" type="text" name="id" maxlength="15" autofocus placeholder="아이디를 입력하세요."></td>
        </tr>
        <tr>
            <th>PW</th>
            <td><input class="input" type="password" name="passwd" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
        </tr> 
        <tr>
            <td colspan="2" style="text-align: center;">
                <input class="inputbutton" type="submit" value="로그인">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input class="inputbutton" type="button" value="아이디찾기" onclick="location.href='http://localhost:8080/findId'">
                <input class="inputbutton" type="button" value="비밀번호찾기" onclick="location.href='http://localhost:8080/findPw'">
                <input class="inputbutton" type="button" value="회원가입" onclick="location.href='http://localhost:8080/join'">
            </td>
        </tr>
    </table>
</form>