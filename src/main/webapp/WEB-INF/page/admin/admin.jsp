<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin</title>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/common.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
<div class="container mt-5">
    <h4><strong>회원관리</strong></h4>

    <!-- 검색 -->
    <form action="${pageContext.request.contextPath}/admin" method="get" class="member-box mt-4 text-center">
        <label for="searchName" class="form-label me-2">회원명 :</label>
        <input type="text" name="searchName" id="searchName" 
               class="form-control d-inline-block w-50" 
               placeholder="회원명을 입력해주세요.">
        <button type="submit" class="btn btn-secondary">조회</button>
    </form>

    <!-- 회원 테이블 -->
    <table class="table table-bordered table-hover mt-4 rounded-table">
        <thead class="table-light">
            <tr>
                <th style="width:5%;">No</th>
                <th style="width:10%;">회원ID</th>
                <th style="width:12%;">회사명</th>
                <th style="width:18%;">이메일</th>
                <th style="width:12%;">전화번호</th>
                <th style="width:12%;">사업자번호</th>
                <th style="width:21%;">주소</th>
                <th style="width:10%;">회원 유형</th>
            </tr>
        </thead>
        <c:if test="${count eq 0}">
            <tr>
                <td colspan="8">등록된 회원이 없습니다.</td>
            </tr>
        </c:if>
        <c:if test="${count ne 0}">
            <c:forEach var="memberDto" items="${memberDtos}" varStatus="status">
                <tr>
                    <td><fmt:formatNumber value="${status.index + 1}" pattern="000"/></td>
                    <td>${memberDto.id}</td>
                    <td>${memberDto.companyName}</td>
                    <td>${memberDto.email}</td>
                    <td>${memberDto.phoneNumber}</td>
                    <td>${memberDto.businessNumber}</td>
                    <td>${memberDto.address}</td>
                    <td>
                        <c:choose>
                            <c:when test="${memberDto.memberType == 1}">1</c:when>
                            <c:when test="${memberDto.memberType == 2}">2</c:when>
                            <c:otherwise>관리자</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>

    <!-- 페이징 -->
    <div class="d-flex justify-content-center align-items-center gap-3 mt-0">
        <c:if test="${totalPages gt 0}">
            <!-- 이전 블록 -->
            <c:if test="${startPage gt 1}">
                <a href="?page=${startPage - 1}&searchName=${param.searchName}" class="text-dark">
                    <i class="bi bi-chevron-left"></i>
                </a>
            </c:if>
    
            <!-- 페이지 번호 -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <c:if test="${i eq currentPage}">
                    <span class="badge bg-primary" style="font-size: 1rem;">${i}</span>
                </c:if>
                <c:if test="${i ne currentPage}">
                    <a href="?page=${i}&searchName=${param.searchName}" class="text-decoration-none">${i}</a>
                </c:if>
            </c:forEach>
    
            <!-- 다음 블록 -->
            <c:if test="${endPage lt totalPages}">
                <a href="?page=${startPage + pageBlock}&searchName=${param.searchName}" class="text-dark">
                    <i class="bi bi-chevron-right"></i>
                </a>
            </c:if>
        </c:if>
    </div>
    
</div>
</body>

<style>
    /* 검색 박스 */
    .member-box {
        padding: 20px;
        margin-top: 30px;
        text-align: center;
    }

    /* 테이블 */
    table th,
    table td {
        text-align: center;
        vertical-align: middle;
    }

    thead tr {
        border-bottom: 1px solid #dee2e6;
    }

    /* 둥근 테두리를 위한 테이블 래퍼 */
    .rounded-table {
        border-collapse: separate;
        border-spacing: 0;
        border: 1px solid #dee2e6;
        border-radius: 10px;
        overflow: hidden;
    }

    .rounded-table th:first-child {
        border-top-left-radius: 10px;
    }

    .rounded-table th:last-child {
        border-top-right-radius: 10px;
    }

    .rounded-table td:first-child {
        border-bottom-left-radius: 10px;
    }

    .rounded-table td:last-child {
        border-bottom-right-radius: 10px;
    }

    /* 페이징 가운데 정렬 */
    .pagination {
        justify-content: center;
    }
</style>

</html>
