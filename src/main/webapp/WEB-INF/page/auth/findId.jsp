<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="auth-page">
    <div class="content">
        <div class="find-wrap">
            <h2 class="page-title">아이디 찾기</h2>
            <div class="input-item">
                <label class="label" for="companyNanme">업체명</label>
                <input type="text" class="form-control" id="companyNanme" placeholder="업체명을 입력해주세요." maxlength="15" autofocus>
                <span class="error-msg"></span>
            </div>
            <div class="input-item">
                <span class="label">인증방법</span>

                <div class="form-check">
                    <input class="form-check-input" type="radio" name="type" id="email" checked>
                    <label class="form-check-label" for="email">이메일</label>
                    <div class="input-item">
                        <input id="emailInput" type="text" class="form-control" placeholder="이메일을 입력해주세요." maxlength="30" autofocus>
                        <span class="error-msg"></span>
                    </div>
                </div>

                <div class="form-check">
                    <input class="form-check-input" type="radio" name="type" id="phone">
                    <label class="form-check-label" for="phone">휴대폰</label>
                    <div class="input-item">
                        <input id="phoneInput" type="text" class="form-control" placeholder="전화번호를 입력해주세요." maxlength="13" autofocus>
                        <span class="error-msg"></span>
                    </div>
                </div>
            </div>

            <div class="bottom-btns center">
                <button class="btn btn-outline-primary" onclick="history.back()">이전</button>
                <button class="btn btn-primary" onclick="handleFindId()">확인</button>
            </div>
        </div>

        <div class="result-wrap" style="display: none;">
            <h2 class="page-title">아이디 결과</h2>
            <p class="result-txt">가입된 아이디는 <strong>"+id+"</strong>입니다.</p>

            <div class="bottom-btns center">
                <button class="btn btn-secondary" onclick="location.href='/auth/login'">로그인하기</button>
                <button class="btn btn-primary" onclick="location.href='/auth/findPw'">비밀번호 찾기</button>
            </div>
        </div>
    </div>
</div>


<script>
    function handleFindId() {
        const companyNameEl = document.querySelector("#companyNanme")
        const emailEl = document.querySelector("#email + .form-check-label + .input-item input")
        const phoneEl = document.querySelector("#phone + .form-check-label + .input-item input")
        const emailChecked = document.querySelector("#email").checked
        const phoneChecked = document.querySelector("#phone").checked
        let validated = true
        const postData = {
            companyName: null,
            email: null,
            phoneNumber: null,
            type: null
        }

        const handleError = (el, msg) => {
            el.focus()
            el.nextElementSibling.innerHTML = msg
            validated = false
        }

        companyNameEl.nextElementSibling.innerHTML = ""
        emailEl.nextElementSibling.innerHTML = ""
        phoneEl.nextElementSibling.innerHTML = ""

        if(validate.isEmpty(companyNameEl.value)) {
            handleError(companyNameEl, "&#8251; 업체명을 입력해주세요.")
        }

        if( emailChecked && validate.isEmpty(emailEl.value) ) {
            handleError(emailEl, "&#8251; 이메일을 입력해주세요.")
        } else if( emailChecked && !validate.isEmail(emailEl.value) ) {
            handleError(emailEl, "&#8251; 이메일 형식이 아닙니다.")
        }

        if( phoneChecked && validate.isEmpty(phoneEl.value) ) {
            handleError(phoneEl, "&#8251; 전화번호를 입력해주세요.")
        } else if( phoneChecked && !validate.isPhoneNumber(phoneEl.value) ) {
            handleError(phoneEl, "&#8251; 전화번호 형식이 아닙니다.")
        }

        if(!validated) return modal({ content: "입력값을 확인해주세요." })

        postData.companyName = companyNameEl.value
        postData.email = emailEl.value
        postData.phoneNumber = phoneEl.value
        postData.type = emailChecked ? "email" : "phone"

        postRequestApi("/api/auth/findId", postData, res => {
            if(res.data.data === null) return modal({ content: "가입된 정보가 없습니다." })
            const id = res.data.data;
            console.log(document.querySelector(".find-wrap"));
            document.querySelector(".find-wrap").style.display = "none"
            document.querySelector(".result-wrap").style.display = "block"
            document.querySelector(".result-txt").innerHTML = "가입된 아이디는 <strong>"+id+"</strong>입니다."
        });
    }

    document.addEventListener("DOMContentLoaded", () => {
        document.querySelector("#phone + .form-check-label + .input-item input").addEventListener("input", (event) => {
            const formattedValue = formatPhoneNumber(event.target.value);
            event.target.value = formattedValue;
        });
    })
</script>
<style>
    .input-item {
        display: flex;
        flex-wrap: wrap;
        align-items: flex-start;
        margin-top: 20px;
        padding-bottom: 28px;
        position: relative;
    }

    .input-item .form-check {
        min-height: 110px;
    }
    .input-item .form-check + .form-check {
        margin-left: 40px;
    }

    .input-item .form-check .input-item {
        display: none;
    }

    .input-item .form-check-input:checked + .form-check-label + .input-item {
        display: block;
    }

    .input-item .input-item {
        width: 100%;
        position: absolute;
        left: 0;
    }

    .input-item .label {
        display: block;
        width: 100%;
        font-weight: bold;
        margin-bottom: 12px;
    }

    .input-item .error-msg {
        color: #dc3545;
        position: absolute;
        bottom: 0;
    }

    .result-txt {
        font-size: 20px;
        text-align: center;
        padding: 30px 0;
        border-radius: 4px;
        background: #f8f9fa;
        color: #333;
    }

    .result-txt strong {
        font-size: 24px;
        color: #007bff;
        font-weight: bold;
    }
</style>