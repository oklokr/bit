<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<li data-step="1" class="active">
    <h2 class="page-title">이용약관 동의</h3>

    <div class="inner step-1">
        <div class="form-check type-box">
            <input class="form-check-input" type="checkbox" value="" id="allCheck" onchange="handleCheckAll()">
            <label class="form-check-label" for="allCheck">약관 모두 동의</label>
        </div>

        <div class="terms-list">
            <c:forEach var="code" items="${termsList}">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="${code.termsType}" data-required="${code.termsRequired}" onchange="handleCheck()">
                    <label class="form-check-label" for="${code.termsType}">${code.termsRequired == 1 ? "(필수)" : "(선택)"} ${code.termsTitle}</label>
                    <button type="button" class="btn" onclick="termsModal('${code.termsType}')">
                        <span>상세보기</span>
                        <i class="bi bi-chevron-right"></i>
                    </button>
                </div>
            </c:forEach>
        </div>

        <div class="bottom-btns center">
            <button class="btn btn-outline-primary" onclick="history.back()">이전</button>
            <button class="btn btn-primary" onclick="handleTermsSubmit()">다음</button>
        </div>
    </div>
</li>

<!-- 약관 -->
<div class="modal fade modal-fullscreen" id="termsModal" tabindex="-1" aria-labelledby="termsLabel" aria-hidden="true" data-name="terms-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <strong class="modal-title fs-5" id="termsModalLabel"></strong>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body"></div>
        </div>  
    </div>
</div>

<script>
    function handleCheckAll() {
        const allCheck = document.getElementById("allCheck");
        const checkboxes = document.querySelectorAll(".terms-list .form-check-input");
        checkboxes.forEach(checkbox => checkbox.checked = allCheck.checked);
    }
    function handleCheck() {
        const allCheck = document.getElementById("allCheck");
        const checkboxes = document.querySelectorAll(".terms-list .form-check-input");
        allCheck.checked = Array.from(checkboxes).every((cb) => cb.checked);
    }

    function handleTermsSubmit() {
        let isValid = false;
        const checkItem = document.querySelectorAll(".terms-list .form-check-input");
        const requiredLength = Array.from(checkItem).filter(item => item.getAttribute("data-required") === "1").length;
        const checkedLength = Array.from(checkItem).filter(item => item.getAttribute("data-required") === "1" && item.checked).length;

        if(checkedLength < requiredLength) return modal({content: "필수 약관에 동의해주세요."});

        
        postForm.termsList = Array.from(checkItem).map((item, idx) => {
            return {
                termsType: item.getAttribute("id"),
                checked: item.checked ? "1" : "0"
            }
        })
        handleStep()
    }
</script>
