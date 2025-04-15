<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="container page-wrap">
    <h3 class="page-title"> 자유게시판 </h3>

    <dl class="board-content">
        <dt>제목</dt>
        <dd>${boardDto.title}</dd>
        <dt>작성자</dt>
        <dd>${boardDto.author}</dd>
        <dt class="full">작성날짜</dt>
        <dd><fmt:formatDate value="${boardDto.creationDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
        <dd>
            <c:out value="${boardDto.content}" escapeXml="false"/>
        </dd>
    </dl>

    <div class="board-reply">
        <strong class="title">
            답글 (<fmt:formatNumber value="${replyCount}" pattern="###,###"/>개)
        </strong>
        <c:if test="${replyCount eq 0}">
            <p class="none-txt">답글이 존재하지 않습니다</p>
        </c:if>
        <div class="reply-list">
            <c:forEach var="replyDto" items="${replyDtos}">
                <div class="reply <c:if test='${replyDto.replyLevel == 1}'>reply-indent</c:if>">
                    <dl>
                        <dt>작성자</dt>
                        <dd>${replyDto.author} <c:if test="${replyDto.author == boardDto.author}">(글쓴이)</c:if></dd>
                        <dt>작성날짜</dt>
                        <dd><fmt:formatDate value="${replyDto.creationDate}" pattern="yyyy.MM.dd HH:mm"/></dd>
                        <dt class="reply-list--title">${replyDto.replyTitle}</dt>
                        <dd class="reply-list--content">${replyDto.replyContent}</dd>
                        <c:if test="${replyDto.replyState == 0}">
                            <c:if test="${replyDto.replyLevel == 0}">
                                <dd class="reply-btn"><button class="btn btn-sm btn-outline-secondary" onclick="handleDisplayForm('${replyDto.replyRef}')">답글</button></dd>
                            </c:if>
                            <c:if test="${replyDto.author == user}">
                                <dd class="reply-btn"><button class="btn btn-sm btn-outline-secondary" onclick="locationLink('reply_delete', '${replyDto.replyId}')">삭제</button></dd>
                            </c:if>
                        </c:if>
                    </dl>
                    <form style="display:none" class='reply-form-${replyDto.replyRef}' action="${pageContext.request.contextPath}/board/reply/write" method="post" name="replyform">
                        <input type="hidden" name="boardId" value="${boardId}">
                        <input type="hidden" name="replyLevel" value="1">
                        <input type="hidden" name="pageNum" value="${pageNum}">
                        <input type="hidden" name="replyRef" value="${replyDto.replyRef}" />
                
                        <p class="small text-muted mb-3">
                            <span>작성자: ${user}</span>
                            <span>작성일자: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy.MM.dd HH:mm"/></span>
                        </p>
                
                        <div class="mb-3">
                            <p class="form-label">제목</p>
                            <input type="text" name="replyTitle" class="form-control" placeholder="제목을 입력해주세요">
                        </div>
                
                        <div class="mb-3">
                            <p class="form-label">내용</p>
                            <textarea name="replyContent" class="form-control" placeholder="내용을 입력해주세요" rows="5" maxlength="250"></textarea>
                        </div>

                        <div class="text-end">
                            <button type="button" name="submit" class="btn btn-sm btn-secondary" data-submit-id="${replyDto.replyRef}">답글 작성</button>
                            <button type="button" name="cancel" class="btn btn-sm btn-secondary" onclick="handleDisplayForm('${replyDto.replyRef}')">취소</button>
                        </div>

                    </form>
                </div>
            </c:forEach>
        </div>

        <!-- 답글 작성 폼 -->
        <form class='reply-form-user' action="${pageContext.request.contextPath}/board/reply/write" class="reply-form" method="post" class="mt-4" name="replyform">
            <input type="hidden" name="boardId" value="${boardId}">
            <input type="hidden" name="replyLevel" value="0">
            <input type="hidden" name="pageNum" value="${pageNum}">

            <strong style="display: block; margin-bottom: 10px;">답글 작성</strong>
            
            <p class="small text-muted mb-3">
                <span>작성자: ${user}</span>
                <span>작성일자: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy.MM.dd HH:mm"/></span>
            </p>

            <div class="mb-3">
                <p class="form-label">제목</p>
                <input type="text" name="replyTitle" class="form-control" placeholder="제목을 입력해주세요">
            </div>
    
            <div class="mb-3">
                <p class="form-label">내용</p>
                <textarea name="replyContent" class="form-control" placeholder="내용을 입력해주세요" rows="5" maxlength="250"></textarea>
            </div>

            <button type="button" name="submit" class="btn btn-primary" data-submit-id="user">답글 작성</button>
        </form>
    </div>

    <!-- 버튼 그룹 -->
     <div class="bottom-btns">
        <div class="left">
            <button class="btn btn-outline-primary" onclick="location='/board?pageNum=${pageNum}'">목록</button>
        </div>

        <c:if test="${boardDto.author == user}">
            <button class="btn btn-outline-primary" id="deleteBtn" onclick="locationLink('delete', '${boardId}')">삭제</button>
            <button class="btn btn-primary" id="modifyBtn" onclick="locationLink('edit', '/board/edit?boardId=${boardId}&result=${-1}&pageNum=${pageNum}')">수정</button>
        </c:if>
    </div>
</div>

<script>
    function locationLink(type, data) {
        if(type === 'edit') {
            location.href = data;
        }
        if(type === 'delete') {
            modal({
                content: "게시글을 삭제하시겠습니까?",
                type: "confirm",
                fnConfirm: () =>  postRequestApi("/api/board/delete", data, res => {
                    modal({
                        content: "게시글이 삭제되었습니다",
                        type: "alert",
                        fnClose: () =>  {
                            location.href = "/board";
                        }
                    })
                })
            })
        }
        if(type === 'reply_delete') {
            modal({
                content: "답글을 삭제하시겠습니까?",
                type: "confirm",
                fnConfirm: () =>  postRequestApi("/api/board/reply/delete", data, res => {
                    modal({
                        content: "답글이 삭제되었습니다.",
                        type: "alert",
                        fnClose: () =>  {
                            location.reload();
                        }
                    })
                })
            })
        }
    }

    function handleDisplayForm(replyId) {
        const form = document.querySelector(".reply-form-"+replyId+"");
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }

    function handleSubmit() {
        document.querySelectorAll('button[name="submit"]').forEach(el => {
            el.addEventListener("click", e => {
                const idData = el.getAttribute("data-submit-id")
                if(validate.isEmpty(idData)) return
                const replyForm = document.querySelector(".reply-form-"+idData+"");
                const elTitle = validate.isEmpty(replyForm.querySelector("input[name='replyTitle']").value)
                const elContent = validate.isEmpty(replyForm.querySelector("textarea[name='replyContent']").value)
                const tag = /<[^>]*>/;

                if(elTitle) {
                    return modal({
                        title: "입력 오류",
                        content: "제목을 입력하세요.",
                        type: "message",
                        fnClose: function() {
                            replyForm.querySelector("input[name='replyTitle']").focus();
                        }
                    });
                }

                if(elContent) {
                    return modal({
                        title: "입력 오류",
                        content: "답글 내용을 입력하세요.",
                        type: "message",
                        fnClose: function() {
                            replyForm.querySelector("textarea[name='replyContent']").focus();
                        }
                    });
                    
                }
                if(tag.test(elTitle) || tag.test(elContent)) {
                    return modal({
                        title: "입력 오류",
                        content: "제목과 내용에 태그를 포함할 수 없습니다.",
                        type: "message",
                        fnClose: null
                    });
                }
                HTMLFormElement.prototype.submit.call(replyForm);
            })
        });
    }

    function handleLoad() {
        handleSubmit();
    }
    
    document.addEventListener('DOMContentLoaded', handleLoad);
</script>

<style>
    .board-content {
        display: flex;
        flex-wrap: wrap;
        margin-top: 40px; 
        border-bottom: 2px solid #ccc;
    }
    .board-content dt {
        font-weight: bold;
        min-width: 150px;
    }
    .board-content dt.full + dd {
        min-width: calc(100% - 150px);
    }
    .board-content dt + dd {
        min-width: calc(50% - 150px);
    }
    .board-content dd + dd {
        width: 100%;
    }
    .board-content dt,
    .board-content dd {
        padding: 12px 20px;
        border-top: 1px solid #ccc;
    }
    .board-content dt {
        text-align: center;
        background-color: #eee;
    }
    .board-content dd {
        margin: initial;
    }

    .board-content dd:last-of-type {
        min-height: 500px;
    }

    /* 답글 리스트 영역 */
    .board-reply .title {
        font-size: 16px;
    }
    .board-reply .none-txt {
        padding: 16px 0;
    }

    .board-reply .reply-list dl {
        display: flex;
        flex-wrap: wrap;
        padding: 20px 0;
        margin-bottom: 0;
        border-bottom: 1px solid #ccc;
    }
    .board-reply .reply-list dl dd {
        margin-bottom: 0;
    }

    .board-reply .reply-list dl dt:not(.reply-list--title),
    .board-reply .reply-list dl dd:not(.reply-list--content) {
        display: flex;
        align-items: center;
        font-size: 14px;
        color: #ccc;
    }
    .board-reply .reply-list dl dt:not(.reply-list--title) {
        margin-right: 12px;
    }
    .board-reply .reply-list dl dd:not(.reply-list--content) + dt:not(.reply-list--title)::before {
        content: " | ";
        margin: 0 5px;
    }
    .board-reply .reply-list dl .reply-btn {
        margin-left: 12px;
    }
    .board-reply .reply-list dl .reply-btn + .reply-btn {
        margin-left: 8px;
    }

    .board-reply .reply-list form {
        padding-left: 30px;
        margin: 20px 0;
    }

    .reply-form-user {
        padding: 30px 0;
    }
    .reply-form-user .btn {
        display: block;
        margin: 12px 0 0 auto;
    }

    .reply-list--title,
    .reply-list--content {
        width: 100%;
        order: 1;
        margin-top: 10px;
    }
    


    /* 답글작성 영역 */
    .reply-form {
        padding-top: 24px;
        margin-top: 24px;
        border-top: 1px solid #ccc;
    }


    .nested-reply-form {
        margin-left: 20px;       /* 댓글보다 오른쪽으로 들여쓰기 */
        padding: 10px;
        font-size: 0.95rem;       /* 글자도 살짝 작게 */
        margin-bottom: 20px;
    }
</style>

