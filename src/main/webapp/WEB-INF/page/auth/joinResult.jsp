<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="auth-page result-page">
    <div class="content">
        <h2 class="page-title">회원가입 완료</h3>
        <p>환영합니다! <span>${companyName}</span> 님<br>회원가입이 완료되었습니다!</p>
        <div class="bottom-btns center">
            <button class="btn btn-primary btn-lg" onclick="location.href='/main'">메인페이지 바로가기</button>
        </div>
    </div>
</div>

<style>
    .result-page {
        max-width: 500px;
    }
    .result-page p::before {
        display: block;
        content: "";
        width: 250px;
        height: 250px;
        margin: 30px auto;
        background: url("/images/temp/temp01.png") no-repeat center center;
        background-size: 100%;
    }
    .result-page p {
        text-align: center;
        font-size: 22px;
    }
    .result-page p span {
        font-weight: bold;
    }
</style>