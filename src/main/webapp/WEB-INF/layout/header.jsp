<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <div class="container">
        <h1>
            <a href="/main">로고</a>
        </h1>
        <ul>
            <li>
                <a href="/main">상품정보</a>
            </li>
            <li>
                <a href="/main/product">상품정보 등록</a>
            </li>
            <li>
                <a href="/board">자유게시판</a>
            </li>
            <li>
                <a href="/mypage/inventory">병원재고 관리</a>
            </li>
        </ul>
        <button type="button">마이페이지 열기</button>
    </div>
</header>

<style>
    header {
        height: 58px;
        border-bottom: 1px solid #ccc;
    }
    header h1 {
        width: 68px;
        height: 100%;
        margin: initial;
        background: url('/images/logo.png') no-repeat center center;
        background-size: 100%;
    }
    header h1 a {
        display: block;
        height: 100%;
        color: transparent;
        text-indent: -9999px;;
    }
    header .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 100%;
    }

    header ul {
        display: flex;
        gap: 60px;
        margin: initial;
        padding: initial;
    }
    header ul a {
        display: flex;
        color: #212529;
        transition: 0.3s;
        text-decoration: initial;
        font-size: 16px;
        font-weight: 600;
        position: relative;
    }
    header ul a::before {
        content: "";
        width: 0%;
        height: 2px;
        position: absolute;
        bottom: 0;
        background-color: #212529;
        transition: 0.3s;
    }
    header ul a:hover {
        color: #007bff;
    }
    header ul a:hover::before {
        width: 100%;
        background-color: #007bff;;
    }

    header button {
        width: 38px;
        height: 38px;
        font-size: 16px;
        font-weight: 600;
        color: transparent;
        text-indent: -9999px;
        cursor: pointer;
        padding: 0;
        border: none;
        background-color: transparent;
        background: url('/images/icons/user.png') no-repeat center center;
        background-size: 100%;
    }
</style>