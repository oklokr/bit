<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String id = request.getParameter("id");
    request.setAttribute("id", id);
%>
<div class="container edit-page">
    <h2>상품정보 등록</h2>
    <div class="product-form">
        <h3 class="title">필수입력 정보</h3>
        <dl>
            <dt>상품명</dt>
            <dd>
                <c:if test='${empty id}'>
                    <input type="text">
                </c:if>
                <c:if test="${not empty id}">
                    <input type="text" value="${productInfo.productName}">
                </c:if>
            </dd>
            <dt>상품설명</dt>
            <dd>
                <c:if test='${empty id}'>
                    신규
                    <input type="text">
                </c:if>
                <c:if test="${not empty id}">
                    수정
                    <input type="text" value="${productInfo.productDescription}">
                </c:if>
            </dd>
            <dt>카테고리 설정</dt>
            <dd>
                <c:if test='${empty id}'>
                    신규
                    <select class="form-select" aria-label="Default select">
                        <c:forEach var="code" items="${commonCodes}">
                            <option value="${code.commonValue}">${code.commonName}</option>
                        </c:forEach>
                    </select>
                </c:if>
                <c:if test="${not empty id}">
                    수정
                    <select class="form-select" aria-label="Default select">
                        
                        <c:forEach var="code" items="${commonCodes}">
                            <c:if test='${code.commonValue eq productInfo.categoryCode}'>
                                <option checked value="${code.commonValue}">${code.commonName}</option>
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

    <div class="product-form">
        <h3 class="title">이미지 정보</h3>
        <dl>
            <dt>상품 이미지</dt>
            <dd></dd>
        </dl>
    </div>
</div>

<style>
    .edit-page {
        padding: 30px 0 60px;
    }
    .edit-page h2 {
        font-weight: bold;
        text-align: center;
    }

    .product-form {
        margin-top: 60px;
    }
    .product-form .title {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 16px;
    }

    .product-form dl {
        display: flex;
        flex-wrap: wrap;
    }

    .product-form dl dt {
        width: 230px;
        text-align: center;
        padding: 20px 12px;
        border: 1px solid #dee2e6;
    }
    .product-form dl dd {
        width: calc(100% - 230px);
        border: 1px solid #dee2e6;
        margin-bottom: 0;
    }
</style>