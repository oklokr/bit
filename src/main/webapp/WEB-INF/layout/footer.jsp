<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <ul>
        <li>
            <button class="btn" onclick="termsModal('1')">서비스 이용 약관</button>
        </li>
        <li>
            <button class="btn" onclick="termsModal('2')">개인정보 처리방침</button>
        </li>
        <li>
            <button class="btn" onclick="termsModal('3')">마케팅 수신 동의</button>
        </li>
    </ul>
    <span class="site-company">Copyright ⓒ2025 Bit Dental. All Rights reserved</span>
</footer>

<style>
    footer {
        display: flex;
        flex-direction: column;
        height: 72px;
    }

    footer .btn {
        font-size: 14px;
        padding: initial;
        margin: initial;
    }
    footer ul {
        display: flex;
        color: #212529;
        text-decoration: initial;
        font-size: 12px;
        color: #b3b3b3;
        padding: 4px 0;
        margin: 0 auto;
        gap: 20px;
    }

    footer ul li {
        position: relative;
    }
    footer ul li:not(:last-of-type)::after {
        content: " | ";
        position: absolute;
        right: -10px;
    }

    footer .site-company {
        display: block;
        width: 100%;
        font-size: 12px;
        text-align: center;
        color: #666;
        padding: 10px 0;
        margin-top: auto;
        background: #ccc;
    }
</style>