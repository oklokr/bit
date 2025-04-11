// const kakaoApiKey = '${kakao.map.js-key}';
// Kakao.init(kakaoApiKey); // 발급받은 JavaScript 키로 초기화

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

function handleAddInventory(productId, stockQuantity) {
    const postData = {
        productId: productId
    }
    if(!validate.isEmpty(stockQuantity)) {
        postData.stockQuantity = stockQuantity;
    }
    postRequestApi("/api/mypage/setInventory", postData, res => {
        console.log(res);
    })
}

// 공통 유효성 검사 함수
const validate = {
    isEmpty: value => {
        return !value || value === null || value === undefined || value === '';
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

function modal(option) {
    const {title, content, type = "message", backdrop, keyboard, fnClose, fnConfirm} = option;
    const modal = new bootstrap.Modal(document.getElementById("resultModal"), {
        backdrop: backdrop ? true : false || true,
        keyboard: keyboard || true,
    });

    const modalEl = document.querySelector(".common-modal");
    const titleEl = document.getElementById("resultModalLabel");
    const contentEl = document.getElementById("modalBody");
    const footerEl = document.querySelector(".modal-footer");
    let titleInner = ""
    let contentInner = null;;
    let footerInner = ""

    
    modalEl.classList.remove("modal-message", "modal-alert", "modal-confirm");

    if(type === "message") {
        modalEl.classList.add("modal-message")
        contentInner = "<p style='margin-bottom: 0; text-align:center;'>"+content+"</p>"
        footerInner = "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' data-fn-type='close'>확인</button>"
    }
    if(type === "alert") {
        modalEl.classList.add("modal-alert")
        titleInner = title || "알림";
        footerInner = "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' data-fn-type='close'>확인</button>"
    }
    if(type === "confirm") {
        modalEl.classList.add("modal-confirm")
        titleInner = title || "알림";
        footerInner = 
        "<button type='button' class='btn btn-outline-primary' data-bs-dismiss='modal' data-fn-type='close'>취소</button>"
        + "<button type='button' class='btn btn-primary' data-bs-dismiss='modal' data-fn-type='confirm'>확인</button>"
    }
    
    titleEl.innerText = titleInner;
    contentEl.innerHTML = contentInner || content;
    footerEl.innerHTML = footerInner;

    document.querySelector(".btn[data-fn-type='close']")?.addEventListener("click", fnClose)
    modalEl.addEventListener("hidden.bs.modal", () => fnClose, { once: true });
    document.querySelector(".btn[data-fn-type='confirm']")?.addEventListener("click", fnConfirm)
    modal.show();
}

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