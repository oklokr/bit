<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    findId
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

<form name="findId" method="post">
    <table>
        <tr>
            <th style="padding-top: 10px;"> 아이디찾기 </th>
        </tr>
        <tr>
            <td>
                업체명 
                <input class="input" type="text" name="company_name" maxlength="15" autofocus placeholder="업체명을 입력해주세요."> 
            </td>
        </tr>
        <tr>
            <td style="font-size : 12px;"> 
                인증방법
               <input type="radio" name="certification" value="1" 이메일> 이메일
               <input type="radio" name="certification" value="2" 휴대폰> 휴대폰
               <input style="font-size : 20px;" class="input" type="text" name="company_name" maxlength="15" autofocus placeholder="value를 입력해주세요" >
            </td>
        </tr>
    </table>
</form>