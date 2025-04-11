<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container page-wrap">
    <h2 class="page-title">회원관리</h2>

    <!-- 검색 -->
    <form action="${pageContext.request.contextPath}/admin" method="get" class="filter-wrap">
        <div class="row">
            <label for="searchName" class="col-sm-2 col-form-label">회원명</label>
            <c:if test="${searchName != null}">
                <c:set var="placeholder" value="${searchName}"/>
            </c:if>
            <c:if test="${searchName == null}">
                <c:set var="placeholder" value="회원명을 입력해주세요"/>
            </c:if>
    
            <div class="col-sm-8">
                <input type="text" class="form-control" name="searchName" id="searchName" placeholder="${placeholder}">
            </div>
        </div>
        
        <button type="submit" class="btn btn-primary btn-sm">조회</button>
    </form>

    <!-- 회원 테이블 -->
    <table class="table table-bordered table-hover mt-4">
        <thead class="table-light">
            <tr>
                <th style="width:5%;">No</th>
                <th style="width:10%;">회원ID</th>
                <th style="width:15%;">회사명</th>
                <th style="width:18%;">이메일</th>
                <th style="width:12%;">전화번호</th>
                <th style="width:12%;">사업자번호</th>
                <th style="width:20%;">주소</th>
                <th style="width:8%;">회원 유형</th>
            </tr>
        </thead>
        <c:if test="${count eq 0}">
            <tr>
                <td colspan="8">등록된 회원이 없습니다.</td>
            </tr>
        </c:if>
        <c:if test="${count ne 0}">
            <c:forEach var="memberDto" items="${memberDtos}" varStatus="status">
                <tr onclick="location.href='/admin/detail?id=${memberDto.id}&pageNum=${pageNum}'" style="cursor:pointer;">
                    <td>
                        ${number+1}
                        <c:set var="number" value="${number+1}"/>
                    </td>
                    <td>${memberDto.id}</td>
                    <td>${memberDto.companyName}</td>
                    <td>${memberDto.email}</td>
                    <td>${memberDto.phoneNumber}</td>
                    <td>${memberDto.businessNumber}</td>
                    <td>${memberDto.address}</td>
                    <td>
                        <c:choose>
                            <c:when test="${memberDto.memberType == 1}">일반 회원</c:when>
                            <c:when test="${memberDto.memberType == 2}">관리자</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>

    <!-- 페이징 -->
    <div class="d-flex justify-content-center align-items-center gap-3 mt-1">
        <c:if test="${count gt 0}">
            <c:if test="${startPage gt pageBlock}">
                <a href="admin">
                    <i class="bi bi-chevron-left"></i>
                </a>
            </c:if>
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <c:if test="${i eq currentPage}">
                    <span class="badge bg-primary" style="font-size: 1rem;">${i}</span>
                </c:if>
                <c:if test="${i ne currentPage}">
                    <a href="admin?pageNum=${i}" class="text-decoration-none">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${pageCount gt endPage}">		
                <a href="admin?pageNum=${startPage + pageBlock}">
                    <i class="bi bi-chevron-right"></i>
                </a>
            </c:if>
        </c:if>
    </div>
    
</div>

<script>
    window.onload = function() {
        const deleteResult = "${deleteResult}";
        if (deleteResult == "1") {
            modal({
                content: "${deletedName} 회원이 탈퇴되었습니다",
                fnConfirm: () => {
                    location.href = "/admin?pageNum=${pageNum}";
                }
            });
        }
        if (deleteResult == "0") {
            modal({
                content: "회원 탈퇴에 실패했습니다",
                fnConfirm: () => {
                    location.href = "/admin/detail?pageNum=${pageNum}&id=${failedId}";
                }
            });
        }
    }
</script>

<%-- JSP에서 세션 값 삭제 (JavaScript 실행 이후) --%>
<% session.removeAttribute("deleteResult"); %>

<style>
    /* 헤더 */
    h4 strong {
        font-size: 1.6rem;
    }

    /* 검색 박스 */
    .member-box {
        background-color: #ffffff;
        border: 1px solid #dee2e6;
        border-radius: 0.5rem;
        padding: 20px 30px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }

    .member-box input[type="text"] {
        max-width: 300px;
    }

    .member-box .btn {
        margin-left: 10px;
    }

    /* 테이블 */
    table th {
        background-color: #f1f3f5;
        color: #495057;
        font-weight: 600;
    }

    table td {
        background-color: #ffffff;
        color: #212529;
    }

    table th,
    table td {
        text-align: center;
        vertical-align: middle;
    }

    thead tr {
        border-bottom: 2px solid #dee2e6;
    }

</style>