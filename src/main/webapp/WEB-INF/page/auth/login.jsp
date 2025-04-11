<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="auth-page login">
    <h1 class="logo">Bit Dental</h1>
    <div class="login-wrap">
        <h2 class="page-title">로그인</h1>
        <div class="login-form">
            <div class="login-form__input">
                <label for="id">아이디</label>
                <input id="id" type="text" class="form-control" placeholder="아이디를 입력해주세요." maxlength="15" autofocus>
                <span class="error-msg"></span>
            </div>
            <div class="login-form__input">
                <label for="passwd">비밀번호</label>
                <input id="passwd" type="password" class="form-control" placeholder="비밀번호를 입력해주세요." maxlength="20" autofocus>
                <span class="error-msg"></span>
            </div>
            <button class="btn btn-primary">로그인</button>
            <ul>
                <li><a href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}/findId">아이디 찾기</a></li>
                <li><a href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}/findPw">비밀번호 찾기</a></li>
                <li><a href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}/join">회원가입</a></li>
            </ul>
        </div>
    </div>
</div>

<script>
    function handleLogin(idEl, pwEl) {
        idEl.nextElementSibling.innerText = ""
        pwEl.nextElementSibling.innerText = ""

        if(validate.isEmpty(idEl.value)) {
            idEl.focus()
            idEl.nextElementSibling.innerText = "아이디를 입력해주세요."
        }
        if(validate.isEmpty(pwEl.value)) {
            pwEl.focus()
            pwEl.nextElementSibling.innerText = "비밀번호를 입력해주세요."
        }

        postRequestApi("/api/login", {
            id: idEl.value,
            passwd: pwEl.value
        }, res => {
            if(res.data === 0) return modal({ content: "아이디 또는 비밀번호가 일치하지 않습니다." });
            location.href = "/main";
        })
    }
    function handleLoad() {
        const loginButton = document.querySelector('.login-wrap .btn');
        const idInput = document.getElementById('id');
        const passwdInput = document.getElementById('passwd');

        loginButton.addEventListener('click', () => handleLogin(idInput, passwdInput));
        [idInput, passwdInput].forEach(input => {
            input.addEventListener('keypress', (event) => {
                if (event.key === 'Enter') handleLogin(idInput, passwdInput);
            });
        });
    }
    document.addEventListener('DOMContentLoaded', handleLoad);
</script>

<style>
.auth-page {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100vh;
    margin: 0 auto;
}
.auth-page.login {
    max-width:  450px;
    justify-content: flex-start;
    padding: 60px 0;
}

.auth-page .logo {
    width: 140px;
    height: 140px;
    color: transparent;
    text-indent: -9999px;
    margin: 0 auto;
    background: url('/images/logo.png') no-repeat center;
    background-size: 100%;
}

.login-wrap {
    padding: 24px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.login-wrap .page-title {
    text-align: center;
    font-weight: bold;
    margin: 16px 0 30px;
}

.login-wrap .btn {
    width: 100%;
    margin-top: 24px;
}

.login-form__input {
    display: flex;
    align-items: flex-start;
    height: 60px;
    margin-top: 20px;
    position: relative;
}
.login-form__input input {
    flex: 1;
    width: 100%;
}
.login-form__input label {
    width: 80px;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    padding: 6px 0;
}
.login-form__input .error-msg {
    font-size: 14px;
    position: absolute;
    bottom: -2px;
    left: 92px;
}

.login-wrap ul {
    display: flex;
    justify-content: center;
    margin-top: 24px;
    padding: 0;
    gap: 30px;
}

.login-wrap ul li {
    position: relative;
}

.login-wrap ul li:not(:last-child)::before {
    content: "";
    width: 1px;
    height: 12px;
    background: #ccc;
    position: absolute;
    top: 3px;
    right: -15px;
    bottom: 0;
    margin: auto;
}

.login-wrap ul a {
    color: #333;
    font-size: 14px;
    text-decoration: none;
}

.login-wrap ul a:hover {
    text-decoration: underline;
    color: #007bff;
}
</style>