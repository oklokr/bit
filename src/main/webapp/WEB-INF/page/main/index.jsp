<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    내용
    <button type="button" class="btn">버튼</button>
    <jsp:include page="../../component/popValidate.jsp" />
</div>

<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    document.querySelector('.btn').addEventListener('click', function() {
        axios.post(
            "/api/user", {id: 'user1'}, {
            headers: {'Content-Type': 'application/json'}
        })
        .then(function(response) {
            // 성공적으로 응답을 받았을 때 처리할 코드
            console.log('응답 데이터:', response.data);
        })
    });
</script>