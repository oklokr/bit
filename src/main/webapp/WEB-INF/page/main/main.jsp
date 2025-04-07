<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container main-wrap">
    <h2>상품정보</h2>
    <div class="input-group-lg search-wrap">
        <input type="text" class="form-control" placeholder="검색어를 입력해주세요." aria-label="검색어를 입력해주세요." aria-describedby="button-addon2">
        <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="handleSearch()">검색</button>
    </div>

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

    <div id="product-items" class="carousel slide" data-bs-theme="dark">
        <div class="carousel-inner"></div>
        <button class="carousel-control-prev" type="button" data-bs-target="#product-items" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#product-items" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
    </div>

    <a class="more btn btn-primary btn-sm" href="/main/search" role="button">더보기</a>
</div>

<script>
    function handleSetProduct(categoryCode) {
        const productItems = document.querySelector('#product-items .carousel-inner');
        const postData = {
            page: 1,
            size: 24,
        }
        if(!validate.isEmpty(categoryCode)) {
            postData.categoryCode = categoryCode;
        }
        const setProductList = res => {
            const products = res.data;
            const groupSize = 8;
            let currentGroup = null;

            products.forEach((item, index) => {
                if (index % groupSize === 0) {
                    currentGroup = document.createElement('div');
                    currentGroup.className = 'carousel-item';
                    if (index === 0) currentGroup.classList.add('active'); // 첫 번째 그룹에 active 클래스 추가

                    const innerList = document.createElement('ul');
                    innerList.className = 'inner';
                    currentGroup.appendChild(innerList);
                    productItems.appendChild(currentGroup);
                }
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
                
                currentGroup.querySelector('.inner').appendChild(productItem);
            });
        }
        postRequestApi('/api/main/product', postData, setProductList);
    }
    function handleLoad() {
        const categoryList = document.querySelectorAll('.category-list input[name="category"]');
        categoryList.forEach(item => {
            item.addEventListener('change', e => {
                const categoryCode = e.target.value;
                const productItems = document.querySelector('#product-items .carousel-inner');
                productItems.innerHTML = ''; // 기존 상품 목록 초기화
                handleSetProduct(categoryCode);
            });
        });
        handleSetProduct();
    }
    document.addEventListener('DOMContentLoaded', handleLoad);
</script>

<style>
    .main-wrap {
        padding: 30px 62px 60px;
    }
    .main-wrap h2 {
        font-weight: bold;
        text-align: center;
    }
    .main-wrap .search-wrap {
        margin-top: 40px;
    }

    .category-list {
        display: flex;
        gap: 8px;
        padding: 30px 0;
    }

    #product-items {
        margin: 0 -50px;
    }
    #product-items .carousel-control-next, 
    #product-items .carousel-control-prev {
        width: initial;
    }
    #product-items .carousel-item {
        padding: 0 50px;
    }
    #product-items .inner {
        display: flex;
        flex-wrap: wrap;
        gap: 30px 20px;
        margin-bottom: 0;
        padding-left: 0;
    }

    #product-items .inner li {
        min-width: calc(100% / 4 - 15px);
        align-items: center;
    }

    #product-items .inner li .product-inner {
        display: flex;
        width: 184px;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
    }
    @media (min-width: 1200px) {
        #product-items .inner li .product-inner {
            width: 230px;
        }
    }

    #product-items .product-itme {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    #product-items .product-itme .product-img {
        width: 100%;
        height: 230px;
        border-radius: 10px;
        background-color: #eee;
    }
    #product-items .product-itme .product-info {
        display: flex;
        flex-direction: column;
        margin-top: 10px;
    }

    #product-items .product-itme .product-info i {
        font-size: 12px;
        color: #999;
    }
    #product-items .product-itme .product-info span {
        font-size: 14px;
        color: #666;
    }

    #product-items .product-itme button {
        width: 100%;
        margin-top: auto;
    }
    
    .main-wrap .more {
        display: block;
        width: 360px;
        margin: 60px auto 0;
    }
</style>