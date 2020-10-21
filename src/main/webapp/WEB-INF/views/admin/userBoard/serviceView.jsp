<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="/WEB-INF/views/admin/include/admin_head.jsp"/>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="/WEB-INF/views/admin/include/admin_header.jsp"/>

        <div id="container">
            <c:import url="/WEB-INF/views/admin/include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>자원봉사모집 관리</h3>
                    <h2>상세보기</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="serviceView">
                <p class="topText" style="text-align:center;">
                    Tip. 전화상 문의하실 때에는 '지금 달려갈 개, 자원봉사 모집글 보고 연락드렸습니다.' 라고 문의주시면 빠른 답변이 가능합니다.
                </p>
                <dl>
                    <dt>
                        <div class="viewImg">                                        
                            <div class="swiper-container gallery-top">
                                <ul class="swiper-wrapper">
                                   <c:if test="${ empty volunteer.volre1 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre1 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre1 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre2 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre2 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre2 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre3 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre3 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre3 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre4 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre4 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre4 }"/></li>
                                   </c:if>
                                </ul>
                                <!-- Add Arrows -->
                                <div class="swiper-button-next swiper-button-white"></div>
                                <div class="swiper-button-prev swiper-button-white"></div>
                            </div>
                            <div class="swiper-container gallery-thumbs">
                                <ol class="swiper-wrapper">
                                    <c:if test="${ empty volunteer.volre1 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre1 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre1 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre2 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre2 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre2 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre3 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre3 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre3 }"/></li>
                                   </c:if>
                                   <c:if test="${ empty volunteer.volre4 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                   </c:if>
                                   <c:if test="${ !empty volunteer.volre4 }">
                                    <li class="swiper-slide"><img src="/runningdog/resources/vfiles/${volunteer.volre4 }"/></li>
                                   </c:if>
                                </ol>
                            </div>
                            <!-- Initialize Swiper -->
                            <script>
                                var galleryThumbs = new Swiper('.gallery-thumbs', {
                                    slidesPerView: 4,
                                    freeMode: true,
                                    watchSlidesVisibility: true,
                                    watchSlidesProgress: true,
                                });
                                var galleryTop = new Swiper('.gallery-top', {
                                    loop:true,
                                    autoplay: {
                                        delay: 2500,
                                        disableOnInteraction: false,
                                    },
                                    navigation: {
                                    nextEl: '.swiper-button-next',
                                    prevEl: '.swiper-button-prev',
                                    },
                                    thumbs: {
                                    swiper: galleryThumbs,
                                    },
                                });
                            </script>
                        </div>
                    </dt>
                    <dd>
                        <div id="map" style="width:100%;height:350px;"></div>
						<!-- 카카오지도 -->
                        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=78554901e4ce05b55a812c066e4b2f3b&libraries=services"></script>
                      	<script>
                        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                        mapOption = {
                            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                            level: 3 // 지도의 확대 레벨
                        };  

                        //지도를 생성합니다    
                        var map = new kakao.maps.Map(mapContainer, mapOption); 

                        //주소-좌표 변환 객체를 생성합니다
                        var geocoder = new kakao.maps.services.Geocoder();

                        //주소로 좌표를 검색합니다
                        geocoder.addressSearch('${volunteer.voladdress}', function(result, status) {

                        // 정상적으로 검색이 완료됐으면 
                         if (status === kakao.maps.services.Status.OK) {

                            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                            // 결과값으로 받은 위치를 마커로 표시합니다
                            var marker = new kakao.maps.Marker({
                                map: map,
                                position: coords
                            });

                            // 인포윈도우로 장소에 대한 설명을 표시합니다
                            var infowindow = new kakao.maps.InfoWindow({
                                content: '<div style="width:150px;text-align:center;padding:6px 0;">${volunteer.volname }</div>'
                            });
                            infowindow.open(map, marker);

                            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                            map.setCenter(coords);
                        } 
                        });
                      </script>
                      <!-- 카카오지도 -->               
                        <h3 class="mt30">센터정보</h3>
                        <table class="serviceInfo">
                           <colgroup>
                               <col width="15%">
                               <col width="35%">
                               <col width="15%">
                               <col width="35%">
                           </colgroup>
                            <tbody>
                                <tr>
                                    <th>제목</th>
                                    <td colspan="3">${ volunteer.voltitle }</td>
                                </tr>
                                <tr>
                                    <th>보호센터</th>
                                    <td>${volunteer.volname }</td>
                                    <th>연락처</th>
                                    <td>${volunteer.voltel }</td>
                                </tr>
                                <tr>
                                    <th>담당자</th>
                                    <td>${volunteer.volwriter } / #${ volunteer.unique_num }</td>
                                    <th>모집기간</th>
                                    	<c:if test="${ volunteer.volche eq 'y' }">
                                            <td>상시모집 / <span class="serviceOn">모집중</span></td>
                                        </c:if>
                                        <c:if test="${ volunteer.volche eq 'n'}">
                                            <td>상시모집 / <span class="serviceOn">모집완료</span></td>
                                        </c:if>	
                                </tr>
                                <tr>
                                    <th>지역/주소</th>
                                    <td colspan="3">${volunteer.voladdress }</td>
                                </tr>
                                <tr>
                                    <th>봉사기간</th>
                                    <td colspan="3">${volunteer.volterm1 }~${volunteer.volterm2}</td>
                                </tr>
                            </tbody>
                        </table>
                    </dd>
                </dl>

                <div class="viewContent">
                ${volunteer.volcontent }
                </div>
                
             	<!-- 버튼 -->
				<div class="viewBtn-wrap">
					<c:url var="vpread" value="vpre.ad">
						<c:param name="volno" value="${volunteer.volno}" />
						<c:param name="searchFiled" value="${ searchFiled }" />
						<c:param name="searchValue" value="${ searchValue }" />
						<c:param name="volche" value="${ volunteer.volche }" />
					</c:url>
					<c:url var="vdel" value="vdelete.ad">
                         <c:param name="volno" value="${volunteer.volno}"/>
                    </c:url>
					<button class="prevBtn" onclick="javascript:location.href='${vpread}'">이전<i class="xi-angle-right-min"></i></button>
					<button class="deleteBtn" onclick="javascript:location.href='${vdel}'"><i class="xi-cut"></i>삭제</button>
					<button class="listBtn" onclick="location.href='vlist.ad'"><i class="xi-rotate-left"></i>목록</button>
					<c:url var="vdel" value="vdelete.ad">
						<c:param name="volno" value="${volunteer.volno}" />
					</c:url>
					<c:url var="vnextad" value="vnext.ad">
						<c:param name="volno" value="${volunteer.volno}" />
						<c:param name="searchFiled" value="${ searchFiled }" />
						<c:param name="searchValue" value="${ searchValue }" />
						<c:param name="volche" value="${ volunteer.volche }" />
					</c:url>
					<button class="nextBtn" onclick="javascript:location.href='${vnextad}'"><i class="xi-angle-left-min"></i>다음</button>
				</div>
				<!-- 버튼 끝 -->

			</div>
            <!-- 상세 끝 -->
        </div>
        <c:import url="/WEB-INF/views/admin/include/admin_footer.jsp"/>
    </div>
</body>
</html>