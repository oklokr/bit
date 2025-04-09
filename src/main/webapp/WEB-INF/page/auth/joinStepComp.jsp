<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    const kakaoApiKey = '${kakao.map.js-key}';
    Kakao.init(kakaoApiKey); // 발급받은 JavaScript 키로 초기화
    let isBusinessNumberChecked = false; // 사업자 번호 확인 여부 플래그

    async function validateForm(event) {
        event.preventDefault();
        let isValid = true;

        // 사업자 번호 검증
        const businessNumber1 = document.getElementById('businessNumber1').value.trim();
        const businessNumber2 = document.getElementById('businessNumber2').value.trim();
        const businessNumber3 = document.getElementById('businessNumber3').value.trim();

        if (!businessNumber1 || !businessNumber2 || !businessNumber3) {
            alert('사업자 번호를 모두 입력해주세요.');
            document.getElementById('businessNumber1').focus();
            return false;
        }

        const fullBusinessNumber = businessNumber1 + '-' + businessNumber2 + '-' + businessNumber3;
        const businessNumberRegex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
        if (!businessNumberRegex.test(fullBusinessNumber)) {
            alert('유효하지 않은 사업자 번호 형식입니다. 올바른 형식을 입력해주세요.');
            document.getElementById('businessNumber1').focus();
            return false;
        }

        // 사업자 번호 확인 버튼 체크 여부 검증
        if (!isBusinessNumberChecked) {
            alert('사업자 번호 확인을 완료해주세요.');
            return false;
        }

        // 주소 검증
        const address = document.getElementById('address').value.trim();
        if (!address) {
            alert('주소를 입력해주세요.');
            document.getElementById('address').focus();
            return false;
        }

        // 우편번호 검증
        const postalCode = document.getElementById('postalCode').value.trim();
        if (!postalCode) {
            alert('우편번호를 입력해주세요.');
            document.getElementById('postalCode').focus();
            return false;
        }

        // 모든 검증 통과 시 폼 제출
        alert('모든 입력이 유효합니다. 다음 단계로 이동합니다.');
        event.target.submit();
    }

    async function checkBusinessNumber() {
        const businessNumber1 = document.getElementById('businessNumber1').value.trim();
        const businessNumber2 = document.getElementById('businessNumber2').value.trim();
        const businessNumber3 = document.getElementById('businessNumber3').value.trim();

        const fullBusinessNumber = businessNumber1 + '-' + businessNumber2 + '-' + businessNumber3;

        try {
            const response = await fetch('/checkBusinessNumber', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ businessNumber: fullBusinessNumber })
            });
            const data = await response.json();

            if (data.isValid) {
                alert("유효한 사업자 번호입니다.");
                isBusinessNumberChecked = true; // 확인 완료 플래그 설정
                return true;
            } else {
                alert("유효하지 않은 사업자 번호입니다.");
                isBusinessNumberChecked = false; // 확인 실패 플래그 설정
                return false;
            }
        } catch (error) {
            console.error('Error:', error);
            alert('사업자 번호 확인 중 오류가 발생했습니다.');
            isBusinessNumberChecked = false; // 확인 실패 플래그 설정
            return false;
        }
    }
    
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소 또는 지번 주소를 가져옵니다.
                const address = data.roadAddress ? data.roadAddress : data.jibunAddress;

                // 주소 입력창에 값 설정
                document.getElementById('address').value = address;

                // 상세주소 입력창에 포커스 이동
                document.getElementById('detailedAddress').focus();
            }
        }).open();
    }
</script>
<form name="joinStepComp" action="/joinStepSuccess" method="post" onsubmit="return validateForm(event)">
    <!-- joinStepUser에서 전달된 데이터 유지 -->
    <input type="hidden" name="companyName" value="${param.companyName}">
    <input type="hidden" name="id" value="${param.id}">
    <input type="hidden" name="password" value="${param.password}">
    <input type="hidden" name="email" value="${param.email}">
    <input type="hidden" name="tel1" value="${param.tel1}">
    <input type="hidden" name="tel2" value="${param.tel2}">
    <input type="hidden" name="tel3" value="${param.tel3}">
    <input type="hidden" name="requiredTermAgreed" value="${param.requiredTermAgreed}">
    <input type="hidden" name="optionalTermAgreed" value="${param.optionalTermAgreed}">
    <table>
        <tr>
            <th style="padding-top: 10px; font-size: 25px; font-weight: 700;">사업자 정보입력</th>
        </tr>
        <tr>
            <td>
                <div class="steps">
                    <span class="step">1</span>
                    <span class="step">2</span>
                    <span class="step active">3</span>
                </div>
            </td>
        </tr>
        <!-- 사업자 번호 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="businessNumber1" style="flex: 1; font-weight: bold; text-align: right;">사업자 번호</label>
                    <div style="flex: 3; display: flex; gap: 5px;">
                        <input type="text" id="businessNumber1" name="businessNumber1" maxlength="3" placeholder="123" style="width: 20%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <span style="align-self: center;">-</span>
                        <input type="text" id="businessNumber2" name="businessNumber2" maxlength="2" placeholder="45" style="width: 15%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <span style="align-self: center;">-</span>
                        <input type="text" id="businessNumber3" name="businessNumber3" maxlength="5" placeholder="67890" style="width: 30%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <button type="button" onclick="checkBusinessNumber()" style="flex: 1; padding: 10px; background-color: #646464; color: white; border: none; border-radius: 5px; cursor: pointer;">번호확인</button>
                    </div>
                </div>
            </td>
        </tr>
        <!-- 주소 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="address" style="flex: 1; font-weight: bold; text-align: right;">주소</label>
                    <div style="flex: 3; display: flex; gap: 10px;">
                        <input type="text" id="address" name="address" placeholder="주소를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <button type="button" onclick="searchAddress()" style="flex: 1; padding: 10px; background-color: #646464; color: white; border: none; border-radius: 5px; cursor: pointer;">주소검색</button>
                    </div>
                </div>
            </td>
        </tr>
        <!-- 상세주소 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="detailedAddress" style="flex: 1; font-weight: bold; text-align: right;">상세주소</label>
                    <input type="text" id="detailedAddress" name="detailedAddress" placeholder="상세주소를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                </div>
            </td>
        </tr>
        <!-- 우편번호 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="postalCode" style="flex: 1; font-weight: bold; text-align: right;">우편번호</label>
                    <input type="text" id="postalCode" name="postalCode" placeholder="우편번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                </div>
            </td>
        </tr>
        <tr>
            <td>
              <button type="button" onclick="location='/joinStepUser'">이전</button>
              <button type="submit" class="next" onclick="joinStepSuccess()">완료</button>
            </td>
        </tr>     
    </table>
</form>