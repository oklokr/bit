<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    function updatePlaceholder() {
        const certValueInput = document.querySelector('input[name="cert_value"]');
        const selectedCert = document.querySelector('input[name="certification"]:checked');
        const emailField = document.getElementById('emailField');
        const phoneField = document.getElementById('phoneField');

        if (selectedCert) {
            certValueInput.value = selectedCert.value;

            if (selectedCert.value === "1") {
                emailField.style.display = "block";
                phoneField.style.display = "none";
            } else if (selectedCert.value === "2") {
                emailField.style.display = "none";
                phoneField.style.display = "block";
            }
        }
    }
    async function sendCompanyName(event) {
    event.preventDefault(); // 폼의 기본 제출 동작을 막음

    const companyNameInput = document.querySelector('input[name="company_name"]');
    const companyName = companyNameInput.value.trim();

    if (!companyName) {
        alert("업체명을 입력해주세요.");
        return;
    }

    try {
        const response = await fetch('/findId', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json' // JSON 형식으로 요청
            },
            body: JSON.stringify({ company_name: companyName }) // JSON 데이터
        });

        if (!response.ok) {
            throw new Error(`서버 오류: ${response.status}`);
        }

        const result = await response.json();

        if (result.success) {
            // 성공 시 아이디를 alert 창에 출력
            alert(`아이디: ${result.id}`);
        } else {
            // 실패 시 에러 메시지를 alert 창에 출력
            alert(result.message || "일치하는 정보가 없습니다.");
        }
    } catch (error) {
        console.error("API 호출 중 오류 발생:", error);
        alert("서버와 통신 중 오류가 발생했습니다.");
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
            width : 150%;
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
        width: 100%;
        padding : 5px;
        box-sizing: border-box;
        border: 1px solid black;
        text-align: center;
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
</style>

<form name="findId" onsubmit="sendCompanyName(event)">
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
            <td>
                인증방법
                <input type="radio" name="certification" value="1" onclick="updatePlaceholder()"> 이메일
                <input type="radio" name="certification" value="2" onclick="updatePlaceholder()"> 휴대폰
            </td>
        </tr>
        <tr id="emailField" style="display: none;">
            <td>
                이메일 <input class="input" type="text" name="email" maxlength="30" style="width: 150px; font-size: 12px;">
            </td>
        </tr>
        <tr id="phoneField" style="display: none;">
            <td>
                휴대폰
                <input class="input" type="text" name="tel1" maxlength="3" style="width: 38px;">
                - 
                <input class="input" type="text" name="tel2" maxlength="4" style="width: 46px;">
                - 
                <input class="input" type="text" name="tel3" maxlength="4" style="width: 46px;">
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" name="cert_value" value="">
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
