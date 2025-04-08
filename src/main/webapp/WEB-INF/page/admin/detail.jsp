<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원관리 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
<div class="container mt-5">
    <h4><strong>회원관리 상세</strong></h4>

    <!-- 회원정보 -->
    <div class="border rounded p-4 mt-5 bg-white shadow-sm">
        <h6><strong>회원정보</strong></h6>
        <table class="table table-borderless mb-0">
            <tbody>
                <tr>
                    <th class="w-25">회원 ID</th>
                    <td>${userDto.id}</td>
                    <th class="w-25">이메일</th>
                    <td><a href="mailto:${userDto.email}">${userDto.email}</a></td>
                </tr>
                <tr>
                    <th>회원유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${userDto.memberType == 1}">일반 회원</c:when>
                            <c:when test="${userDto.memberType == 2}">관리자</c:when>
                            <c:otherwise>관리자</c:otherwise>
                        </c:choose>
                    </td>
                    <th>전화번호</th>
                    <td colspan="3">${userDto.phoneNumber}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 사업체 정보 -->
    <div class="border rounded p-4 mt-5 bg-white shadow-sm">
        <h6><strong>사업체 정보</strong></h6>
        <table class="table table-borderless mb-0">
            <tbody>
                <tr>
                    <th class="w-25">사업체명</th>
                    <td>${userDto.companyName}</td>
                    <th class="w-25">사업자번호</th>
                    <td>${userDto.businessNumber}</td>
                </tr>
                <tr>
                    <th>사업체주소</th>
                    <td colspan="3">${userDto.address} ${userDto.detailedAddress} | 우편번호: ${userDto.postalCode}</td>
                </tr>
            </tbody>
        </table>
    </div>


    
   <!-- 버튼 -->
    <div class="mt-4 d-flex justify-content-between align-items-center">
        <!-- 왼쪽: 목록 버튼 -->
        <a href="${pageContext.request.contextPath}/admin?pageNum=${pageNum}" class="btn btn-outline-dark">
            목록
        </a>

        <!-- 오른쪽: 초기화 + 탈퇴 버튼 그룹 -->
        <div class="d-flex gap-2 ms-auto">
            <form id="typeChangeForm" action="${pageContext.request.contextPath}/admin/changeMemberType" method="post">
                <input type="hidden" name="id" value="${userDto.id}">
                <input type="hidden" name="pageNum" value="${pageNum}">
                <button type="button" class="btn btn-secondary" id="changeMemBtn">회원유형 변경</button>
            </form>

            <form id="resetPasswordForm" action="${pageContext.request.contextPath}/admin/resetPassword" method="post">
                <input type="hidden" name="id" value="${userDto.id}">
                <input type="hidden" name="pageNum" value="${pageNum}">
                <button type="button" class="btn btn-secondary" id="resetPwBtn">비밀번호 초기화</button>
            </form>

            <form id="deleteUserForm" action="${pageContext.request.contextPath}/admin/deleteUser" method="post">
                <input type="hidden" name="id" value="${userDto.id}">
                <input type="hidden" name="pageNum" value="${pageNum}">
                <button type="button" class="btn btn-danger" id="deleteMemBtn">회원 탈퇴</button>
            </form>
        </div>
    </div>

</div>
</body>
</html>

<script>
    document.getElementById("changeMemBtn").addEventListener("click", (event)=>{
        showResultModal(
                "1", 
                "회원유형 변경",
                "${userDto.companyName}의 회원 유형을 변경하시겠습니까?",
                null,
                () => document.getElementById("typeChangeForm").submit(),
                null,
                "confirm"
        );
    });

    document.getElementById("resetPwBtn").addEventListener("click", (event)=>{
        showResultModal(
                "1",
                "비밀번호 초기화",
                "${userDto.companyName}의 비밀번호 초기화를 하시겠습니까?",
                null,
                () => document.getElementById("resetPasswordForm").submit(),
                null,
                "confirm"
        );
    });

    document.getElementById("deleteMemBtn").addEventListener("click", (event)=>{
        showResultModal(
                "1",
                "회원 탈퇴퇴",
                "${userDto.companyName}의 회원 탈퇴를 진행하시겠습니까?",
                null,
                () => document.getElementById("deleteUserForm").submit(),
                null,
                "confirm"
        );
    });

    window.onload = function() {
        let pageNum = "${pageNum}";
        let id = "${id}";
        let name = "${name}";
        let deleteResult = "${resetResult}";
        let changeResult = "${changeResult}";
        if (deleteResult === "1" || deleteResult === "0") {
            showResultModal(
                deleteResult,
                "처리 결과",
                name + " 회원의 비밀번호가 변경되었습니다",
                "비밀번호 변경에 실패했습니다",
                function() {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                },
                function() {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                }
            );
        }

        if (changeResult === "1" || changeResult === "0") {
            showResultModal(
                changeResult,
                "처리 결과",
                name + " 회원의 회원 유형이 변경되었습니다",
                "회원 유형 변경에 실패했습니다",
                function() {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                },
                function() {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                }
            );
        }
    }
</script>


<%-- JSP에서 세션 값 삭제 (JavaScript 실행 이후) --%>
<% session.removeAttribute("resetResult"); %>
<% session.removeAttribute("changeResult"); %>

<style>
    h5 {
        font-size: 1.4rem;
    }

    h6 {
        font-size: 1.1rem;
        margin-bottom: 1rem;
    }


    .btn-danger {
        color: white;
    }

    .shadow-sm {
        box-shadow: 0 0.2rem 0.5rem rgba(0,0,0,0.05);
    }
</style>
