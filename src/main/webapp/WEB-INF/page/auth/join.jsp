<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="auth-page signup">
    <div class="content">
        <ul>
            <jsp:include page="./component/terms.jsp" />
            <jsp:include page="./component/userInfo.jsp" />
            <jsp:include page="./component/companyInfo.jsp" />
        </ul>
    </div>
</div>

<script>
    let step = 1;
    const postForm = {
        id: null,
        companyName: null,
        password: null,
        email: null,
        phoneNumber: null,
        businessNumber: null,
        address: null,
        detailedAddress: null,
        postalCode: null,
        termsList: [],
    }
    function handleStep(type) {
        step = type === "prev" ? step - 1 : step + 1;
        document.querySelectorAll(".signup li").forEach(li => li.classList.remove("active"));
        document.querySelector("li[data-step='" + step + "']").classList.add("active");
    }
    function handleLoad() {

    }
    document.addEventListener("DOMContentLoaded", handleLoad)
</script>

<style>
    .signup .content > ul {
        display: flex;
        justify-content: center;
        gap: 20px;
        position: relative;
        padding-left: initial;
    }
    .signup .content > ul > li {
        min-height: 700px;
        padding-top: 80px;
    }
    .signup .content > ul > li::before {
        display: flex;
        align-items: center;
        justify-content: center;
        content: attr(data-step);
        width: 30px;
        height: 30px;
        font-weight: bold;
        color: #fff;
        border-radius: 50%;
        background-color: #e9ecef;
    }
    .signup .content > ul > li.active::before {
        background-color: #007bff;
    }
    .signup .content > ul > li.active .page-title {
        display: block;
    }
    .signup .content > ul > li.active .inner {
        display: flex;
    }
    .signup .page-title {
        display: none;
        width: 100%;
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
    }
    .signup .inner {
        display: none;
        flex-direction: column;
        width: 100%;
        height: 600px;
        padding-top: 40px;
        position: absolute;
        left: 0;
    }
    .signup .inner.step-1 {
        padding-top: 60px;
    }
    .signup .inner .bottom-btns {
        margin-top: auto;
    }

    .form-check.type-box {
        font-size: 18px;
        font-weight: bold;
        padding: 24px 50px;
        border-radius: 12px;
        background: #e9ecef;
    }
    .form-check.type-box label {
        width: 100%;
        cursor: pointer;
    }

    .terms-list {
        padding: 0 22px;
        margin-top: 40px;
    }

    .terms-list .form-check {
        display: flex;
        position: relative;
    }
    .terms-list .form-check + .form-check {
        margin-top: 20px;
    }

    .terms-list .form-check .form-check-label {
        margin-left: 8px;
    }
    .terms-list .form-check .btn {
        padding: 0 8px;
        font-weight: bold;
    }
    .terms-list .form-check .btn span {
        width: 1px;
        height: 1px;
        color: transparent;
        text-indent: -9999px;
        position: absolute;
    }
</style>