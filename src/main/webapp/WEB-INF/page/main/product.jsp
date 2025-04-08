<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container product-page">
    <h2>상품정보 등록</h2>

    <div class="filter">
        <div class="row">
            <label for="inputEmail3" class="col-sm-2 col-form-label">상풍명</label>
            <div class="col-sm-8">
                <input type="email" class="form-control" id="inputEmail3">
            </div>
        </div>
        <div class="row">
            <span for="inputEmail3" class="col-sm-2 col-form-label">등록일</span>
            <div class="col-sm-8">
                <div class="input-group">
                    <input id="datepicker" type="text" class="form-control">
                    <label class="input-group-text" for="datepicker" ><i class="bi bi-calendar"></i></label>
               </div> 
            </div>
        </div>
        <button type="button" class="btn btn-primary btn-sm">조회</button>
    </div>

    <div class="table-wrap">
        <div class="top-area">
            <p class="total-txt">
                총 <span></span>개
            </p>
            <button type="button" class="btn btn-primary btn-sm">상품등록</button>
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
                <tr>
                    <td>상품정보 번호</td>
                    <td>카테고리</td>
                    <td>
                        <span class="image">
                            <img src="" alt="">
                        </span>
                    </td>
                    <td>상품명</td>
                    <td>상품설명</td>
                </tr>
            </tbody>
        </table>
        <ol class="pagination"></ol>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#datepicker').datepicker({
        autoclose : true,
        language : "ko"
    });
    $('#datepicker').on('changeDate', function() {
        $('#my_hidden_input').val(
            $('#datepicker').datepicker('getFormattedDate')
        );
    });
})

function handleSetProduct() {
    postRequestApi('/api/mypage/info', {}, res => {
        const postData = {
            page: 1,
            size: 24,
            id: res.data.id
        }
        
        postRequestApi('/api/main/product', postData, res => {
            console.log(res);
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
    }
    .table-wrap table thead tr th:not(:last-child) {
        border-right: 2px solid #dee2e6;
    }

    .table-wrap table tbody tr {
        border-bottom: 2px solid #dee2e6;
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

</style>