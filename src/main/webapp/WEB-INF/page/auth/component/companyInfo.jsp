<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<li data-step="3">
    <h2 class="page-title">사업자 정보입력</h3>
    <div class="inner">
        <div class="auth-form">
            <div class="input-item row-form">
                <label for="businessNumber">사업자 번호</label>
                <input id="businessNumber" type="text" class="form-control" placeholder="사업자번호를 입력해주세요." maxlength="12" autofocus>
                <button class="btn btn-outline-secondary btn-sm" onclick="handleBusinessNumberCheck()">번호확인</button>
                <span class="error-msg"></span>
            </div>

            <div class="input-item row-form">
                <label for="address">주소</label>
                <span id="address" class="form-control">주소검색을 해주세요.</span>
                <button class="btn btn-outline-secondary btn-sm" onclick="handleAddressSearch()">주소검색</button>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="detailedAddress">상세주소</label>
                <input id="detailedAddress" type="text" class="form-control" placeholder="상세주소를 입력해주세요." maxlength="50" autofocus>
                <span class="error-msg"></span>
            </div>

            <div class="input-item">
                <label for="postalCode">우편번호</label>
                <span id="postalCode" class="form-control">주소검색을 해주세요.</span>
                <span class="error-msg"></span>
            </div>
        </div>
        <div class="bottom-btns center">
            <button class="btn btn-outline-primary" onclick="handleStep('prev')">이전</button>
            <button class="btn btn-primary" onclick="handleSignup()">가입</button>
        </div>
    </div>
</li>

<script>
    let businessNumberCheck = false;
    function handleBusinessNumberCheck() {
        const businessNumber = document.querySelector("#businessNumber")
        if(!validate.isBusinessNumber(businessNumber.value)) {
            modal({ content: "유효하지 않은 사업자번호입니다." })
            businessNumberCheck = false
        } else {
            modal({ content: "사용 가능한 사업자번호입니다." })
            businessNumber.parentElement.querySelector(".error-msg").innerHTML = ""
            businessNumberCheck = true
        }
    }
    function handleAddressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                const {userSelectedType, roadAddress, jibunAddress, zonecode} = data;
                const address = userSelectedType === 'R' ? roadAddress : jibunAddress;

                postForm.address = address
                postForm.postalCode = zonecode

                document.querySelector("#address").innerText = address;
                document.querySelector("#postalCode").innerText = zonecode;
                document.getElementById('detailedAddress').focus();
            }
        }).open();
    }
    function handleSignup() {
        const {address, postalCode} = postForm
        const elBusinessNumber = document.querySelector("#businessNumber")
        const elAddress = document.querySelector("#address");
        const elDetailedAddress = document.querySelector("#detailedAddress");
        const elPostalCode = document.querySelector("#postalCode");
        
        const validateError = (el, msg) => {
            console.log(el)
            modal({ content: msg })
            el.focus()
            el.parentElement.querySelector(".error-msg").innerHTML = "&#8251; "+ msg +""
        }
        
        if(validate.isEmpty(elBusinessNumber.value)) return validateError(elBusinessNumber, "사업자번호를 입력해주세요.")
        if(!businessNumberCheck) return validateError(elBusinessNumber, "사업자번호를 확인해주세요.")
        if(validate.isEmpty(address)) return validateError(elAddress, "주소검색을 해주세요.")
        if(validate.isEmpty(postalCode)) return validateError(elPostalCode, "주소검색을 해주세요.")

        postForm.businessNumber = elBusinessNumber.value
        postForm.detailedAddress = elDetailedAddress.value

        console.log(postForm)
        console.log(postForm.termsList)

        postRequestApi("/api/auth/join", postForm, res => {
            if(res.data !== 1) return modal({ content: "서버오류" });

            postRequestApi("/api/login", {
                id: postForm.id,
                passwd: postForm.password
            }, res => {
                if(res.data === 0) return modal({ content: "서버오류" });
                location.href = "/auth/joinResult";
            })
        })
    }

    document.querySelector("#businessNumber").addEventListener("input", event => {
        const formattedValue = formatBusinessNumber(event.target.value);
        event.target.value = formattedValue;
    });
</script>