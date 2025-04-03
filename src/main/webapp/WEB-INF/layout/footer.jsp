<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <ul>
        <li>이용약관</li>
        <li>개인정보취급방침</li>
    </ul>
    <span class="site-company">Copyright ⓒ2025 Uipac. All Rights reserved</span>
</footer>

<style>
    footer {
        display: flex;
        flex-direction: column;
        height: 58px;
    }
    footer ul {
        display: flex;
        color: #212529;
        text-decoration: initial;
        font-size: 12px;
        color: #b3b3b3;
        padding: initial;
        margin: initial;
        margin: 0 auto;
        gap: 20px;
    }

    footer ul li {
        position: relative;
    }
    footer ul li:first-child::after {
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