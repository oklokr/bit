<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    findPw
</div>
<script>
    function updatePlaceholder() {
        const certValueInput = document.querySelector('input[name="cert_value"]');
        const selectedCert = document.querySelector('input[name="certification"]:checked');
        const emailField = document.getElementById('emailField');
        const phoneField = document.getElementById('phoneField');
        
        if (selectedCert) {
            // 이메일을 선택한 경우
            if (selectedCert.value === "1") {
                emailField.style.display = "block";
                phoneField.style.display = "none";
            }
            // 휴대폰을 선택한 경우
            else if (selectedCert.value === "2") {
                emailField.style.display = "none";
                phoneField.style.display = "block";
            }
        }
    }
    async function sendId(event) {
    event.preventDefault(); // 폼의 기본 제출 동작을 막음

    const idInput = document.querySelector('input[name="id"]');
    const selectedCert = document.querySelector('input[name="certification"]:checked');
    const certValueInput = document.querySelector('input[name="cert_value"]'); // 숨겨진 필드
    const id = idInput.value.trim();
    const certType = selectedCert ? selectedCert.value : null;

    let certValue = ""; // 인증 값 초기화

    if (!id) {
        alert("아이디를 입력해주세요.");
        return;
    }

    if (!certType) {
        alert("인증 방법을 선택해주세요.");
        return;
    }

    // 이메일 또는 전화번호 값 설정
    if (certType === "1") {
        const emailInput = document.querySelector('input[name="email"]');
        certValue = emailInput.value.trim();
    } else if (certType === "2") {
        const tel1 = document.querySelector('input[name="tel1"]').value.trim();
        const tel2 = document.querySelector('input[name="tel2"]').value.trim();
        const tel3 = document.querySelector('input[name="tel3"]').value.trim();

        // 전화번호 입력값 검증
        if (!tel1 || !tel2 || !tel3) {
            alert("휴대폰 번호를 모두 입력해주세요.");
            return;
        }

        certValue = tel1 + "-" + tel2 + "-" + tel3; // 전화번호를 합쳐서 설정
    }

    // 인증 값이 비어 있는지 확인
    if (!certValue) {
        alert(certType === "1" ? "이메일을 입력해주세요." : "휴대폰 번호를 입력해주세요.");
        return;
    }

    // 숨겨진 필드에 인증 값 설정
    certValueInput.value = certValue;

    console.log("전송 데이터:", { id: id, cert_type: certType, cert_value: certValue });

    try {
        const response = await fetch('/findPw', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json' // JSON 형식으로 요청
            },
            body: JSON.stringify({ id: id, cert_type: certType, cert_value: certValue }) // JSON 데이터
        });

        if (!response.ok) {
            throw new Error(`서버 오류: ${response.status}`);
        }

        const result = await response.json();

        console.log("서버 응답 데이터:", result);

        if (result.success) {
            // 성공 시 findPwResult 페이지로 이동
            const queryParams = 
                "?id=" + encodeURIComponent(id) +
                "&cert_type=" + encodeURIComponent(certType) +
                "&cert_value=" + encodeURIComponent(certValue) +
                "&password=" + encodeURIComponent(result.password);

            window.location.href = "/findPwResult" + queryParams;
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

<form name="findPw" onsubmit="sendId(event)">
    <table>
        <tr>
            <th style="padding-top: 10px;"> 비밀번호찾기 </th>
        </tr>
        <tr>
            <td>
                아이디
                <input class="input" type="text" name="id" maxlength="15" autofocus placeholder="아이디를 입력해주세요."> 
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
            <td id="emailField" style="display: none;" style="text-align: left;">
                이메일 <input class="input" type="text" name="email" maxlength="30" style="width: 150px;">
            </td>
        </tr>
        <tr>
            <td id="phoneField" style="display: none;" style="text-align: left;">
                휴대폰
                <input class="input" type="text" name="tel1" maxlength="3" style="width: 38px;">
                - 
                <input class="input" type="text" name="tel2" maxlength="4" style="width: 46px;">
                - 
                <input class="input" type="text" name="tel3" maxlength="4" style="width: 46px;">
            </td>
        </tr>
    </tr>
    <!-- 숨겨진 필드 추가 -->
    <input type="hidden" name="cert_value" value="">
    <tr>
        <tr>
            <td colspan="2" >
                <input class="inputbutton" type="button" value="이전" onclick="location='/login'">
                <input class="inputbutton" type="submit" value="확인">
            </td>
        </tr>
    </table>
</form>