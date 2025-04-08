<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>

<body>
<div class="container mt-5 mb-5">
    <h4>내 정보</h4>

    <!-- 전체 사용자 정보 수정용 폼 -->
    <form id="userInfoForm" method="post" action="${pageContext.request.contextPath}/user/update">
        <div class="row g-5">
            <!-- 사용자 정보 -->
            <div class="col-md-6">
                <div class="info-box">
                    <h6 class="mb-4"><strong>사용자 정보</strong></h6>
                    <table class="table info-table">
                        <tr>
                            <th>업체명</th>
                            <td><input type="text" class="form-control" name="companyName" value="${userDto.companyName}" readonly></td>
                        </tr>
                        <tr>
                            <th>아이디</th>
                            <td><input type="text" class="form-control" name="id" value="${userDto.id}" readonly></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="password" class="form-control" name="password" value="************" readonly></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><input type="email" class="form-control" name="email" value="${userDto.email}" readonly></td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td><input type="text" class="form-control" name="phoneNumber" value="${userDto.phoneNumber}" readonly></td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- 사업자 정보 -->
            <div class="col-md-6">
                <div class="info-box">
                    <h6 class="mb-4"><strong>사업자 정보</strong></h6>
                    <table class="table info-table">
                        <tr>
                            <th>사업자 번호</th>
                            <td><input type="text" class="form-control" name="businessNumber" value="${userDto.businessNumber}" readonly></td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td><input type="text" class="form-control" name="address" value="${userDto.address}" readonly></td>
                        </tr>
                        <tr>
                            <th>상세주소</th>
                            <td><input type="text" class="form-control" name="detailedAddress" value="${userDto.detailedAddress}" readonly></td>
                        </tr>
                        <tr>
                            <th>우편번호</th>
                            <td><input type="text" class="form-control" name="postalCode" value="${userDto.postalCode}" readonly></td>
                        </tr>
                        <tr>
                            <th>가입유형</th>
                            <td><input type="text" class="form-control" name="memberType" value="${userDto.memberType}" readonly></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>

    <!-- 버튼 영역 -->
    <div class="btn-group-custom">
        <form action="${pageContext.request.contextPath}/user/delete" method="post">
            <input type="hidden" name="id" value="${userDto.id}">
            <button type="submit" class="btn btn-outline-dark">회원탈퇴</button>
        </form>

        <button type="button" class="btn btn-dark" onclick="enableEdit()">수정</button>
    </div>
</div>
</body>

<script>
    function enableEdit() {
        const form = document.getElementById("userInfoForm");
        const inputs = form.querySelectorAll("input");

        inputs.forEach(input => {
            if (input.name !== "id") { // 아이디는 수정 불가
                input.removeAttribute("readonly");
            }
        });

        // 수정 버튼 → 저장 버튼으로 변경할 수도 있음
        alert("이제 정보를 수정할 수 있습니다.");
    }
</script>

<style>
    .info-box {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 20px;
        background-color: #fff;
    }

    .info-table th {
        width: 30%;
        font-weight: bold;
        background-color: #f8f9fa;
    }

    .info-table td {
        background-color: #fff;
    }

    .btn-group-custom {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 30px;
    }

    h4 {
        text-align: center;
        font-weight: bold;
        margin-bottom: 40px;
    }
</style>
