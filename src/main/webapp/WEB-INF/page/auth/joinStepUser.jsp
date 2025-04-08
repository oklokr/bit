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
        width: 200%;
        height: 300px;
    }
    th, td {
        padding: 10px 20px;
        text-align: center;
    }
    th {
        width: 60px;
    }
    td {
        width: 150%;
    }
    .input {
        width: 100%;
        padding: 5px;
        box-sizing: border-box;
        border: 1px solid black;
        text-align: center;
    }
    .inputbutton {
        padding: 8px 15px;
        border: 1px solid rgb(122, 122, 122);
        cursor: pointer;
        box-sizing: border-box;
        width: 40%;
        text-align: center;
    }
    .inputbutton[type="submit"] {
        background-color: #d3d3d3;
        margin: 5px;
    }
    .inputbutton[type="button"] {
        background-color: #d3d3d3;
        margin: 5px;
    }
    .steps {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }
    .step {
        width: 20px;
        height: 20px;
        line-height: 20px;
        text-align: center;
        border: 2px solid #007bff;
        border-radius: 50%;
        margin: 0 5px;
        font-size: 12px;
        color: #007bff;
        background-color: white;
        font-weight: bold;
    }
    .step.active {
        background-color: #007bff;
        color: white;
    }
</style>
<script>
    async function validateForm(event) {
        event.preventDefault();
        let isValid = true;
        let firstInvalidField = null;

        // 업체명 검증
        const companyName = document.getElementById('companyName');
        if (!companyName || !companyName.value.trim()) {
            alert('업체명을 입력해주세요.');
            companyName.focus();
            return false;
        }

        // 아이디 검증
        const id = document.getElementById('id');
        if (!id || !id.value.trim()) {
            alert('아이디를 입력해주세요.');
            id.focus();
            return false;
        }

        // 비밀번호 검증
        const password = document.getElementById('password');
        if (!password || !password.value.trim()) {
            alert('비밀번호를 입력해주세요.');
            password.focus();
            return false;
        }

        // 비밀번호 확인 검증
        const confirmPassword = document.getElementById('confirmPassword');
        if (!confirmPassword || !confirmPassword.value.trim()) {
            alert('비밀번호 확인을 입력해주세요.');
            confirmPassword.focus();
            return false;
        }
        if (password.value.trim() !== confirmPassword.value.trim()) {
            alert('비밀번호가 일치하지 않습니다.');
            confirmPassword.focus();
            return false;
        }

        // 이메일 검증
        const email = document.getElementById('email');
        if (!email || !email.value.trim()) {
            alert('이메일을 입력해주세요.');
            email.focus();
            return false;
        }

        // 전화번호 검증
        const tel1 = document.getElementById('tel1')?.value.trim();
        const tel2 = document.getElementById('tel2')?.value.trim();
        const tel3 = document.getElementById('tel3')?.value.trim();
        if (!tel1 || !tel2 || !tel3) {
            alert('휴대전화번호를 모두 입력해주세요.');
            document.getElementById('tel1').focus();
            return false;
        }
        const phoneNumber = tel1 + '-' + tel2 + '-' + tel3;

        // 아이디 중복 확인
        if (!isDuplicateChecked) {
            alert('아이디 중복 확인을 완료해주세요.');
            id.focus();
            return false;
        }

        // 이메일 및 전화번호 중복 확인
        try {
            const emailResponse = await fetch('/joinStepUser/checkDuplicateEmail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email: email.value.trim() })
            });
            const emailData = await emailResponse.json();
            if (emailData.isDuplicate) {
                alert('이미 사용 중인 이메일입니다.');
                email.focus();
                return false;
            }

            const phoneResponse = await fetch('/joinStepUser/checkDuplicatePhone', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ phoneNumber: phoneNumber })
            });
            const phoneData = await phoneResponse.json();
            if (phoneData.isDuplicate) {
                alert('이미 사용 중인 전화번호입니다.');
                document.getElementById('tel1').focus();
                return false;
            }
        } catch (error) {
            console.error('Error during validation:', error);
            alert('중복 확인 중 오류가 발생했습니다.');
            return false;
        }

        // 모든 검증 통과 시 폼 제출
        event.target.submit();
    }

    let isDuplicateChecked = false;

    function checkDuplicateId() {
        const id = document.getElementById('id').value.trim();
        if (!id) {
            alert('아이디를 입력해주세요.');
            document.getElementById('id').focus();
            return;
        }

        fetch('/joinStepUser/checkDuplicateId', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ id: id })
        })
            .then(response => response.json())
            .then(data => {
                if (data.isDuplicate) {
                    alert('이미 사용 중인 아이디입니다.');
                    isDuplicateChecked = false;
                } else {
                    alert('사용 가능한 아이디입니다.');
                    isDuplicateChecked = true;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('중복 확인 중 오류가 발생했습니다.');
                isDuplicateChecked = false;
            });
    }
</script>
<form name="joinStepUser" method="get" action="/joinResult" onsubmit="return validateForm(event)">
    <table>
        <tr>
            <th style="padding-top: 10px; font-size: 25px; font-weight: 700;">사용자 정보입력</th>
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
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="password" style="flex: 1; font-weight: bold; text-align: right;">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">                   
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="confirmPassword" style="flex: 1; font-weight: bold; text-align: right;">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인을 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">                    
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="email" style="flex: 1; font-weight: bold; text-align: right;">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." style="flex: 3; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">                    
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group" style="display: flex; align-items: center; width: 100%; gap: 10px;">
                    <label for="tel1" style="flex: 1; font-weight: bold; text-align: right;">휴대전화</label>
                    <div style="flex: 3; display: flex; gap: 5px;">
                        <input type="text" id="tel1" name="tel1" maxlength="3" placeholder="010" style="width: 30%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <span style="align-self: center;">-</span>
                        <input type="text" id="tel2" name="tel2" maxlength="4" placeholder="1234" style="width: 30%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                        <span style="align-self: center;">-</span>
                        <input type="text" id="tel3" name="tel3" maxlength="4" placeholder="5678" style="width: 30%; padding: 10px; box-sizing: border-box; border: 1px solid #000000; border-radius: 5px;">
                    </div>                    
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <button type="button" onclick="location='/join'">취소</button>
                <button type="submit">다음</button>
            </td>
        </tr>
    </table>
</form>