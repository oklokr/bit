<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    로그인페이지
</div>

<form name="login" method="post">
    <table>
        <td>
            <th  style="text-align: center;">
                Logo(이미지 대처 이미지 넣을 img/src 아래 이미지 폴더 필요)
            </th>
        </tr>
        <tr>
            <th>ID</th>
            <td> <input class="input" type="text" name="id" maxlength="15" autofocus> </td>
        </tr>
        <tr>
            <th>PW</th>
            <td> <input class="input" type="password" name="passwd" maxlength="20"> </td>
        </tr>
        <tr>
            <th style="text-align: center;">
                <input class="inputbutton" type="submit" value="로그인">
            </th>
        </tr>
        <tr>
            <th colspan="3">
                <input class="inputbutton" type="button" value="아이디찾기">
                <input class="inputbutton" type="button" value="비밀번호찾기">
                <input class="inputbutton" type="button" value="회원가입">
            </th>
        </tr>
    </table>
</form>