<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // URL에서 전달된 파라미터 값 읽기
    String id = request.getParameter("id");
    String companyName = request.getParameter("company_name");
    String certType = request.getParameter("cert_type");
    String certValue = request.getParameter("cert_value");
%>

<style>
    body {
            margin: 0;
            height: 100vh; 
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            font-family: Arial, sans-serif;
    }
    table {
            border-collapse: collapse;
            border: 2px solid rgb(13, 125, 177);
            margin: 0 auto;
            width: 150%;
        }

    th, td{
        border: 1px solid black
        padding-top 10px;
        padding-bottom : 20px;
        padding-left : 10px;
        padding-right : 10px;

        text-align: center;
    }

    th{
        width: 60px;
    }

    td{
        width : 150%;
    }

    .input {
        width : 100%
        padding 5px;
        box-sizing: border-box;
        border: 1px solid black;
    }

    .inputbutton {
        padding: 10px 20px;
        border: 1px solid rgb(122, 122, 122);
        cursor: pointer;
        box-sizing: border-box;
        width: 150px; /* 버튼의 너비를 동일하게 설정 */
        height: 50px; /* 버튼의 높이를 동일하게 설정 */
        background-color: #d3d3d3;
        font-size: 14px;
    }
        .inputbutton[type="submit"] {
            background-color: #d3d3d3;
            width: 50%;
            height: 50%;
            margin : 5px;
            box-sizing : border-box;
        }

        .logo {
            width: 50px;
            height: auto;
        }

        .link-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            font-size : 12px;
            width : 100%;
            white-space: nowrap;
            margin: 5px;
        }
        .link-group a {
            color: #000000;
            text-decoration: underline;
            cursor: pointer;
        }
        .link-group a:hover {
            color: #FF0000;
        }
</style>

<form name="findIdResult" method="post" action="/auth/findIdResult.do">
    <table>
        <tr>
            <th style="padding-top: 10px;"> 아이디 찾기 결과 </th>
        </tr>
        <tr>
            <td style="background-color: #b3ecff; padding: 10px 15px; text-align: center;" >
              <% if (id != null && !id.isEmpty()) { %>
                   <strong><%= id %></strong>
               <% } else { %>
                  <span>일치하는 아이디를 찾을 수 없습니다.</span>
               <% } %>
            </td>
        </tr>
        <tr>
            <td>
                <input class="inputbutton" type="button" value="비밀번호찾기" onclick="location='/findPw'">
            </td>
        </tr>
        <tr>
            <td>
                <input class="inputbutton" type="button" value="로그인" onclick="location='/login'">
            </td>
        </tr>
    </table>
</form>