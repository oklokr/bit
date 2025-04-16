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
                <dd><input type="text" class="form-control" name="phoneNumber" value="${userDto.phoneNumber}" maxlength="13" readonly></dd>
            </dl>
        </div>

        <div class="data-form">
            <h3 class="title">사업자 정보</h3>
            <dl>
                <dt>사업자 번호</dt>
                <dd>
                    <div class="input-group row-group">
                        <input type="text" class="form-control" name="businessNumber" value="${userDto.businessNumber}" maxlength="12" readonly>
                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="validateBusinessNumber()">번호 확인</button>
                    </div>
                </dd>
    
                <dt>주소</dt>
                <dd>
                    <div class="input-group row-group">
                        <input type="text" class="form-control" name="address" value="${userDto.address}" readonly>
                        <button type="button" class="btn btn-outline-primary btn-sm edit-only" style="display: none;" onclick="searchAddress()">주소 검색</button>
                    </div>
                </dd>
    
                <dt>상세주소</dt>
                <dd><input type="text" class="form-control" name="detailedAddress" value="${userDto.detailedAddress}" readonly></dd>
    
                <dt>우편번호</dt>
                <dd><input type="text" class="form-control" name="postalCode" value="${userDto.postalCode}" maxlength="5" readonly></dd>
    
                <dt>가입유형</dt>
                <dd>
                    <input type="text" class="form-control" name="memberType" value="${userDto.memberType == 1 ? '병원' : '관리자'}" readonly style="text-align: left;">
                </dd>
            </dl>
        </div>

        <div class="bottom-btns">
            <button type="button" class="btn btn-danger" onclick="openPasswordModal('delete')">회원탈퇴</button>
            <button type="button" class="btn btn-primary" onclick="openPasswordModal('edit')">수정</button>
        </div>
    </form>
    
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
            modal({content: '사업자 번호 확인을 먼저 진행해주세요.'});
            return; // 폼 제출 중단
        }

        if (!newPassword) {
            modal({content: '신규 비밀번호를 입력해주세요.'});
            return; // 폼 제출 중단
        }

        if (!confirmPassword) {
            modal({content: '비밀번호 확인을 입력해주세요.'});
            return; // 폼 제출 중단
        }

        if (newPassword !== confirmPassword) {
            modal({content: '비밀번호가 일치하지 않습니다.'});
            return; // 폼 제출 중단
        }

        if (!email) {
            modal({content: '이메일을 입력해주세요.'});
            return; // 폼 제출 중단
        }

        if (!phoneNumber) {
            modal({content: '휴대전화를 입력해주세요.'});
            return; // 폼 제출 중단
        }

        if (!phoneRegex.test(phoneNumber)) {
            modal({content: '휴대전화가 올바르지 않습니다. (예: 010-1234-5678)'});
            return; // 폼 제출 중단
        }

        if (!postalCode) {
            modal({content: '우편번호를 입력해주세요.'});
            return; // 폼 제출 중단
        }

        // 서버로 데이터 전송
        try {
            const updateResponse = await fetch('/mypage/update', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });

            const updateResult = await updateResponse.json();
            if (updateResult.success) {
                modal({content: updateResult.message});
                location.reload(); // 성공 시 페이지 새로고침
            } else {
                modal({content: updateResult.message});
            }
        } catch (error) {
            console.error('에러 발생:', error);
            modal({content: '서버와 통신 중 문제가 발생했습니다.'});
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

        // 주소와 우편번호는 직접 입력 불가
        document.querySelector('input[name="address"]').readOnly = true;
        document.querySelector('input[name="postalCode"]').readOnly = true;

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
        modal({
            title: "회원 탈퇴",
            content: "정말로 탈퇴하시겠습니까?",
            type: "confirm", // 확인 및 취소 버튼이 있는 모달
            fnConfirm: () => {
                // 탈퇴 요청
                fetch('/api/mypage/delete', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        modal({
                            title: "탈퇴 완료",
                            content: data.message,
                            type: "message",
                            fnClose: () => {
                                window.location.href = '/login'; // 로그인 페이지로 이동
                            },
                            returnModal: true,
                        });
                    } else {
                        modal({
                            title: "탈퇴 실패",
                            content: data.message,
                            type: "alert",
                            returnModal: true,
                        });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    modal({
                        title: "오류",
                        content: "회원 탈퇴 중 문제가 발생했습니다.",
                        type: "alert",
                        returnModal: true,
                    });
                });
            },
            fnClose: () => {
                console.log("탈퇴 취소");
            }
        });
    }

    function validateBusinessNumber() {
        const businessNumberInput = document.querySelector('input[name="businessNumber"]');
        const businessNumber = businessNumberInput.value.trim();
        const businessNumberRegex = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;

        if (!businessNumberRegex.test(businessNumber)) {
            modal({content: '유효하지 않은 사업자 번호 형식입니다. 올바른 형식을 입력해주세요.'});
            isBusinessNumberValidated = false; // 확인 실패
            return false;
        }

        modal({content: '유효한 사업자 번호 형식입니다.'});
        isBusinessNumberValidated = true; // 확인 성공

        // 사업자 번호 수정 불가능하게 설정
        businessNumberInput.readOnly = true;

        return true;
    }

    document.addEventListener("DOMContentLoaded", () => {
        document.querySelector('input[name="phoneNumber"]').addEventListener("input", (event) => {
            const formattedValue = formatPhoneNumber(event.target.value); // common.js의 함수 호출
            event.target.value = formattedValue;
        });

        document.querySelector('input[name="businessNumber"]').addEventListener("input", (event) => {
            const formattedValue = formatBusinessNumber(event.target.value); // common.js의 함수 호출
            event.target.value = formattedValue;
        });
    });

    function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            const { userSelectedType, roadAddress, jibunAddress, zonecode } = data;
            const address = userSelectedType === 'R' ? roadAddress : jibunAddress;

            // 입력 필드에 값 설정
            document.querySelector('input[name="address"]').value = address;
            document.querySelector('input[name="postalCode"]').value = zonecode;

            // 상세주소 입력창에 포커스 이동
            document.querySelector('input[name="detailedAddress"]').focus();
        }
    }).open();
}

</script>

<style>
    #userInfoForm {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }
    #userInfoForm .data-form {
        flex: 1;
    }

    #userInfoForm .bottom-btns {
        width: 100%;
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
    .data-form .row-group {
        display: flex;
        gap: 12px;
    }
    .data-form .row-group .btn {
        height: 37px;
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