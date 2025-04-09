<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form name="joinResult">
    <table>
        <tr>
            <th colspan="2" style="text-align: center;">
                <img src="/images/logo.png" class="logo">
            </th>
        </tr>
        <tr>
            <td font-size="30px">
                환영합니다! ${companyName}님<br>
                회원 가입이 완료되었습니다!
            </td>
        </tr>
        <tr>
            <td>
              <button type="button" onclick="location='/login'">확인</button>
            </td>
        </tr>    
    </table>
</form>
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
            width : 200%;
            height: 300;
        }

    th, td{
        padding-top : 10px;
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
        width: 100%;
        padding : 5px;
        box-sizing: border-box;
        border: 1px solid black;
        text-align: center;
            }

    .inputbutton {
        padding: 8px 15px;
            border: 1px solid rgb(122, 122, 122);
            cursor : pointer;
            box-sizing: border-box;
            width : 40%;    
            text-align: center;
        }
        .inputbutton[type="submit"] {
            background-color: #d3d3d3;
            width: 40%;
            box-sizing: border-box;
            margin : 5px;
        }
        .inputbutton[type="button"] {
            background-color: #d3d3d3;
            display: inline-block;
            width: 40%;
            margin: 5px;
            box-sizing: border-box;
        }

        .logo {
            width: 150px;
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
        td.button-td {
        display: flex;
        justify-content: space-between;  /* 버튼들을 가로로 배치하고 좌우 여백을 균등하게 설정 */
        align-items: center;  /* 버튼들이 수직으로 가운데 정렬 */
        }
            /* 이메일 입력 필드와 전화번호 입력 필드 스타일 수정 */
    #emailField, #phoneField {
        text-align: center; /* 입력 필드를 테이블에서 중앙 정렬 */
        width: 100%; /* 테이블 너비에 맞게 확장 */
    }

    #emailField input, #phoneField input {
        width: 80%; /* 입력 필드 너비를 제한 */
        display: inline-block;
    }

    #phoneField input {
        width: 30%; /* 전화번호 각 입력칸의 너비 */
    }
    .steps {
        display: flex;
        justify-content: center;
        align-items: center; /* 세로 가운데 정렬 */
        margin-bottom: 20px;
    }
    .step {
        width: 20px; /* 크기 줄임 */
        height: 20px; /* 크기 줄임 */
        line-height: 20px; /* 텍스트 가운데 정렬 */
        text-align: center;
        border: 2px solid #007bff; /* 테두리 색상 */
        border-radius: 50%; /* 동그라미 모양 */
        margin: 0 5px;
        font-size: 12px; /* 텍스트 크기 줄임 */
        color: #007bff; /* 텍스트 색상 */
        background-color: white; /* 배경색 */
        font-weight: bold;
    }
    .step.active {
        background-color: #007bff; /* 활성화된 단계 배경색 */
        color: white; /* 활성화된 단계 텍스트 색상 */
    }
</style>