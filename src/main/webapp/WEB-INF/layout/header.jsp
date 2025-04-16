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
        <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="handleGetUserInfo()">마이페이지 열기</button>
    </div>
</header>

<div class="mypage-modal modal fade modal-fullscreen" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-name="mypage-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="title">
                    <strong class="modal-title fs-5" id="exampleModalLabel">마이페이지</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </p>
                <p class="info">
                    <span>OOO병원 님</span>
                    <button type="button" class="btn btn-link" onclick="logout()">로그아웃</button>
                </p>
            </div>
            <div class="modal-body">
                <a class="btn btn-primary" href="/mypage" role="button">내 정보</a>
                <ul class="link-wrap">
                    <li><a href="/main">상품정보</a></li>
                    <li><a href="/main/product">상품정보 등록</a></li>
                    <li><a href="/board">자유게시판</a></li>
                    <li><a href="/mypage/inventory">병원재고 관리</a></li>
                    <li data-view="admin"><a href="/admin">회원 관리</a></li>
                </ul>
            </div>
        </div>  
    </div>
</div>

<script>
    function handleGetUserInfo() {
        postRequestApi('/api/mypage/info', {}, res => {
            if(validate.isEmpty(res.data.id)) return
            document.querySelector(".info span").innerText = res.data.companyName + "님"
            document.querySelector("li[data-view='admin']").style.display = res.data.memberType === 2 ? "block" : "none"
        })
    }

    document.addEventListener("DOMContentLoaded", () => {
        const currentPath = window.location.pathname;
        const menuLinks = document.querySelectorAll("header ul a");
        menuLinks.forEach(link => {
            if (link.getAttribute("href") === currentPath) link.classList.add("active")
        });
    })
</script>

<style>
    header {
        min-width: 1200px;
        height: 58px;
        border-bottom: 1px solid #ccc;
    }
    header h1 {
        width: 120px;
        height: 100%;
        margin: initial;
        background: url('/images/logo2.png') no-repeat center center;
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
    header ul a.active {
        font-weight: bold;
        color: #007bff;
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

    .mypage-modal {
        padding: initial !important;
    }
    .mypage-modal .modal-content::before {
        content: "";
        position: absolute;
        top: 14%;
        left: 0;
        right: 0;
        bottom: 0;
        background: #7eb3ff0d;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-dialog {
        width: 380px;
        margin: initial;
        margin-left: auto;
    }
    .mypage-modal.modal.fade .modal-dialog {
        transform: translate(30px, 0);
    }
    .mypage-modal.modal.show .modal-dialog {
        transform: none;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-header {
        flex-direction: column;
        padding: 0 16px;
        border: initial;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-header > p {
        width: 100%;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-header .title {
        display: flex;
        align-items: center;
        padding: 16px 0;
        margin: initial;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-header .info {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-body {
        padding-top: initial;
    }

    .mypage-modal.modal[data-name="mypage-modal"] .modal-body .btn-primary {
        display: block;
        width: 100%;
    }

    .mypage-modal.modal[data-name="mypage-modal"] .modal-body .link-wrap {
        padding: initial;
        margin-top: 30px;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-body .link-wrap li {
        border-bottom: 1px solid #212529;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-body .link-wrap a {
        display: block;
        text-decoration: initial;
        color: #212529;
        padding: 16px 0;
        transition: 0.3s;
    }

    .mypage-modal.modal[data-name="mypage-modal"] .modal-body ul.link-wrap li:hover {
        border-color: #007bff;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-body ul.link-wrap li:hover a {
        color: #007bff;
        font-weight: 600;
    }
    .mypage-modal.modal[data-name="mypage-modal"] .modal-body ul.link-wrap li:hover a.active {
        color: #007bff;
        font-weight: 600;
    }
</style>