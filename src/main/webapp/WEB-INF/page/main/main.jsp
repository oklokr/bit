<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    내용
    <button type="button" class="btn">버튼</button>
    <button type="button" class="btn btn-primary">버튼</button>
    <jsp:include page="../../component/popValidate.jsp" />
    <jsp:include page="../../component/textEditor.jsp" />
</div>

<script>
    const handleMethod = res => {
        console.log(res)
    }
    document.querySelector('.btn').addEventListener('click', function() {
        const postData = {
            id: 'user1'
        }
        postRequestApi("/api/user", postData, handleMethod);
    });
</script>