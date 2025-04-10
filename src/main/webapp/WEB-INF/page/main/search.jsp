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
    <p class="total">총 <span></span>개</p>
    <div class="content">
    </div>

    <ol class="pagination"></ol>
</div>

<script>
    function handleSetProduct(keyword, categoryCode) {
        const urlParams = new URLSearchParams(window.location.search);
        const page = parseInt(urlParams.get('page')) || 1;
        const postData = {
            page: page,
            size: 16,
        }
        if(!validate.isEmpty(keyword)) {
            postData.productName = keyword;
        }
        if(!validate.isEmpty(categoryCode)) {
            postData.categoryCode = categoryCode;
        }
        const setProductList = res => {
            const products = res.data.data;
            const totalCount = res.data.totalCount;
            const content = document.querySelector('.content');
            const productList = document.createElement('ul');
            content.innerHTML = '';
            productList.className = 'product-list';
            productList.innerHTML = '';
            if(totalCount > 0) {
                document.querySelector('.total').style.display = "block";
                document.querySelector('.pagination').style.display = "flex";
                products.forEach(item => {
                    const productItem = document.createElement('li');
                    productItem.className = 'product-itme';
                    productItem.innerHTML = 
                    "<div class='product-inner'>"
                        +"<div class='product-img'>"
                            + "<img src="+ item.categoryName +" alt='상품이미지' class='img-fluid'>"
                        + "</div>"
                        + "<p class='product-info'>"
                            + "<i>"+ item.categoryName +"</i>"
                            + "<strong>"+ item.productName +"</strong>"
                            + "<span>"+ item.productDescription +"</span>"
                        + "</p>"
                        + "<button type='button' class='btn btn-secondary btn-sm'>재고관리 추가</button>";
                    + '</div>'
                    
                    productList.appendChild(productItem);

                    productItem.querySelector(".product-inner button").addEventListener("click", () => {
                        modal({
                            content: "병원재고 관리에 추가하시겠습니까?",
                            type: "confirm",
                            fnConfirm: () => handleAddInventory(item.productId)
                        });
                    });
                })
                content.append(productList)
            } else {
                document.querySelector('.total').style.display = "none";
                document.querySelector('.pagination').style.display = "none";
                document.querySelector('.search-page').appendChild
                content.innerHTML = 
                "<p class='msg-box'>"
                    + "<i class='bi bi-exclamation-circle'></i>"
                    + "<span>해당 조건으로 검색된 결과가 없습니다.</span>"
                + "</p>"
                
            }
            document.querySelector('.total > span').innerText = totalCount.toLocaleString();
            handlePagination(totalCount, page, postData.size);
        }
        postRequestApi('/api/main/product', postData, setProductList);
    }
    function handleCategoryChnage(keyword) {
        const categoryList = document.querySelectorAll('.category-list input[name="category"]');
        categoryList.forEach(item => {
            item.addEventListener('change', e => {
                const categoryCode = e.target.value;
                const urlParams = new URLSearchParams(window.location.search);
                urlParams.set('categoryCode', categoryCode);
                urlParams.set('page', 1);
                window.history.replaceState({}, '', '?' + urlParams.toString());

                handleSetProduct(keyword, categoryCode);
            });
        });
    }
    function handlePagination(totalCount, currentPage, pageSize) {
        const pagination = document.querySelector('.pagination');
        pagination.innerHTML = ''; // 기존 페이지네이션 초기화
        const totalPages = Math.ceil(totalCount / pageSize); // 전체 페이지 수 계산
        for (let i = 1; i <= totalPages; i++) {
            const pageItem = document.createElement('li');
            pageItem.className = 'page-item';
            const linkClass = (i === currentPage) ? 'active' : '';
            pageItem.innerHTML = 
                '<a href="?page=' + i + '" class="page-link ' + linkClass + '">' +
                    i +
                '</a>';
            pagination.appendChild(pageItem);
        }
    }
    function handleLoad() {
        const url = new URL(window.location.href).searchParams;
        const keyword = url.get('keyword');
        const page = parseInt(url.get('page')) || 1;
        const categoryCode = url.get('categoryCode') || '';

        if (validate.isEmpty(keyword)) {
            document.querySelector(".txt-result").style.display = 'none';
        } else {
            document.querySelector(".txt-result > strong").innerText = '"'+keyword+'"';
            document.querySelector(".txt-result").style.display = 'block';
            document.querySelector(".form-control").value = keyword;
        }

        const categoryList = document.querySelectorAll('.category-list input[name="category"]');
        categoryList.forEach(item => {
            item.checked = item.value === categoryCode;
        });

        handleSetProduct(keyword, categoryCode, page);
        handleCategoryChnage(keyword);
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

    .search-page .pagination {
        justify-content: center;
        margin-top: 60px;
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

    .product-list {
        display: flex;
        flex-wrap: wrap;
        padding-left: 0;
        margin-bottom: 0;
        gap: 30px 20px;
    }

    .product-list .product-itme {
        display: flex;
        min-width: calc(100% / 4 - 15px);
        flex-direction: column;
        gap: 4px;
    }

    .product-list .product-inner {
        display: flex;
        width: 184px;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
    }
    @media (min-width: 1200px) {
        .product-list .product-inner {
            width: 230px;
        }
    }

    .product-list .product-itme .product-img {
        width: 100%;
        height: 230px;
        border-radius: 10px;
        background-color: #eee;
    }
    .product-list .product-itme .product-info {
        display: flex;
        flex-direction: column;
        margin-top: 10px;
    }

    .product-list .product-itme .product-info i {
        font-size: 12px;
        color: #999;
    }
    .product-list .product-itme .product-info span {
        font-size: 14px;
        color: #666;
    }

    .product-list .product-itme button {
        width: 100%;
        margin-top: auto;
    }

    .msg-box {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        height: 300px;
        font-size: 2em;
        gap: 30px;
        font-weight: bold;
    }
    .msg-box i {
        font-size: 5em;
        color: #ccc;
    }
</style>