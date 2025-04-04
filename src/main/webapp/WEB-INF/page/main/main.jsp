<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container main-wrap">
    <h2>상품정보</h2>
    <div class="input-group search-warp">
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
            <div class="inner">
                <span>test</span>
            </div>
          </div>
          <div class="carousel-item">
            <div class="inner">
                <span>test</span>
            </div>
          </div>
          <div class="carousel-item">
            <div class="inner">
                <span>test</span>
            </div>
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
</div>

<script>
</script>

<style>
    .main-wrap {
        padding-top: 30px;
    }
    .main-wrap h2 {
        font-weight: bold;
    }
    .main-wrap .search-warp {
        margin-top: 40px;
    }

    .category-list {
        display: flex;
        gap: 8px;
        padding: 30px 0;
    }

    .search-warp.input-group:not(.has-validation)>:not(:last-child):not(.dropdown-toggle):not(.dropdown-menu):not(.form-floating) {
        border-top-right-radius: var(--bs-border-radius);;
        border-bottom-right-radius: var(--bs-border-radius);;
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
        background-size: 24px 24px;
    }

    #category-items .carousel-control-next,
    #category-items .carousel-control-prev,
    #product-items .carousel-control-next, 
    #product-items .carousel-control-prev {
        width: initial;
    }

    #category-items .carousel-item {
        padding: 0 50px;
    }
    #category-items .carousel-control-prev,
    #category-items .carousel-control-next {
        color: #000;
    }

    #product-items .carousel-item {
        padding: 0 50px;
    }
    
</style>