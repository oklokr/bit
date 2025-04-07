<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container search-page">
    <h2>검색</h2>
    <div class="input-group-lg search-wrap">
        <input type="text" class="form-control" placeholder="검색어를 입력해주세요." aria-label="검색어를 입력해주세요." aria-describedby="button-addon2">
        <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="handleSearch()">검색</button>
    </div>

    <p class="txt-result" style="display: none;">
        <strong></strong>
        <span>검색결과</span>
    </p>

    <ul class="category-list">
        <li>
            <input type="radio" class="btn-check" name="category" id="category-all" value="" checked>
            <label class="btn btn-outline-primary btn-sm" for="category-all">전체</label>
        </li>
        <c:forEach var="code" items="${commonCodes}">
            <li>
                <input type="radio" class="btn-check" name="category" id="${code.commonValue}" value="${code.commonValue}">
                <label class="btn btn-outline-primary btn-sm" for="${code.commonValue}">${code.commonName}</label>
            </li>
        </c:forEach>
    </ul>

    <ul>
        <li>
            <div class='product-inner'>
                <div class='product-img'>
                    <img src="item.categoryName" alt='상품이미지' class='img-fluid'>
                </div>
                <p class='product-info'>
                    <i>item.categoryName</i>
                    <strong>item.productName</strong>
                    <span>item.productDescription</span>
                </p>
                <button type='button' class='btn btn-secondary btn-sm'>재고관리 추가</button>
            </div>
        </li>
    </ul>
</div>

<script>
    function handleLoad() {
        const url = new URL(window.location.href).searchParams;
        const keyword = url.get('keyword');

        if (validate.isEmpty(keyword)) {
            document.querySelector(".txt-result").style.display = 'none';
        } else {
            const resultTxt = `${keyword} 검색결과`;
            document.querySelector(".txt-result > strong").innerText = keyword;
            document.querySelector(".txt-result").style.display = 'block';
        }

        handleSetProduct();
    }
    function handleSetProduct(categoryCode) {
        const postData = {
            page: 1,
            size: 16,
        }
        if(!validate.isEmpty(categoryCode)) {
            postData.categoryCode = categoryCode;
        }
        const setProductList = res => {
            console.log(res)
        }

        postRequestApi('/api/main/product', postData, setProductList);
    }
    document.addEventListener("DOMContentLoaded", handleLoad)
</script>

<style>
    .search-page {
        padding: 30px 62px 60px;
    }
    .search-page h2 {
        font-weight: bold;
        text-align: center;
    }
    .search-page .search-wrap {
        margin-top: 40px;
    }

    .category-list {
        display: flex;
        gap: 8px;
        padding: 30px 0;
    }

    .txt-result {
        display: block;
        font-size: 1.8rem;
        text-align: center;
        margin-top: 30px;
        font-weight: bold;
    }
</style>