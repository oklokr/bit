<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="auth-page signup">
    <div class="content">
        <ul>
            <li>
                <h2 class="page-title">이용약관 동의</h3>
                <div class="inner">
                    <div class="bottom-btns">
                        <button class="btn btn-primary">이전</button>
                        <button class="btn btn-primary">다음</button>
                    </div>
                </div>
            </li>
            <li>
                <h2 class="page-title">사용자 정보입력</h3>
                <div class="inner">

                    <div class="bottom-btns">
                        <button class="btn btn-primary">이전</button>
                        <button class="btn btn-primary">다음</button>
                    </div>
                </div>
            </li>
            <li>
                <h2 class="page-title">사업자 정보입력</h3>
                <div class="inner">

                    <div class="bottom-btns">
                        <button class="btn btn-primary">이전</button>
                        <button class="btn btn-primary">다음</button>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<style>
    .signup ul {
        display: flex;
        justify-content: center;
        gap: 20px;
        position: relative;
    }
    .signup li {
        min-height: 600px;
    }
    .signup li::before {
        display: flex;
        align-items: center;
        justify-content: center;
        content: "1";
        width: 30px;
        height: 30px;
        background-color: #007bff;
        color: #fff;
        border-radius: 50%;
        font-weight: bold;
    }
    .signup .page-title {
        position: absolute;
        left: 0;
    }
    .signup .inner {
        position: absolute;
        left: 0;
    }
</style>