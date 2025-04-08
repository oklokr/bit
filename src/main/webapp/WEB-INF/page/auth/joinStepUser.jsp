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
            { id: 'companyName', message: '업체명을 입력해주세요.' },
            { id: 'id', message: '아이디를 입력해주세요.' },
            { id: 'password', message: '비밀번호를 입력해주세요.' },
            { id: 'confirmPassword', message: '비밀번호 확인을 입력해주세요.' },
            { id: 'email', message: '이메일을 입력해주세요.' },
            { id: 'phone', message: '휴대전화번호를 입력해주세요.' }
        ];

        fields.forEach(field => {
            const input = document.getElementById(field.id);
            const error = document.getElementById(`${field.id}Error`);
            if (!input.value.trim()) {
                error.textContent = field.message;
                isValid = false;
            } else {
                error.textContent = '';
            }
        });

        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        if (password && confirmPassword && password !== confirmPassword) {
            document.getElementById('confirmPasswordError').textContent = '비밀번호가 일치하지 않습니다.';
            isValid = false;
        }

        return isValid;
    }

    function checkDuplicateId() {
        const id = document.getElementById('id').value.trim();
        if (!id) {
            alert('아이디를 입력해주세요.');
            document.getElementById('id').focus();
            return;
        }

        fetch('/joinStepUser/checkDuplicateId', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id: id })
        })
            .then(response => response.json())
            .then(data => {
                if (data.isDuplicate) {
                    alert(data.message);
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('중복 확인 중 오류가 발생했습니다.');
            });
    }
</script>
<form name="joinStepUser" onsubmit="return validateForm()">
    <table>
        <tr>
            <th style="padding-top: 10px; font-size: 25px; font-weight: 700;"> 사용자 정보입력 </th>
        </tr>
        <tr>
            <td>
                <div class="steps">
                    <span class="step">1</span>
                    <span class="step active">2</span>
                    <span class="step">3</span>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="companyName" style="flex: 1; font-weight: bold; text-align: right;">업체명</label>
                    <input type="text" id="companyName" name="companyName" placeholder="업체명을 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="companyNameError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="id" style="flex: 1; font-weight: bold; text-align: right;">아이디</label>
                    <div style="flex: 3; display: flex; gap: 10px;">
                        <input type="text" id="id" name="id" placeholder="아이디를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <button type="button" onclick="checkDuplicateId()" style="flex: 1; padding: 10px; background-color: #646464; color: white; border: none; border-radius: 5px; cursor: pointer;">중복확인</button>
                    </div>
                    <div id="idError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="password" style="flex: 1; font-weight: bold; text-align: right;">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="passwordError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="confirmPassword" style="flex: 1; font-weight: bold; text-align: right;">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인을 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="confirmPasswordError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="email" style="flex: 1; font-weight: bold; text-align: right;">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="emailError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="phone" style="flex: 1; font-weight: bold; text-align: right;">휴대전화</label>
                    <input type="text" id="phone" name="phone" placeholder="휴대전화번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    <div id="phoneError" class="error" style="flex: 1; color: red; font-size: 12px;" aria-live="polite"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
              <button type="button" onclick="location='/join'">이전</button>
              <button type="submit" class="next">다음</button>
            </td>
        </tr>     
    </table>
</form>