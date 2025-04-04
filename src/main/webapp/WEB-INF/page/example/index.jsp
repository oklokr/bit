<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
    <div class="input-group-lg search-wrap">
        <input type="text" class="form-control" placeholder="검색어를 입력해주세요." aria-label="검색어를 입력해주세요." aria-describedby="button-addon2">
        <button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
    </div>

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
        postRequestApi("/api/example", postData, handleMethod);
    });
</script>