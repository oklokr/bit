<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String productName = request.getParameter("productName");
    String registrationDate = request.getParameter("registrationDate");
%>
<div class="container product-page">
    <h2>상품정보 등록</h2>

    <div class="filter">
        <div class="row">
            <label for="productName" class="col-sm-2 col-form-label">상풍명</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="productName" value="<%= productName != null ? productName : "" %>">
            </div>
        </div>
        <div class="row">
            <span class="col-sm-2 col-form-label">등록일</span>
            <div class="col-sm-8">
                <div class="input-group">
                    <input id="registrationDate" type="text" class="form-control" value="<%= registrationDate != null ? registrationDate : "" %>">
                    <label class="input-group-text" for="registrationDate"><i class="bi bi-calendar"></i></label>
               </div> 
            </div>
        </div>
        <button type="button" class="btn btn-primary btn-sm" onclick="handleFilter()">조회</button>
    </div>

    <div class="table-wrap">
        <div class="top-area">
            <p class="total-txt">
                총 <span></span>개
            </p>
            <a href="/main/productEdit" role="button" class="btn btn-primary btn-sm">상품등록</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>상품정보 번호</th>
                    <th>카테고리</th>
                    <th>이미지</th>
                    <th>상품명</th>
                    <th>상품설명</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <ol class="pagination"></ol>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#registrationDate').datepicker({
        autoclose : true,
        clearBtn: true,
        language : "ko"
    });
    $('#registrationDate').on('changeDate', function() {
        $('#my_hidden_input').val(
            $('#registrationDate').datepicker('getFormattedDate')
        );
    });
})

function getUrlParam(param) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param) || '';
}

function handleFilter() {
    const productName = document.getElementById('productName').value.trim();
    const registrationDate = document.getElementById('registrationDate').value.trim();

    const urlParams = new URLSearchParams();
    if (productName) {
        urlParams.set('productName', productName);
    }
    if (registrationDate) {
        urlParams.set('registrationDate', registrationDate);
    }
    urlParams.set('page', 1); // 필터 변경 시 페이지를 1로 초기화

    window.location.search = urlParams.toString(); // URL 갱신 및 페이지 새로고침
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
            '<a href="?page=' + i + '&productName='+ getUrlParam('productName') +'&registrationDate='+ getUrlParam('registrationDate') +'" class="page-link ' + linkClass + '">' +
                i +
            '</a>';
        pagination.appendChild(pageItem);
    }
}

function handleSetProduct() {
    const urlParams = new URLSearchParams(window.location.search);
    const page = parseInt(urlParams.get('page')) || 1;
    const productName = urlParams.get('productName') || '';
    const registrationDate = urlParams.get('registrationDate') || '';
    const postData = {
        page: page,
        size: 10, // 페이지당 항목 수
    };

    if (productName) {
        postData.productName = productName;
    }
    if (registrationDate) {
        postData.registrationDate = registrationDate;
    }

    postRequestApi('/api/mypage/info', {}, res => {
        if(validate.isEmpty(res.data.id)) return
        postData.id = res.data.id
        postRequestApi('/api/main/product', postData, res => {
            const data = res.data.data;
            document.querySelector('.total-txt > span').innerText = res.data.totalCount;
            
            const tbody = document.querySelector('.table-wrap table tbody');
            tbody.innerHTML = ''; // 기존 데이터 초기화

            data.forEach(item => {
                console.log(item)
                const row = document.createElement('tr');
                row.innerHTML = 
                "<td>"+ item.productId +"</td>"
                + "<td>"+ item.categoryName +"</td>"
                + "<td><span class='image'><img src='${item.imageUrl}' alt='상품 이미지'></span></td>"
                + "<td>"+ item.productName +"</td>"
                + "<td>"+ item.productDescription +"</td>"
                console.log(row)
                tbody.appendChild(row);

                row.addEventListener("click", () => {
                    location="/main/productEdit?id="+item.productId+""
                })
            });
            handlePagination(res.data.totalCount, page, postData.size);
        });
    });
}

function handleLoad() {
    handleSetProduct()
}

document.addEventListener("DOMContentLoaded", handleLoad)


</script>

<style>
    .product-page {
        padding: 30px 0 60px;
    }
    .product-page h2 {
        font-weight: bold;
        text-align: center;
    }
    .product-page .filter {
        display: flex;
        align-items: center;
        height: 68px;
        padding: 0 32px;
        margin-top: 40px;
        border: 1px solid #dee2e6;
        border-radius: 12px;
    }
    .product-page .filter .row {
        flex: 1;
    }
    .product-page .filter > button {
        min-width: 70px;
    }

    .table-wrap {
        margin-top: 40px;
    }
    .table-wrap .top-area {
        display: flex;
        width: 100%;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 16px;
    }
    .table-wrap .top-area .total-txt {
        margin-bottom: 0;
    }
    .table-wrap .top-area button {
        display: block;
        min-width: 80px;
    }
    .table-wrap table {
        width: 100%;
        text-align: center;
    }
    .table-wrap table thead tr {
        border: 2px solid #dee2e6;
        border-left: 0;
        border-right: 0;
    }
    .table-wrap table thead tr th {
        padding: 16px 12px;
        font-weight: bold;
        background-color: #fcfcfc;
        vertical-align: middle;
    }
    .table-wrap table thead tr th:not(:last-child) {
        border-right: 2px solid #dee2e6;
    }

    .table-wrap table tbody tr {
        cursor: pointer;
        border-bottom: 2px solid #dee2e6;
    }
    .table-wrap table tbody tr:hover td {
        background-color: #00000005;
    }
    .table-wrap table tbody tr td {
        padding: 16px 12px;
        vertical-align: middle;
    }
    .table-wrap table tbody tr td:not(:last-child) {
        border-right: 2px solid #dee2e6;
    }
    .table-wrap table .image {
        display: flex;
        width: 100px;
        height: 100px;
        margin: 0 auto;
        border-radius: 12px;
        background: #ccc;
    }
    .table-wrap .pagination {
        justify-content: center;
        margin-top: 40px;
    }
</style>