function postRequestApi(url, obj, fn) {
    axios.post(
        url,
        obj, 
        { headers: {'Content-Type': 'application/json'} }
    )
    .then(fn)
}

function handleSearch() {
    const keyword = document.querySelector(".search-wrap > input").value;
    if (validate.isEmpty(keyword)) {
        location.href = "/main/search";
    } else {
        location.href = "/main/search?keyword=" + keyword;
    }
}

function logout() {
    postRequestApi("logout", null, res => {
        if(res.status !== 200) return alert("네트워크 오류입니다.");
        location.href = "/login";
    })
}

// 공통 유효성 검사 함수
const validate = {
    isEmpty: value => {
        return value === null || value === undefined || value.trim() === '';
    },
    isEmail: value => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(value);
    },
    isPhoneNumber: value => {
        const phoneRegex = /^\d{10,11}$/; // 한국 전화번호 형식 (10~11자리 숫자)
        return phoneRegex.test(value);
    }
};

function showResultModal(resultValue, title, successMessage, failMessage, callbackOnSuccess, callbackOnFail, mode = 'close') {
    const modalEl = document.getElementById("resultModal");
    const modalTitle = document.getElementById("resultModalLabel");
    const modalBody = document.getElementById("modalBody");
    const modalFooter = modalEl.querySelector(".modal-footer");

    if (!modalEl || !modalTitle || !modalBody || !modalFooter) {
        console.error("모달 요소가 존재하지 않습니다.");
        return;
    }

    modalTitle.innerText = title;
    modalBody.innerHTML = resultValue === "1" ? successMessage : failMessage;
    modalFooter.innerHTML = "";

    const myModal = new bootstrap.Modal(modalEl);

    // 상태 변수
    let userClicked = false;

    // 닫기 버튼
    const closeBtn = document.createElement("button");
    closeBtn.type = "button";
    closeBtn.className = "btn btn-secondary";
    closeBtn.setAttribute("data-bs-dismiss", "modal");
    closeBtn.innerText = "닫기";

    // 확인 버튼
    const confirmBtn = document.createElement("button");
    confirmBtn.type = "button";
    confirmBtn.className = "btn btn-primary";
    confirmBtn.innerText = "확인";
    confirmBtn.onclick = () => {
        userClicked = true;
        myModal.hide();
        if (typeof callbackOnSuccess === "function") {
            callbackOnSuccess();
        }
    };

    // 취소 버튼
    const cancelBtn = document.createElement("button");
    cancelBtn.type = "button";
    cancelBtn.className = "btn btn-danger";
    cancelBtn.innerText = "취소";
    cancelBtn.onclick = () => {
        userClicked = true;
        myModal.hide();
        if (typeof callbackOnFail === "function") {
            callbackOnFail();
        }
    };

    // 버튼 구성
    if (mode === "confirm") {
        modalFooter.appendChild(confirmBtn);
        modalFooter.appendChild(cancelBtn);
    } else {
        modalFooter.appendChild(closeBtn);
    }

    // 닫기(X) 또는 바깥 클릭으로 닫을 때 처리
    modalEl.addEventListener("hidden.bs.modal", () => {
        if (!userClicked) {
            if (resultValue === "1" && typeof callbackOnSuccess === "function") {
                callbackOnSuccess();
            } else if (resultValue !== "1" && typeof callbackOnFail === "function") {
                callbackOnFail();
            }
        }
    }, { once: true });

    myModal.show();
}