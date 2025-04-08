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
<script>
    function validateForm() {
        let isValid = true;
        const fields = [
            { id: 'businessNumber', message: '사업자 번호를 입력해주세요.' },
            { id: 'address', message: '주소를 입력해주세요.' },
            { id: 'detailedAddress', message: '상세주소를 입력해주세요.' },
            { id: 'postalCode', message: '우편번호를 입력해주세요.' }
        ];

        for (const field of fields) {
            const input = document.getElementById(field.id);
            const error = document.getElementById(`${field.id}Error`);
            if (!input.value.trim()) {
                error.textContent = field.message;
                input.focus();
                isValid = false;
                break;
            } else {
                error.textContent = '';
            }
        }

        if (isValid) {
            alert('모든 입력이 유효합니다. 다음 단계로 이동합니다.');
            return true; // 폼 제출 허용
        }

        return false; // 폼 제출 차단
    }

    function checkBusinessNumber() {
        const businessNumber = document.getElementById("businessNumber").value.trim();
        if (!businessNumber) {
            alert("사업자 번호를 입력해주세요.");
            return;
        }
        alert("사업자 번호 확인 완료!");
    }

    function searchAddress() {
        alert("주소 검색 기능은 카카오 API와 연동됩니다.");
    }
</script>
<form name="joinStepComp" onsubmit="return validateForm()">
    <!-- joinStepUser에서 전달된 데이터 유지 -->
    <input type="hidden" name="companyName" value="${param.companyName}">
    <input type="hidden" name="id" value="${param.id}">
    <input type="hidden" name="password" value="${param.password}">
    <input type="hidden" name="email" value="${param.email}">
    <input type="hidden" name="phoneNumber" value="${param.phoneNumber}">
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
                    <label for="businessNumber" style="flex: 1; font-weight: bold; text-align: right;">사업자 번호</label>
                    <div style="flex: 3; display: flex; gap: 10px;">
                        <input type="text" id="businessNumber" name="businessNumber" placeholder="사업자 번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <button type="button" onclick="checkBusinessNumber()" style="flex: 1; padding: 10px; background-color: #646464; color: white; border: none; border-radius: 5px; cursor: pointer;">번호확인</button>
                    </div>
                    <div id="businessNumberError" class="error" style="flex: 1; color: red; font-size: 12px;"></div>
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
                    <div id="addressError" class="error" style="flex: 1; color: red; font-size: 12px;"></div>
                </div>
            </td>
        </tr>
        <!-- 상세주소 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="detailedAddress" style="flex: 1; font-weight: bold; text-align: right;">상세주소</label>
                    <input type="text" id="detailedAddress" name="detailedAddress" placeholder="상세주소를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="detailedAddressError" class="error" style="flex: 1; color: red; font-size: 12px;"></div>
                </div>
            </td>
        </tr>
        <!-- 우편번호 -->
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="postalCode" style="flex: 1; font-weight: bold; text-align: right;">우편번호</label>
                    <input type="text" id="postalCode" name="postalCode" placeholder="우편번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="postalCodeError" class="error" style="flex: 1; color: red; font-size: 12px;"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
              <button type="button" onclick="location='/joinStepUser'">이전</button>
              <button type="submit" class="next">다음</button>
            </td>
        </tr>     
    </table>
</form>