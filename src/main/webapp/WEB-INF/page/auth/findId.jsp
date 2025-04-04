<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    findId
</div>

<script>
    // 공통 유효성 검사 함수
    const validate = {
        isEmpty: value => {
            return value === null || value === undefined || value.trim() === '';
        },
        isEmail: value => {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(value);
        },
        isPhoneNumber: value => {
            const phoneRegex = /^\d{10,11}$/; // 한국 전화번호 형식 (10~11자리 숫자)
            return phoneRegex.test(value);
        }
    };

    // 폼 유효성 검사 함수
    function validateForm() {
        // 오류 메시지 초기화
        clearErrors();

        // 업체명 검사
        const companyName = document.forms["findId"]["companyName"].value;
        if (validate.isEmpty(companyName)) {
            document.getElementById("companyNameError").textContent = "업체명을 입력해주세요.";
            return false;
        }

        // 인증 방법 검사
        const certification = document.forms["findId"]["certification"];
        let certificationValue = '';
        if (certification[0].checked) {
            certificationValue = 'email';  // 이메일
        } else if (certification[1].checked) {
            certificationValue = 'phone';  // 휴대폰
        }

        if (validate.isEmpty(certificationValue)) {
            document.getElementById("certificationError").textContent = "인증 방법을 선택해주세요.";
            return false;
        }

        // 인증값 검사
        const certificationInputValue = document.forms["findId"]["certificationValue"].value;
        if (validate.isEmpty(certificationInputValue)) {
            document.getElementById("certificationValueError").textContent = "인증값을 입력해주세요.";
            return false;
        }

        // 인증값 형식 검증
        if (certificationValue === 'email' && !validate.isEmail(certificationInputValue)) {
            document.getElementById("certificationValueError").textContent = "올바른 이메일 형식이 아닙니다.";
            return false;
        }

        if (certificationValue === 'phone' && !validate.isPhoneNumber(certificationInputValue)) {
            document.getElementById("certificationValueError").textContent = "올바른 전화번호 형식이 아닙니다.";
            return false;
        }

        // 모든 검사 통과 시 폼 전송
        return true;
    }

    // 오류 메시지 초기화 함수
    function clearErrors() {
        document.getElementById("companyNameError").textContent = "";
        document.getElementById("certificationError").textContent = "";
        document.getElementById("certificationValueError").textContent = "";
    }
</script>
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
        td.button-td {
        display: flex;
        justify-content: space-between;  /* 버튼들을 가로로 배치하고 좌우 여백을 균등하게 설정 */
        align-items: center;  /* 버튼들이 수직으로 가운데 정렬 */
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
               <input style="font-size : 16px;" class="input" type="text" maxlength="30" autofocus placeholder="value를 입력해주세요" >
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                <input class="inputbutton" type="button" value="이전" onclick="location='/login'">
                <input class="inputbutton" type="submit" value="확인">
            </td>
        </tr>
    </table>
</form>
