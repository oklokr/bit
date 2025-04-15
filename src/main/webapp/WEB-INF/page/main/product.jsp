<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String productName = request.getParameter("productName");
    String registrationDate = request.getParameter("registrationDate");
%>
<div class="container page-wrap">
    <h2 class="page-title">상품정보 등록</h2>

    <div class="filter-wrap">
        <div class="row">
            <label for="productName" class="col-sm-2 col-form-label">상품명</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="productName" placeholder="상품명을 입력해주세요." value="<%= productName != null ? productName : "" %>">
            </div>
        </div>
        <div class="row">
            <span class="col-sm-2 col-form-label">등록일</span>
            <div class="col-sm-8">
                <div class="input-group">
                    <input id="registrationDate" type="text" class="form-control" autocomplete='off' placeholder="등록일을 입력해주세요." value="<%= registrationDate != null ? registrationDate : "" %>">
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
            <div class="btns">
                <a href="/main/productEdit" role="button" class="btn btn-outline-secondary btn-sm">상품등록</a>
            </div>
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
    urlParams.set('page', 1);

    window.location.search = urlParams.toString();
}

function handlePagination(totalCount, currentPage, pageSize) {
    const pagination = document.querySelector('.pagination');
    pagination.innerHTML = '';
    const totalPages = Math.ceil(totalCount / pageSize);
    const maxVisiblePages = 9;
    const currentGroup = Math.ceil(currentPage / maxVisiblePages);
    const startPage = (currentGroup - 1) * maxVisiblePages + 1;
    const endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);

    // 이전 그룹 버튼
    if (currentGroup > 1) {
        const prevGroupItem = document.createElement('li');
        prevGroupItem.className = 'page-item';
        prevGroupItem.innerHTML = "<a href='?page=" + (startPage - 1) + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "&registrationDate=" + encodeURIComponent(getUrlParam('registrationDate')) + "' class='page-link'>&lt;</a>";
        pagination.appendChild(prevGroupItem);
    }

    // 현재 그룹의 페이지 버튼
    for (let i = startPage; i <= endPage; i++) {
        const pageItem = document.createElement('li');
        pageItem.className = 'page-item';
        const linkClass = (i === currentPage) ? 'active' : '';
        pageItem.innerHTML = 
            "<a href='?page=" + i + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "&registrationDate=" + encodeURIComponent(getUrlParam('registrationDate')) + "' class='page-link " + linkClass + "'>" + i + "</a>";
        pagination.appendChild(pageItem);
    }

    // 다음 그룹 버튼
    if (endPage < totalPages) {
        const nextGroupItem = document.createElement('li');
        nextGroupItem.className = 'page-item';
        nextGroupItem.innerHTML = "<a href='?page=" + (endPage + 1) + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "&registrationDate=" + encodeURIComponent(getUrlParam('registrationDate')) + "' class='page-link'>&gt;</a>";
        pagination.appendChild(nextGroupItem);
    }
}

function handleSetProduct() {
    const urlParams = new URLSearchParams(window.location.search);
    const page = parseInt(urlParams.get('page')) || 1;
    const productName = urlParams.get('productName') || '';
    const registrationDate = urlParams.get('registrationDate') || '';
    const postData = {
        page: page,
        size: 5, // 페이지당 항목 수
    };

    if (productName) {
        postData.productName = productName;
    }
    if (registrationDate) {
        postData.productRegistrationDate = registrationDate;
    }

    postRequestApi('/api/mypage/info', {}, res => {
        if(validate.isEmpty(res.data.id)) return
        if(res.data.memberType !== 2) {
            postData.id = res.data.id
        }
        postRequestApi('/api/main/product', postData, res => {
            const data = res.data.data;
            document.querySelector('.total-txt > span').innerText = res.data.totalCount;
            
            const tbody = document.querySelector('.table-wrap table tbody');
            tbody.innerHTML = ''; // 기존 데이터 초기화

            data.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = 
                "<td>"+ item.productId +"</td>"
                + "<td>"+ item.categoryName +"</td>"
                + "<td><span class='image'><img src='"+item.image+"'></span></td>"
                + "<td>"+ item.productName +"</td>"
                + "<td>"+ item.productDescription +"</td>"
                tbody.appendChild(row);

                document.querySelectorAll('.image img').forEach(img => {
                    img.addEventListener('error', () => {
                        img.src = 'https://onsight.softballspa.com/content/images/thumbs/default-image_450.png';
                    });
                });

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