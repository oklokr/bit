<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<li data-step="2">
    <h2 class="page-title">사용자 정보입력</h3>
    <div class="inner">
        <div class="auth-form">
            <div class="input-item">
                <label for="companyName">업체명</label>
                <input id="companyName" type="text" class="form-control" placeholder="업체명을 입력해주세요." maxlength="50" autofocus>
                <span class="error-msg"></span>
            </div>

            <div class="input-item row-form">
                <label for="id">아이디</label>
                <input id="id" type="text" class="form-control" placeholder="아이디를 입력해주세요." maxlength="50" autofocus>
                <button class="btn btn-outline-secondary btn-sm" onclick="handleIdCheck()">중복확인</button>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="passwd">비밀번호</label>
                <input id="passwd" type="password" class="form-control" placeholder="비밀번호를 입력해주세요." maxlength="50" autofocus>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="rePasswd">비밀번호 확인</label>
                <input id="rePasswd" type="password" class="form-control" placeholder="비밀번호 확인을 입력해주세요." maxlength="50" autofocus>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="email">이메일</label>
                <input id="email" type="text" class="form-control" placeholder="이메일을 입력해주세요." maxlength="50" autofocus>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="tel">전화번호</label>
                <input id="tel" type="text" class="form-control" placeholder="전화번호를 입력해주세요." maxlength="13" autofocus>
                <span class="error-msg"></span>
            </div>
        </div>

        <div class="bottom-btns center">
            <button class="btn btn-outline-primary" onclick="handleStep('prev')">이전</button>
            <button class="btn btn-primary" onclick="handleUserInfoSubmit()">다음</button>
        </div>
    </div>
</li>

<script>
    let idCheck = false;

    function handleIdCheck() {
        const elId = document.querySelector("#id")
        validate.isEmpty(id) ? modal({ content: "아이디를 입력해주세요." }) : null
        postRequestApi('/joinStepUser/checkDuplicateId', { id: elId.value }, res => {
            if(res.data.isDuplicate) {
                modal({ content: "이미 사용중인 아이디입니다." })
                idCheck = false
            } else {
                modal({ content: "사용 가능한 아이디입니다." })
                idCheck = true
                elId.parentElement.querySelector(".error-msg").innerHTML = ""
            }
        })
    }

    function handleUserInfoSubmit() {
        const elCompanyName = document.querySelector("#companyName");
        const elId = document.querySelector("#id");
        const elPasswd = document.querySelector("#passwd");
        const elRePasswd = document.querySelector("#rePasswd");
        const elEmail = document.querySelector("#email");
        const elTel = document.querySelector("#tel");
        const validateError = (el, msg) => {
            console.log(el)
            modal({ content: msg })
            el.focus()
            el.parentElement.querySelector(".error-msg").innerHTML = "&#8251; "+ msg +""
        }
        document.querySelectorAll(".error-msg").forEach(el => el.innerHTML = "")
        if(validate.isEmpty(elCompanyName.value)) return validateError(elCompanyName, "업체명을 입력해주세요.")
        if(validate.isEmpty(elId.value)) return validateError(elId, "아이디를 입력해주세요.")
        if(!idCheck) return validateError(elId, "아이디 중복확인을 해주세요.")
        if(validate.isEmpty(elPasswd.value)) return validateError(elPasswd, "비밀번호를 입력해주세요.")
        if(validate.isEmpty(elRePasswd.value)) return validateError(elRePasswd, "비밀번호 확인을 입력해주세요.")
        if(elPasswd.value !== elRePasswd.value) return validateError(elRePasswd, "비밀번호가 일치하지 않습니다.")
        if(validate.isEmpty(elEmail.value)) return validateError(elEmail, "이메일을 입력해주세요.")
        if(!validate.isEmail(elEmail.value)) return validateError(elEmail, "이메일 형식이 아닙니다.")
        if(validate.isEmpty(elTel.value)) return validateError(elTel, "전화번호를 입력해주세요.")
        if(!validate.isPhoneNumber(elTel.value)) return validateError(elTel, "전화번호 형식이 아닙니다.")

        postForm.id = elId.value
        postForm.companyName = elCompanyName.value
        postForm.password = elPasswd.value
        postForm.email = elEmail.value
        postForm.phoneNumber = elTel.value

        handleStep()
    }

    document.querySelector("#tel").addEventListener("input", (event) => {
        const formattedValue = formatPhoneNumber(event.target.value);
        event.target.value = formattedValue;
    });
</script>

<style>
    .auth-form .input-item {
        display: flex;
        flex-wrap: wrap;
        align-items: flex-start;
        height: 80px;
    }

    .auth-form .input-item.row-form button {
        width: 90px;
        height: 37px;
        margin-left: 16px;
    }

    .auth-form .input-item label {
        width: 120px;
        padding: 5px 0;
    }
    .auth-form .input-item .form-control {
        flex: 1;
        width: calc(100% - 120px);
    }

    .auth-form .input-item .error-msg {
        width: 100%;
        font-size: 14px;
        padding-left: 120px;
        color: #dc3545;
    }
</style>