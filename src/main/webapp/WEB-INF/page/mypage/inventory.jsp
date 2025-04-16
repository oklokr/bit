<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String productName = request.getParameter("productName");
    String registrationDate = request.getParameter("registrationDate");
%>
<div class="container page-wrap">
    <h2 class="page-title">재고관리</h2>

    <div class="filter-wrap">
        <div class="row">
            <label for="productName" class="col-sm-2 col-form-label">상품명</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="productName" placeholder="상품명을 입력해주세요." value="<%= productName != null ? productName : "" %>">
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
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="handleDeleteInventory()">삭제</button>
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="handleSaveInventory()">적용</button>
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <th><input type='checkbox' class='form-check-input' data-target="all-check"></th>
                    <th>카테고리</th>
                    <th>이미지</th>
                    <th>상품명</th>
                    <th>상품설명</th>
                    <th>재고수량</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <ol class="pagination"></ol>
    </div>
</div>

<script>
function getUrlParam(param) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param) || '';
}

function handleFilter() {
    const productName = document.getElementById('productName').value.trim();

    const urlParams = new URLSearchParams();
    if (productName) {
        urlParams.set('productName', productName);
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
        prevGroupItem.innerHTML = "<a href='?page=" + (startPage - 1) + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "' class='page-link'>&lt;</a>";
        pagination.appendChild(prevGroupItem);
    }

    // 현재 그룹의 페이지 버튼
    for (let i = startPage; i <= endPage; i++) {
        const pageItem = document.createElement('li');
        pageItem.className = 'page-item';
        const linkClass = (i === currentPage) ? 'active' : '';
        pageItem.innerHTML = 
            "<a href='?page=" + i + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "' class='page-link " + linkClass + "'>" + i + "</a>";
        pagination.appendChild(pageItem);
    }

    // 다음 그룹 버튼
    if (endPage < totalPages) {
        const nextGroupItem = document.createElement('li');
        nextGroupItem.className = 'page-item';
        nextGroupItem.innerHTML = "<a href='?page=" + (endPage + 1) + "&productName=" + encodeURIComponent(getUrlParam('productName')) + "' class='page-link'>&gt;</a>";
        pagination.appendChild(nextGroupItem);
    }
}

function handleSetProduct() {
    const urlParams = new URLSearchParams(window.location.search);
    const page = parseInt(urlParams.get('page')) || 1;
    const productName = urlParams.get('productName') || '';
    const postData = {
        page: page,
        size: 5, // 페이지당 항목 수
    };

    if (productName) {
        postData.productName = productName;
    }

    postRequestApi('/api/mypage/inventory', postData, res => {
        const data = res.data.data;
        document.querySelector('.total-txt > span').innerText = res.data.totalCount;
        
        const tbody = document.querySelector('.table-wrap table tbody');
        tbody.innerHTML = ''; // 기존 데이터 초기화

        data.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = 
            "<td><input type='checkbox' class='form-check-input' value='"+item.productId+"'></td>"
            + "<td>"+ item.categoryName +"</td>"
            + "<td><span class='image'><img src="+item.image+"></span></td>"
            + "<td>"+ item.productName +"</td>"
            + "<td>"+ item.productDescription +"</td>"
            + "<td class='count-cell'>"
                + "<div class='count-wrap'>"
                    + "<button class='btn btn-outline-secondary decrease-btn'><i class='bi bi-dash-lg'></i></button>"
                    + "<input type='text' class='stock-input' value='"+item.stockQuantity+"'>"
                    + "<button class='btn btn-outline-secondary increase-btn'><i class='bi bi-plus'></i></button>"
                + "</div>"
            + "</td>";
            tbody.appendChild(row);

            row.addEventListener("click", () => {
                const checkbox = row.querySelector('.form-check-input');
                checkbox.checked = !checkbox.checked; // 체크박스 상태 토글
            })

            document.querySelectorAll('.image img').forEach(img => {
                img.addEventListener('error', () => {
                    img.src = 'https://onsight.softballspa.com/content/images/thumbs/default-image_450.png';
                });
            });

            // 버튼 이벤트 추가
            const decreaseBtn = row.querySelector('.decrease-btn');
            const increaseBtn = row.querySelector('.increase-btn');
            const stockInput = row.querySelector('.stock-input');

            // 감소 버튼 클릭 이벤트
            decreaseBtn.addEventListener('click', () => {
                let currentValue = parseInt(stockInput.value) || 0;
                if (currentValue > 0) {
                    stockInput.value = currentValue - 1;
                }
            });

            // 증가 버튼 클릭 이벤트
            increaseBtn.addEventListener('click', () => {
                let currentValue = parseInt(stockInput.value) || 0;
                stockInput.value = currentValue + 1;
            });

            // 숫자만 입력 가능하도록 제한 (change 이벤트)
            stockInput.addEventListener('change', (e) => {
                const value = e.target.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자는 제거
                e.target.value = value || 0; // 빈 값일 경우 0으로 설정
            });
        });

        if(res.data.totalCount < 1) {
            tbody.innerHTML = 
            '<tr>'
                + '<td colspan="6">'
                    + '<p class="msg-box" style="margin-bottom: 0;">'
                        + '<span style="color: #bbb">등록된 재고가 없습니다.</span>'
                    + '</p>'
                + '</td>'
            + '</tr>';
        }

        const selectAllCheckbox = document.querySelector('input[data-target="all-check"]');
        selectAllCheckbox.addEventListener('change', e => {
            const isChecked = e.target.checked;
            const rowCheckboxes = document.querySelectorAll('.form-check-input');
            rowCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
        });

        document.querySelectorAll('.count-cell').forEach(item => {
            item.addEventListener('click', e => {
                e.stopPropagation(); // 클릭 이벤트 전파 방지
            });
        })

        handlePagination(res.data.totalCount, page, postData.size);
    });
}

function handleSaveInventory() {
    const tbody = document.querySelector('.table-wrap table tbody');
    const rows = tbody.querySelectorAll('tr');
    const postForm = [];

    rows.forEach(row => {
        const checkbox = row.querySelector('.form-check-input');
        if (checkbox.checked) {
            const productId = checkbox.value;
            const stockInput = row.querySelector('.stock-input');
            const stockQuantity = parseInt(stockInput.value) || 0;
            postForm.push({ productId, stockQuantity });
        }
    });

    if (postForm.length === 0) return modal({ content: "변경된 재고가 없습니다." });

    postRequestApi('/api/mypage/updateInventory', postForm, res => {
        modal({ content: "재고가 업데이트 되었습니다.",  fnClose: () => handleSetProduct()});
    });
}

function handleDeleteInventory() {
    const tbody = document.querySelector('.table-wrap table tbody');
    const rows = tbody.querySelectorAll('tr');
    const deleteData = [];

    rows.forEach(row => {
        const checkbox = row.querySelector('.form-check-input');
        if (checkbox.checked) {
            const productId = checkbox.value;
            deleteData.push(productId);
        }
    });

    if (deleteData.length === 0) return modal({ content: "삭제할 상품을 선택해주세요." });

    modal({
        content: "삭제하시겠습니까?",
        type: "confirm",
        fnConfirm: () => {
            postRequestApi('/api/mypage/deleteInventory', deleteData, res => {
                handleSetProduct()
                modal({content: "삭제되었습니다.", returnModal: true})
            })
        }
    });
}

function handleLoad() {
    handleSetProduct()
}

document.addEventListener("DOMContentLoaded", handleLoad)
</script>