<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container page-wrap">
    <h2 class="page-title">내 정보</h2>
    <form id="userInfoForm" method="post" action="${pageContext.request.contextPath}/mypage/update">
        <div class="data-form">
            <h3 class="title">사용자 정보</h3>
            <dl>
                <dt>업체명</dt>
                <dd><input type="text" class="form-control disabled" name="companyName" value="${userDto.companyName}" readonly></dd>
    
                <dt>아이디</dt>
                <dd><input type="text" class="form-control" name="id" value="${userDto.id}" readonly></dd>
    
                <dt data-area-type="currentPasswordRow">비밀번호</dt>
                <dd data-area-type="currentPasswordRow"><input type="password" class="form-control" name="password" value="********" readonly></dd>
    
                <dt class="hidden" data-area-type="newPasswordRow">신규 비밀번호</dt>
                <dd class="hidden" data-area-type="newPasswordRow"><input type="password" class="form-control" name="newPassword" placeholder="신규 비밀번호를 입력하세요"></dd>

                <dt class="hidden" data-area-type="confirmPasswordRow">비밀번호 확인</dt>
                <dd class="hidden" data-area-type="confirmPasswordRow"><input type="password" class="form-control" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요"></dd>
    
                <dt>이메일</dt>
                <dd><input type="email" class="form-control" name="email" value="${userDto.email}" readonly></dd>
    
                <dt>휴대전화</dt>
                <dd><input type="text" class="form-control" name="phoneNumber" value="${userDto.phoneNumber}" readonly></dd>
            </dl>
        </div>

        <div class="data-form">
            <h3 class="title">사업자 정보</h3>
            <dl>
                <dt>사업자 번호</dt>
                <dd>
                    <div class="input-group">
                        <input type="text" class="form-control" name="businessNumber" value="${userDto.businessNumber}" readonly>
                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="validateBusinessNumber()">번호 확인</button>
                    </div>
                </dd>
    
                <dt>주소</dt>
                <dd>
                    <div class="input-group">
                        <input type="text" class="form-control" name="address" value="${userDto.address}" readonly>
                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="searchAddress()">주소 검색</button>
                    </div>
                </dd>
    
                <dt>상세주소</dt>
                <dd><input type="text" class="form-control" name="detailedAddress" value="${userDto.detailedAddress}" readonly></dd>
    
                <dt>우편번호</dt>
                <dd><input type="text" class="form-control" name="postalCode" value="${userDto.postalCode}" readonly></dd>
    
                <dt>가입유형</dt>
                <dd>
                    <input type="text" class="form-control" name="memberType" value="${userDto.memberType == 1 ? '병원' : '관리자'}" readonly style="text-align: left;">
                </dd>
            </dl>
        </div>
        
    </form>
    
    <div class="bottom-btns">
        <button type="button" class="btn btn-danger" onclick="openPasswordModal('delete')">회원탈퇴</button>
        <button type="button" class="btn btn-primary" onclick="openPasswordModal('edit')">수정</button>
    </div>
</div>

<!-- 비밀번호 확인 모달 -->
<div class="common-modal modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
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
                <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="passwordConfirmButton">확인</button>
            </div>
        </div>
    </div>
</div>


<script>
    let actionType = '';
    let isBusinessNumberValidated = false; // 사업자 번호 확인 여부를 저장하는 변수

    document.getElementById('userInfoForm').addEventListener('submit', async function (event) {
        event.preventDefault(); // 폼 제출 방지

        // 필드 값 가져오기
        const formData = new FormData(this);
        const data = Object.fromEntries(formData.entries());

        const newPassword = document.querySelector('input[name="newPassword"]').value.trim();
        const confirmPassword = document.querySelector('input[name="confirmPassword"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const phoneNumber = document.querySelector('input[name="phoneNumber"]').value.trim();
        const postalCode = document.querySelector('input[name="postalCode"]').value.trim();

        // "병원" 또는 "관리자"를 숫자로 변환
        data.memberType = data.memberType === '병원' ? 1 : data.memberType === '관리자' ? 2 : 0;

        // 신규 비밀번호 처리
        if (newPassword) {
            data.password = newPassword; // 신규 비밀번호를 password 필드에 설정
        }

        // 휴대전화 정규식
        const phoneRegex = /^010-\d{4}-\d{4}$/;

        // 유효성 검사
        if (!isBusinessNumberValidated) {
            alert('사업자 번호 확인을 먼저 진행해주세요.');
            return; // 폼 제출 중단
        }

        if (!newPassword) {
            alert('신규 비밀번호를 입력해주세요.');
            return; // 폼 제출 중단
        }

        if (!confirmPassword) {
            alert('비밀번호 확인을 입력해주세요.');
            return; // 폼 제출 중단
        }

        if (newPassword !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다.');
            return; // 폼 제출 중단
        }

        if (!email) {
            alert('이메일을 입력해주세요.');
            return; // 폼 제출 중단
        }

        if (!phoneNumber) {
            alert('휴대전화를 입력해주세요.');
            return; // 폼 제출 중단
        }

        if (!phoneRegex.test(phoneNumber)) {
            alert('휴대전화가 올바르지 않습니다. (예: 010-1234-5678)');
            return; // 폼 제출 중단
        }

        if (!postalCode) {
            alert('우편번호를 입력해주세요.');
            return; // 폼 제출 중단
        }

        // 이메일과 휴대전화 중복 확인
        try {
            const validateResponse = await fetch('/api/validate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, phoneNumber, postalCode })
            });

            const validateResult = await validateResponse.json();
            if (!validateResult.success) {
                if (validateResult.duplicateEmail) {
                    alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력해주세요.');
                    return; // 폼 제출 중단
                }
                if (validateResult.duplicatePhoneNumber) {
                    alert('이미 사용 중인 전화번호입니다. 다른 전화번호를 입력해주세요.');
                    return; // 폼 제출 중단
                }
                return; // 유효성 검사 실패 시 폼 제출 중단
            }

            // 서버로 데이터 전송
            const updateResponse = await fetch('/mypage/update', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });

            const updateResult = await updateResponse.json();
            if (updateResult.success) {
                alert(updateResult.message);
                location.reload(); // 성공 시 페이지 새로고침
            } else {
                alert(updateResult.message);
            }
        } catch (error) {
            console.error('에러 발생:', error);
            alert('서버와 통신 중 문제가 발생했습니다.');
        }
    });

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

        document.querySelector('dt[data-area-type="currentPasswordRow"]').classList.add('hidden');
        document.querySelector('dd[data-area-type="currentPasswordRow"]').classList.add('hidden');
        document.querySelector('dt[data-area-type="newPasswordRow"]').classList.remove('hidden');
        document.querySelector('dd[data-area-type="newPasswordRow"]').classList.remove('hidden');
        document.querySelector('dt[data-area-type="confirmPasswordRow"]').classList.remove('hidden');
        document.querySelector('dd[data-area-type="confirmPasswordRow"]').classList.remove('hidden');

        // 수정 모드에서 버튼 변경
        const userInfoForm = document.getElementById('userInfoForm');
        const buttons = `
            <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
            <button type="submit" class="btn btn-success">저장</button>
        `;
        document.querySelector('.bottom-btns').innerHTML = buttons;

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
            fetch('/api/mypage/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    window.location.href = '/login'; // 로그인 페이지로 이동
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('회원 탈퇴 중 문제가 발생했습니다.');
            });
        }
    }

    function validateBusinessNumber() {
        const businessNumber = document.querySelector('input[name="businessNumber"]').value.trim();
        const businessNumberRegex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;

        if (!businessNumberRegex.test(businessNumber)) {
            alert('유효하지 않은 사업자 번호 형식입니다. 올바른 형식을 입력해주세요.');
            isBusinessNumberValidated = false; // 확인 실패
            return false;
        }

        alert('유효한 사업자 번호 형식입니다.');
        isBusinessNumberValidated = true; // 확인 성공
        return true;
    };

    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소 또는 지번 주소를 가져옵니다.
                const address = data.roadAddress ? data.roadAddress : data.jibunAddress;

                // 주소 입력창에 값 설정
                document.querySelector('input[name="address"]').value = address;

                // 상세주소 입력창에 포커스 이동
                document.querySelector('input[name="detailedAddress"]').focus();
            }
        }).open();
    }

</script>

<style>
    #userInfoForm {
        display: flex;
        gap: 20px;
    }
    #userInfoForm .data-form {
        flex: 1;
    }
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
    .data-form dl dt.hidden,
    .data-form dl dd.hidden {
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