<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    로그인페이지
</div>

<form name="login" method="post">
    <table>
        <tr>
            <th colspan="2" style="text-align: center;">
                <img src="/images/icons/logoEx.png" style="width: 50px; height: auto;" >
            </th>
        </tr>
        <tr>
            <th>ID</th>
            <td><input class="input" type="text" name="id" maxlength="15" autofocus></td>
        </tr>
        <tr>
            <th>PW</th>
            <td><input class="input" type="password" name="passwd" maxlength="20"></td>
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