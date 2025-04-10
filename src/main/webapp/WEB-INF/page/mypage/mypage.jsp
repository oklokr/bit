<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/common.css">
    <style>
        .input-group {
            display: flex;
            align-items: center;
        }
        .input-group .form-control {
            flex: 1;
        }
        .input-group .btn {
            margin-left: 10px;
        }
        .hidden {
            display: none;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            내 정보
        </div>
        <div class="card-body">
            <form id="userInfoForm" method="post" action="${pageContext.request.contextPath}/user/update">
                <div class="row">
                    <!-- 사용자 정보 -->
                    <div class="col-md-6">
                        <h5>사용자 정보</h5>
                        <table class="table">
                            <tr>
                                <th>업체명</th>
                                <td><input type="text" class="form-control" name="companyName" value="${userDto.companyName}" readonly></td>
                            </tr>
                            <tr>
                                <th>아이디</th>
                                <td><input type="text" class="form-control" name="id" value="${userDto.id}" readonly></td>
                            </tr>
                            <tr id="currentPasswordRow">
                                <th>비밀번호</th>
                                <td><input type="password" class="form-control" name="password" value="********" readonly></td>
                            </tr>
                            <tr id="newPasswordRow" class="hidden">
                                <th>신규 비밀번호</th>
                                <td><input type="password" class="form-control" name="newPassword" placeholder="신규 비밀번호를 입력하세요"></td>
                            </tr>
                            <tr id="confirmPasswordRow" class="hidden">
                                <th>비밀번호 확인</th>
                                <td><input type="password" class="form-control" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요"></td>
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
                    <!-- 사업자 정보 -->
                    <div class="col-md-6">
                        <h5>사업자 정보</h5>
                        <table class="table">
                            <tr>
                                <th>사업자 번호</th>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="businessNumber" value="${userDto.businessNumber}" readonly>
                                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="validateBusinessNumber()">번호 확인</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="address" value="${userDto.address}" readonly>
                                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="searchAddress()">주소 검색</button>
                                    </div>
                                </td>
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
                <div class="text-center mt-4">
                    <button type="button" class="btn btn-danger" onclick="openPasswordModal('delete')">회원탈퇴</button>
                    <button type="button" class="btn btn-primary" onclick="openPasswordModal('edit')">수정</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 비밀번호 확인 모달 -->
<div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel">비밀번호 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="passwordForm">
                    <div class="mb-3">
                        <label for="passwordInput" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="passwordInput" required>
                        <div id="passwordError" class="text-danger mt-2" style="display: none;">비밀번호가 일치하지 않습니다.</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="passwordConfirmButton">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
    let actionType = '';

    function openPasswordModal(action) {
        actionType = action;
        document.getElementById('passwordInput').value = '';
        document.getElementById('passwordError').style.display = 'none';
        const passwordModal = new bootstrap.Modal(document.getElementById('passwordModal'));
        passwordModal.show();
    }

    document.getElementById('passwordConfirmButton').addEventListener('click', function () {
        const password = document.getElementById('passwordInput').value;

        // 비밀번호 확인 요청 (AJAX)
        fetch('/api/mypage/verify-password', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ password })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (actionType === 'edit') {
                    enableEditMode();
                } else if (actionType === 'delete') {
                    confirmDelete();
                }
                const passwordModal = bootstrap.Modal.getInstance(document.getElementById('passwordModal'));
                passwordModal.hide();
            } else {
                document.getElementById('passwordError').style.display = 'block';
            }
        })
        .catch(error => console.error('Error:', error));
    });

    function enableEditMode() {
        const inputs = document.querySelectorAll('input');
        inputs.forEach(input => {
            if (input.name !== 'id' && input.name !== 'companyName' && input.name !== 'memberType') {
                input.readOnly = false;
            }
        });

        // 기존 비밀번호 숨기고 신규 비밀번호와 비밀번호 확인 표시
        document.getElementById('currentPasswordRow').classList.add('hidden');
        document.getElementById('newPasswordRow').classList.remove('hidden');
        document.getElementById('confirmPasswordRow').classList.remove('hidden');

        // 수정 모드에서 버튼 변경
        const userInfoForm = document.getElementById('userInfoForm');
        const buttons = `
            <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
            <button type="submit" class="btn btn-success">저장</button>
        `;
        userInfoForm.querySelector('.text-center').innerHTML = buttons;

        // 수정 모드에서 추가 버튼 표시
        document.querySelectorAll('.edit-only').forEach(button => {
            button.style.display = 'inline-block';
        });
    }

    function cancelEdit() {
        location.reload(); // 페이지 새로고침으로 수정 취소
    }

    function confirmDelete() {
        if (confirm("정말로 탈퇴하시겠습니까?")) {
            alert("회원 탈퇴가 완료되었습니다.");
            // 실제 탈퇴 처리 로직 추가 필요
        }
    }

    function validateBusinessNumber() {
        const businessNumber = document.querySelector('input[name="businessNumber"]').value.trim();
        const businessNumberRegex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;

        if (!businessNumberRegex.test(businessNumber)) {
            alert('유효하지 않은 사업자 번호 형식입니다. 올바른 형식을 입력해주세요.');
            return false;
        }

        alert('유효한 사업자 번호 형식입니다.');
        return true;
    }

    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                const address = data.roadAddress ? data.roadAddress : data.jibunAddress;
                document.querySelector('input[name="address"]').value = address;
                document.querySelector('input[name="detailedAddress"]').focus();
            }
        }).open();
    }
</script>
</body>
</html>