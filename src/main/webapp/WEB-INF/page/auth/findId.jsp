<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    function updatePlaceholder() {
        const certValueInput = document.querySelector('input[name="cert_value"]');
        const selectedCert = document.querySelector('input[name="certification"]:checked');
        // cert_value 입력 필드가 존재하는지 확인
        if (!certValueInput) {
            console.error('cert_value input field not found');
            return;
        }
        
        if (selectedCert) {
            // 인증 방법에 따라 placeholder를 업데이트
            if (selectedCert.value === "1") {
                certValueInput.placeholder = "이메일을 입력해주세요";
            } else if (selectedCert.value === "2") {
                certValueInput.placeholder = "휴대폰 번호를 입력해주세요";
            }
        }
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
            <td style="font-size: 12px;">
                    인증방법
                    <input type="radio" name="certification" value="1" onclick="updatePlaceholder()"> 이메일
                    <input type="radio" name="certification" value="2" onclick="updatePlaceholder()"> 휴대폰
            </td>
        </tr>
        <tr>
            <td id="emailField" style="display: none;">
                <input class="input" type="text" name="email1" maxlength="20" style="width: 100px;">
                @
                <select name="email2">
                    <option value="1">직접입력</option>
                </select>
            </td>
        </tr>
        <tr>
            <td id="phoneField" style="display: none;">
                <input class="input" type="text" name="tel1" maxlength="3" style="width: 30px;">
                - 
                <input class="input" type="text" name="tel2" maxlength="4" style="width: 38px;">
                - 
                <input class="input" type="text" name="tel3" maxlength="4" style="width: 38px;">
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
