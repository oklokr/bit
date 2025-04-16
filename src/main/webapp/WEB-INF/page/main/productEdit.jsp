<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String id = request.getParameter("id");
    request.setAttribute("id", id);
%>
<div class="container page-wrap">
    <h2 class="page-title">
        상품정보 
        <c:if test='${empty id}'>등록</c:if>
        <c:if test="${not empty id}">수정</c:if>
    </h2>
    <div class="data-form">
        <h3 class="title">필수입력 정보</h3>
        <dl>
            <dt>상품명</dt>
            <dd>
                <c:if test='${empty id}'>
                    <input type="text" placeholder="상품명을 입력해주세요." class="form-control" id="productName">
                </c:if>
                <c:if test="${not empty id}">
                    <input type="text" placeholder="상품명을 입력해주세요." class="form-control" id="productName" value="${productInfo.productName}">
                </c:if>
            </dd>
            <dt>상품설명</dt>
            <dd>
                <c:if test='${empty id}'>
                    <input type="text" placeholder="상품설명을 입력해주세요." class="form-control" id="productDescription">
                </c:if>
                <c:if test="${not empty id}">
                    <input type="text" placeholder="상품설명을 입력해주세요." class="form-control" id="productDescription" value="${productInfo.productDescription}">
                </c:if>
            </dd>
            <dt>카테고리 설정</dt>
            <dd>
                <c:if test='${empty id}'>
                    <select class="form-select" aria-label="Default select">
                        <option value="" selected disabled>카테고리를 선택해주세요.</option>
                        <c:forEach var="code" items="${commonCodes}">
                            <option value="${code.commonValue}">${code.commonName}</option>
                        </c:forEach>
                    </select>
                </c:if>
                <c:if test="${not empty id}">
                    <select class="form-select" aria-label="Default select">
                        <option value="" selected disabled>카테고리를 선택해주세요.</option>
                        <c:forEach var="code" items="${commonCodes}">
                            <c:if test='${code.commonValue eq productInfo.categoryCode}'>
                                <option value="${code.commonValue}" selected>${code.commonName}</option>
                            </c:if>
                            <c:if test='${code.commonValue ne productInfo.categoryCode}'>
                                <option value="${code.commonValue}">${code.commonName}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </c:if>
            </dd>
        </dl>
    </div>

    <div class="data-form">
        <h3 class="title">이미지 정보</h3>
        <dl>
            <dt>상품 이미지</dt>
            <dd>
                <c:if test='${empty id}'>
                    <input type="text" placeholder="이미지URL 주소를 입력해주세요." class="form-control" id="image">
                </c:if>
                <c:if test="${not empty id}">
                    <input type="text" placeholder="이미지URL 주소를 입력해주세요." class="form-control" id="image" value="${productInfo.image}">
                </c:if>
            </dd>
        </dl>
    </div>

    <div class="bottom-btns">
        <c:if test='${isAdmin}'>
            <button type="button" class="btn btn-primary left" onclick="handleDelete()">삭제</button>
        </c:if>
        
        <button type="button" class="btn btn-primary" onclick="history.back()">취소</button>
        <button type="button" class="btn btn-outline-primary" onclick="handleEdit()">
            <c:if test='${empty id}'>등록</c:if>
            <c:if test="${not empty id}">수정</c:if>
        </button>
    </div>
</div>

<script>
    function handleDelete() {
        const confirm = () => {
            const urlParams = new URLSearchParams(window.location.search);
            postRequestApi("/api/main/productDelete", {
                productId: parseInt(urlParams.get('id'))
            }, res => {
                if(res.data.resultCode !== 1) return
                modal({content: "삭제되었습니다.", fnClose: () => location.href = "/main/product", returnModal: true})
            })
        }
        modal({type: "confirm", title: "경고", content: "해당 상품과 연관된 회원의 정보가 사라집니다<br>삭제하시겠습니까?", fnConfirm: () => confirm()})
    }
    function handleEdit() {
        console.log('test');
        const urlParams = new URLSearchParams(window.location.search);
        const productId = parseInt(urlParams.get('id')) || null;
        const selectEl = document.querySelector(".form-select")
        const postForm = {
            productName: document.querySelector("#productName").value,
            productDescription: document.querySelector("#productDescription").value,
            categoryCode: selectEl.options[selectEl.selectedIndex].value,
            image: document.querySelector("#image").value
        }
        if(!validate.isEmpty(productId)) {
            postForm.productId = productId
        }

        if(validate.isEmpty(postForm.productName)) {
            return modal({content: "상품명을 입력해주세요.", type: "alert", fnClose: () => {
                document.querySelector("#productName").focus();
            }});
        }
        if(validate.isEmpty(postForm.productDescription)) {
            return modal({content: "상품설명을 입력해주세요.", type: "alert", fnClose: () => {
                document.querySelector("#productDescription").focus();
            }});
        }
        if(validate.isEmpty(postForm.categoryCode)) {
            return modal({content: "카테고리를 선택해주세요.", type: "alert", fnClose: () => {
                document.querySelector(".form-select").focus();
            }});
        }

        const modalMsg = productId ? '수정' : '등록'
        modal({
            content: "상품정보를 "+ modalMsg +"하시겠습니까?",
            type: "confirm",
            fnConfirm: () => postRequestApi("/api/main/productEdit", postForm, res => {
                if(res.data.resultCode === 1) {
                    return location.href = "/main/product"
                }
            })
        });
    }
</script>