<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bit Dental 약관</title>
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
        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        .tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            font-size: 16px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-bottom: none;
            border-radius: 8px 8px 0 0;
        }
        .tab.active {
            background-color: #fff;
            font-weight: bold;
        }
        .content {
            display: none;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 0 0 8px 8px;
            background-color: #fefefe;
        }
        .content.active {
            display: block;
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
    <script>
        function showTab(tabId) {
            const tabs = document.querySelectorAll('.tab');
            const contents = document.querySelectorAll('.content');
            tabs.forEach(tab => tab.classList.remove('active'));
            contents.forEach(content => content.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            document.querySelector(`[data-tab="${tabId}"]`).classList.add('active');
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Bit Dental 약관</h1>
        </div>
        <div class="tabs">
            <div class="tab active" data-tab="terms" onclick="showTab('terms')">이용약관</div>
            <div class="tab" data-tab="privacy" onclick="showTab('privacy')">개인정보 동의서</div>
        </div>
        <div id="terms" class="content active">
            <h2>Bit Dental 이용약관</h2>
            <h3>제1조 (목적)</h3>
            <p>
                이 약관은 Bit Dental(이하 “사이트”라 합니다)의 이용과 관련하여 회원과 사이트 운영자 간의 권리, 의무 및 책임사항, 이용 조건 등을 규정함을 목적으로 합니다.
            </p>
            <h3>제2조 (정의)</h3>
            <p>...</p>
            <!-- 나머지 약관 내용 -->
        </div>
        <div id="privacy" class="content">
            <h2>개인정보 수집 및 이용 동의서</h2>
            <h3>1. 수집하는 개인정보 항목 및 수집방법</h3>
            <p>
                Bit Dental은 회원가입, 사용자 식별, 커뮤니티 및 재고관리 서비스 제공을 위해 아래와 같은 개인정보를 수집합니다.
            </p>
            <ul>
                <li>필수항목: 이름, 아이디, 비밀번호, 이메일 주소, 전화번호</li>
                <li>선택항목: 프로필 이미지, 소속(병원/기관명)</li>
                <li>자동수집 항목: 접속 IP, 쿠키, 방문일시, 브라우저 정보, OS 정보, 서비스 이용기록, 불량 이용 기록 등</li>
            </ul>
            <h3>2. 개인정보의 수집 및 이용 목적</h3>
            <p>...</p>
            <!-- 나머지 개인정보 동의서 내용 -->
        </div>
        <div class="footer">
            <button onclick="location='/join'">확인</button>
        </div>
    </div>
</body>
</html>