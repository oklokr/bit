<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원관리 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/css/common.css">
</head>
<body>
<div class="container mt-5" style="max-width: 1000px;">
    <h4><strong>회원관리 상세</strong></h4>

    <!-- 회원정보 -->
    <div class="border rounded p-4 mt-5 bg-white shadow-sm">
        <h6><strong>회원정보</strong></h6>
        <table class="table table-borderless mb-0">
            <colgroup>
                <col style="width: 15%;">
                <col style="width: 35%;">
                <col style="width: 15%;">
                <col style="width: 35%;">
            </colgroup>
            <tbody>
                <tr>
                    <th>회원 ID</th>
                    <td>${userDto.id}</td>
                    <th>이메일</th>
                    <td><a href="mailto:${userDto.email}">${userDto.email}</a></td>
                </tr>
                <tr>
                    <th>회원유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${userDto.memberType == 1}">일반 회원</c:when>
                            <c:when test="${userDto.memberType == 2}">관리자</c:when>
                            <c:otherwise>관리자</c:otherwise>
                        </c:choose>
                    </td>
                    <th>전화번호</th>
                    <td colspan="3">${userDto.phoneNumber}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 사업체 정보 -->
    <div class="border rounded p-4 mt-5 bg-white shadow-sm">
        
        <div class="row">
            <!-- 왼쪽: 사업체 정보 -->
            <div class="col-md-7">
                <table class="table table-borderless mb-0">
                    <tbody>
                        <tr>
                            <th><h6><strong>사업체 정보</strong></h6></th>
                            <td></td>
                        </tr>
                        <tr>
                            <th id="companyName">사업체명</th>
                            <td>${userDto.companyName}</td>
                        </tr>
                        <tr>
                            <th>사업자번호</th>
                            <td>${userDto.businessNumber}</td>
                        </tr>
                        <tr>
                            <th>사업체주소</th>
                            <td>${userDto.address} ${userDto.detailedAddress}<br>
                                우편번호: ${userDto.postalCode}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
    
            <!-- 오른쪽: 지도 -->
            <div class="col-md-5 d-flex align-items-center justify-content-center">
                <div id="map" style="width:300px;height:300px;"></div>
            </div>
        </div>
    </div>

   <!-- 버튼 -->
    <div class="mt-4 d-flex justify-content-between align-items-center">
        <!-- 왼쪽: 목록 버튼 -->
        <a href="${pageContext.request.contextPath}/admin?pageNum=${pageNum}" class="btn btn-outline-dark">
            목록
        </a>

        <!-- 오른쪽: 초기화 + 탈퇴 버튼 그룹 -->
        <div class="d-flex gap-2 ms-auto">
            <c:if test="${userDto.id != user}">
                <button class="btn btn-secondary" onclick="locationLink('changeUser', '${id}')">회원유형 변경</button>
            </c:if>
            <button class="btn btn-secondary" onclick="locationLink('resetPw', '${id}')">비밀번호 초기화</button>
            <button class="btn btn-danger" onclick="locationLink('deleteUser', '${id}')">회원 탈퇴</button>
        </div>
    </div>

</div>
</body>
</html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapJsKey}&libraries=services,clusterer,drawing"></script>
<script>
    function locationLink(type, data) {
        let pageNum = "${pageNum}";
        let id = "${id}";
        let memberType = "${userDto.memberType}";
        const userObj = {
            id: data,
            memberType: memberType
        };

        if (type === 'changeUser') {
            modal({
                content: data+memberType+"${userDto.companyName}의 회원 유형을 변경하시겠습니까?",
                type: "confirm",
                fnConfirm: () =>  postRequestApi("/api/admin/change", userObj, res => {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                })
            })
        }
        if(type === 'resetPw') {
            modal({
                content: "${userDto.companyName}의 비밀번호 초기화를 하시겠습니까?",
                type: "confirm",
                fnConfirm: () =>  postRequestApi("/api/admin/reset", data, res => {
                    location.href = "/admin/detail?pageNum=" + pageNum + "&id=" + id;
                })
            })
        }
        if(type === 'deleteUser') {
            modal({
                content: "${userDto.companyName}의 회원 탈퇴를 진행하시겠습니까?",
                type: "confirm",
                fnConfirm: () =>  postRequestApi("/api/admin/delete", data, res => {
                    modal({
                        content: "${userDto.companyName}의 회원 탈퇴가 완료되었습니다.",
                        type: "alert",
                        fnClose: () =>  {
                            location.href = "/admin?pageNum=" + pageNum;
                        }
                    })
                })
            })
        }
    }

    kakao.maps.load(function () {
            let companyName="${companyName}";
            let address = "${address}";
            let poastalCode = "${postalCode}";
            let detailedAddress = "${detailedAddress}";
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };
            var map = new kakao.maps.Map(container, options);

            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    map.setCenter(coords);
                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 마커가 지도 위에 표시되도록 설정합니다
                    marker.setMap(map);

                    // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
                    // marker.setMap(null);  
                    var content = '<div class="wrap">' + 
                                    '    <div class="info">' + 
                                    '        <div class="title">' + 
                                    '            ${companyName}' + 
                                    '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
                                    '        </div>' + 
                                    '        <div class="body">' + 
                                    '            <div class="desc" style="margin-left:15px;">' + 
                                    '                <div class="ellipsis">${address} ${detailedAddress}</div>' + 
                                    '                <div class="jibun ellipsis">우편변호: ${postalCode}</div>' + 
                                    '            </div>' + 
                                    '        </div>' + 
                                    '    </div>' +    
                                    '</div>';

                    // 마커 위에 커스텀오버레이를 표시합니다
                    // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
                    var overlay = new kakao.maps.CustomOverlay({
                        content: content,
                        map: map,
                        position: marker.getPosition()       
                    });

                    // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
                    kakao.maps.event.addListener(marker, 'click', function() {
                        overlay.setMap(map);
                    });

                    // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
                    window.closeOverlay = function() {
                        overlay.setMap(null);
                    }

                } else {
                    console.error("주소 검색 실패");
                }
            });

            
        });

</script>
<style>
    h5 {
        font-size: 1.4rem;
    }

    h6 {
        font-size: 1.1rem;
        margin-bottom: 1rem;
    }


    .btn-danger {
        color: white;
    }

    .shadow-sm {
        box-shadow: 0 0.2rem 0.5rem rgba(0,0,0,0.05);
    }
    .wrap {
        position: absolute;
        left: 0;
        bottom: 30px;
        width: 240px;
        height: 80px;
        margin-left: -120px;
        text-align: left;
        overflow: hidden;
        font-size: 11px;
        font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
        line-height: 1.4;
    }
    .wrap * {
        padding: 0;
        margin: 0;
    }
    .wrap .info {
        width: 238px;
        height: 78px;
        border-radius: 5px;
        border-bottom: 2px solid #ccc;
        border-right: 1px solid #ccc;
        overflow: hidden;
        background: #fff;
        box-shadow: 0px 1px 2px #888;
    }
    .info .title {
        padding: 4px 0 0 10px;
        height: 26px;
        background: #eee;
        border-bottom: 1px solid #ddd;
        font-size: 14px;
        font-weight: bold;
    }
    .info .close {
        position: absolute;
        top: 8px;
        right: 8px;
        width: 15px;
        height: 15px;
        background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
        background-size: cover;
    }
    .info .close:hover {
        cursor: pointer;
    }
    .info .body {
        position: relative;
        overflow: hidden;
    }
    .info .desc {
        position: relative;
        margin: 8px 10px 0 10px;
        height: auto;
    }
    .desc .ellipsis {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    .desc .jibun {
        font-size: 10px;
        color: #888;
        margin-top: 2px;
    }
    .info:after {
        content: '';
        position: absolute;
        margin-left: -11px;
        left: 50%;
        bottom: 0;
        width: 22px;
        height: 12px;
        background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
    }
</style>
