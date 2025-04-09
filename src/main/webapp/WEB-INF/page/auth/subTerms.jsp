<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bit Dental 선택 약관</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 24px;
            margin: 0;
        }
        .content {
            max-height: 400px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fefefe;
        }
        .content h2, .content h3, .content h4 {
            margin-top: 20px;
            font-size: 18px;
        }
        .content p, .content ul, .content li {
            font-size: 14px;
            line-height: 1.6;
        }
        .content ul {
            padding-left: 20px;
        }
        .content li {
            list-style-type: disc;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
        }
        .footer button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        .footer button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Bit Dental 선택 약관</h1>
        </div>
        <div class="content">
            <h2>3. 선택 약관</h2>
            <h3>회원 콘텐츠 활용 동의서</h3>
            <h4>1. 수집 및 활용 항목</h4>
            <p>
                회원이 Bit Dental에 업로드한 다음의 콘텐츠는 본 동의에 따라 활용될 수 있습니다.
            </p>
            <ul>
                <li>상품 등록 시 입력한 정보 (이미지, 제품명, 설명 등)</li>
                <li>커뮤니티 게시글 및 댓글 내용</li>
                <li>기타 서비스 내 자발적으로 등록한 콘텐츠</li>
            </ul>
            <h4>2. 활용 목적</h4>
            <p>
                Bit Dental은 위 콘텐츠를 다음의 목적으로 활용할 수 있습니다.
            </p>
            <ul>
                <li>서비스 홍보 및 마케팅 자료로 활용 (예: 주요 등록 상품 소개, 커뮤니티 활동 사례 등)</li>
                <li>콘텐츠 기반 통계/분석/연구 자료로 활용</li>
                <li>외부 제휴처 제공 콘텐츠 자료로 비식별화하여 활용</li>
            </ul>
            <h4>3. 활용 범위 및 방법</h4>
            <p>
                콘텐츠는 회원의 개인정보가 식별되지 않도록 처리한 후 사용됩니다.
            </p>
            <ul>
                <li>게시물 내용, 상품 정보, 이미지 등은 Bit Dental의 공식 채널(웹사이트, SNS, 블로그 등)이나 서비스 개선을 위한 내부 분석 자료로 사용될 수 있습니다.</li>
                <li>활용 시, 회원 개별 동의 없이 게시물 원문을 수정하거나 회원명(ID 등)을 노출하지 않습니다.</li>
                <li>수익 목적의 활용은 하지 않습니다.</li>
            </ul>
            <h4>4. 동의 거부 시 불이익</h4>
            <p>
                해당 약관은 선택 사항이며, 동의를 거부하셔도 회원가입 및 서비스 이용에 제한은 없습니다. 단, 동의하지 않을 경우 회원이 등록한 콘텐츠는 Bit Dental의 홍보나 통계자료 등으로 활용되지 않습니다.
            </p>
        </div>
        <div class="footer">
            <button onclick="location='/join'">확인</button>
        </div>
    </div>
</body>
</html>