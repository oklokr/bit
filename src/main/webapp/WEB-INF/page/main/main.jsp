<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container main-wrap">
    <h2>상품정보</h2>
    <div class="input-group-lg search-warp">
        <input type="text" class="form-control" placeholder="검색어를 입력해주세요." aria-label="검색어를 입력해주세요." aria-describedby="button-addon2">
        <button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
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
        <div class="carousel-inner">
          <div class="carousel-item active">
            <ul class="inner">
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
                <li class="product-itme">
                    <div class="product-img">
                        <!-- <img src="/images/product/1.jpg" alt="상품이미지" class="img-fluid"> -->
                    </div>
                    <p class="product-info">
                        <i>상품설명</i>
                        <strong>상품명</strong>
                        <span>상품설명</span>
                    </p>
                    <button type="button" class="btn btn-secondary btn-sm">재고관리 추가</button>
                </li>
            </ul>
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#product-items" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#product-items" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
    </div>

    <button type="button" class="more btn btn-primary btn-sm">더보기</button>
</div>

<script>
</script>

<style>
    .main-wrap {
        padding: 30px 62px 60px;
    }
    .main-wrap h2 {
        font-weight: bold;
        text-align: center;
    }
    .main-wrap .search-warp {
        margin-top: 40px;
    }

    .category-list {
        display: flex;
        gap: 8px;
        padding: 30px 0;
    }

    .search-warp.input-group-lg {
        position: relative;
    }
    .search-warp button.btn {
        min-width: 80px;
        border: initial;
        position: absolute;
        top: 1px;
        right: 0;
        z-index: 6;
        color: transparent;
        text-indent: -9999px;
        background: url("/images/icons/search.png") no-repeat center center;
        background-size: 28px 28px;
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
        justify-content: space-between;
        margin-bottom: 0;
        padding-left: 0;
        gap: 20px;
    }

    #product-items .inner li {
        width: 230px;
    }
    #product-items .product-itme .product-img {
        width: 230px;
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
    }
    
    .main-wrap .more {
        display: block;
        min-width: 360px;
        margin: 60px auto 0;
    }
</style>