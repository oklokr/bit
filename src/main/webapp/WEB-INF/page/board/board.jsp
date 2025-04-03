<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="boardSetting.jsp" %>
<div style="display: none;">
넘어와야 되는 값: 
board_count 총 글 개수
number 출력용 글번호
count 전체 글 개수
dtos dto list
</div>

<div>
    확인용데이터<br>
    <c:set var="board_count" value="10"/>
    <c:set var="number" value="10"/>
    <c:set var="count" value="10"/>
    <c:set var="dtos" value="null"/>

</div>

<h3> 자유게시판 </h3>
<br>
<div>
${count}${str_board_num}
<input type="button" value="${str_write_button}"/>

${str_num}
<table>
    <tr>
        <th>${str_num}</th>
        <th>${str_title}</th>
        <th>${str_author}</th>
        <th>${str_creation_date}</th>
        <th>${str_view_count}</th>
    </tr>
    <c:if test="${count eq 0}">
        <tr>
            <td colspan = "5">${msg_board_null}</td>
        </tr>

    </c:if>
    <c:if test="${count ne 0}">
        <c:set var="number" value="${number}"/>
        <c:foreach var="dto" items="${dtos}">
            <tr>
                <td>
                    ${number}
                    <c:set var="number" value="${number-1}"/>
                </td>
                <td>
                    <a href="board/detail?id=${dto.id}&pageNum=${pageNum}&number=${number+1}">
                        ${dto.title}
                    </a>
                </td> 
                <td>
                    ${dto.author}
                </td>
                <td>
                    ${dto.creation_date}
                </td>
                <td>
                    ${dto.view_count}
                </td>
            </tr>
        </c:foreach>
    </c:if>
</table>

</div>