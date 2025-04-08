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

function showResultModal(resultValue, title, successMessage, failMessage, callbackOnSuccess, callbackOnFail) {
    const modalEl = document.getElementById("resultModal");
    const modalTitle = document.getElementById("resultModalLabel");
    const modalBody = document.getElementById("modalBody");

    if (!modalEl || !modalTitle || !modalBody) {
        //app.jsp가 연결이 되었다면 잘 실행됨 
        console.error("모달 요소가 존재하지 않습니다.");
        return;
    }

    modalTitle.innerText = title;
    modalBody.innerText = resultValue === "1" ? successMessage : failMessage;

    const myModal = new bootstrap.Modal(modalEl);
    myModal.show();

    modalEl.addEventListener("hidden.bs.modal", () => {
        if (resultValue === "1" && typeof callbackOnSuccess === "function") {
            callbackOnSuccess();
        } else if (resultValue !== "1" && typeof callbackOnFail === "function") {
            callbackOnFail();
        }
    }, { once: true });
}