function postRequestApi(url, obj, fn) {
    axios.post(
        url,
        obj, 
        { headers: {'Content-Type': 'application/json'} }
    )
    .then(fn)
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