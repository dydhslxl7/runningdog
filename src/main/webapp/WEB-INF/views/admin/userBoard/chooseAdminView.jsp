<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
<script type="text/javascript">    
$(function() {
	$(document).on('click',".Subcmt_btn",function() {
		$(this).siblings(".Subcmt").toggle(200);
	});
	$(document).on('click',".Subcmt_update_btn",function() {
		$(this).siblings(".Subcmt_update").toggle(200);
	});
	$(document).on('click',".Cmt_update_btn",function() {
		$(this).siblings(".Cmt_update").toggle(200);
	});
});

</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="../include/admin_header.jsp"/>

        <div id="container">
            <c:import url="../include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>유기동물 주인찾기 관리</h3>
                    <h2>| 상세</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="animalView">
                <p class="topText">*「동물보호법」 제17조, 시행령7조 및 동법 시행규칙 제20조에 따라 유기·유실동물을 보호하고 있는 경우에는 소유자 등이 보호조치 사실을 알 수 있도록 7일 동안 공고하여야 합니다.</p>
                <dl>
                    <dt>
                        <div class="viewImg"><img src="/runningdog/resources/dboard/dboardImage/${ dboard.viewImage }" id="imgControll" onclick="fnImgPop(this.src)" ></div>
						<c:url var="dSuccess" value="dUpSuccess.ad">
							<c:param name="dNum" value="${ dboard.dNum }" />
							<c:param name="dSuccess" value="${ dboard.dSuccess }" />
							
						</c:url>
						<!-- 분양 완료 버튼 클릭시 분양완료 상태였으면 분양취소를 분양이 아직 안된상태면 완료하기 표시 -->
						<a class="linkBtn" href="${ dSuccess }"><i class="xi-shield-checked"></i> ${ dboard.dSuccess eq 'y'? '분양완료취소':'분양완료하기'}</a>
					</dt>
                    <dd>
                        <h3>동물정보</h3>
                        <table class="animalInfo">
                           <colgroup>
                               <col width="20%">
                               <col width="30%">
                               <col width="20%">
                               <col width="30%">
                           </colgroup>
                            <tbody>
                                <tr>
                                    <th>반려 동물 종류</th>
                                    <td>
                                    	${ dboard.dCategory eq "d"?"강아지": "" }
										${ dboard.dCategory eq "c"?"고양이": "" } 
										${ dboard.dCategory eq "e"?"기  타": "" }
									</td>
                                    <th>발견날짜</th>
                                    <td>${ dboard.dFindDate }</td>
                                </tr>
                                <tr>
                                    <th>성별</th>
                                    <td>
                                    ${ dboard.dGender eq "m"?"남/男" : "" }
                                    ${ dboard.dGender eq "f"?"여/女" : "" }&nbsp;&nbsp;
                                    <c:if test = "${dboard.dSuccess eq 'n'}">
                                    <span class="protect">보호중</span>
                                    </c:if>
                    				<c:if test = "${dboard.dSuccess eq 'y'}">
                                    <span class="protect">인계완료</span>
                                    </c:if>
									</td>
                                    <th>분양 여부</th>
                                    <td>
                                     ${ dboard.dSuccess eq "y"? "새로운 가족을 찾았어요" : ""}
                                     ${ dboard.dSuccess eq "n"? "가족을 기다리고 있어요" : ""}
                                    </td>
                                </tr>
                                <tr>
                                    <th>발견장소</th>
                                    <td colspan="3">${ dboard.dFindLocal } 부근</td>
                                </tr>
                                <tr>
                                    <th>특이사항</th>
                                    <td colspan="3">${ dboard.dPoint }</td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <h3 class="mt30">임시보호자 정보</h3>
                        <table class="animalInfo">
                           <colgroup>
                               <col width="15%">
                               <col width="35%">
                               <col width="15%">
                               <col width="35%">
                           </colgroup>
                            <tbody>
                                <tr>
                                    <th>임시보호자</th>
                                    <td>${ dboard.dWriter } / # ${ dboard.uniqueNum }</td>
                                    <th>${ dboard.dDate ne dboard.dMdate ?"수정일": "작성일"}</th>
                                    <td>${ dboard.dDate eq dboard.dMdate ?dboard.dDate : dboard.dMdate}
                                </tr>
                                <tr>
                                    <th>연락처</th>
                                    <td>${ dboard.dPhone }</td>
                                    <th>이메일</th>
                                    <td>${ dboard.userId }</td>
                                </tr>
                                <tr>
                                    <th>지역</th>
                                    <td colspan="3">
                                    <c:set var="local" value="${fn:split('[서울시]|[인천시]|[대전시]|[광주시]|[대구시]|[울산시]|[부산시]|[경기도]|[강원도]|[세종시]|[충청남도]|[충청북도]|[전라남도]|[전라북도]|[경상남도]|[경상북도]|[제주시]', '|') }" />
									<c:forEach var="lo" items="${local }" varStatus="l">
									<c:if test="${l.count== (dboard.dLocal+1) }"> 
										${lo }
									</c:if>
									</c:forEach></td>
                                </tr>
                            </tbody>
                        </table>
                    </dd>
                </dl>

                <div class="viewContent">
                ${ dboard.dContent }
                </div>
					<div id="map" class="map_wrap mb50" style="width: 100%; height: 300px; position: relative; overflow: hidden;">
					</div> <script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68c702b1618fe5e7850fb8b93c89734b&libraries=services"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new kakao.maps.LatLng(
									'${dboard.mapY}', '${dboard.mapX}'), // 지도의 중심좌표
							level : 8
						// 지도의 확대 레벨
						};

						var map = new kakao.maps.Map(mapContainer,
								mapOption); // 지도를 생성합니다

						// 마커가 표시될 위치입니다 
						var markerPosition = new kakao.maps.LatLng(
								'${dboard.mapY}', '${dboard.mapX}');

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
							position : markerPosition
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);

						var iwContent = '<div style="padding:5px;"><style="color:blue" target="_blank">발견장소 : ${dboard.dFindLocal}</div>', iwPosition = new kakao.maps.LatLng(
								'${dboard.mapY}', '${dboard.mapX}'); //인포윈도우 표시 위치입니다

						// 인포윈도우를 생성합니다
						var infowindow = new kakao.maps.InfoWindow({
							position : iwPosition,
							content : iwContent
						});

						infowindow.open(map, marker);
				</script>

				<div class="textCon">
                    상기 동물을 분실하신 소유주께서는 보호센터로 문의하시어 동물을 찾아가시기 바라며, 동물보호 법 제17조의 규정에 따른 공고가 있는 날부터 10일이 경과하여도 소유자 등을 알 수 없는 경우에는 유실물법 제12조 및 민법 제253조의 규정에 불구하고 해당 시,군,구 자치구가 그 동물의 소유권을 취득하게 됩니다.<br>
                    ${ dboard.dDate }
                </div>
				<!-- 상세 끝 -->
                
                <!-- 버튼 -->
				<c:url var="dupPageMove" value="dupView.ad">
					<c:param name="dNum" value="${ dboard.dNum }" />
				</c:url>
				<c:url var="dlistMove" value="dboardList.ad">
					<c:param name="pageNo" value="${ dboard.pageNo }" />
					<c:param name="local" value="${ pageVO.local }"/>
                    <c:param name="searchFiled" value="${ pageVO.searchFiled }" />
					<c:param name="searchValue" value="${ pageVO.searchValue }" />
					<c:param name="category" value="${ pageVO.category }"/>
				</c:url>
				<c:url var="dboardHide" value="dHide.ad">
					<c:param name="dNum" value="${ dboard.dNum }" />
				</c:url>
				<c:url var="dboardNext" value="dboardnext.ad">
						<c:param name="dNum" value="${ dboard.dNum }"/>
							<c:param name="local" value="${ pageVO.local }"/>
                            <c:param name="searchFiled" value="${ pageVO.searchFiled }" />
							<c:param name="searchValue" value="${ pageVO.searchValue }" />
							<c:param name="category" value="${ pageVO.category }"/>
				</c:url>
				<c:url var="dboardPrev" value="dboardprev.ad">
						<c:param name="dNum" value="${ dboard.dNum }"/>
							<c:param name="local" value="${ pageVO.local }"/>
                            <c:param name="searchFiled" value="${ pageVO.searchFiled }" />
							<c:param name="searchValue" value="${ pageVO.searchValue }" />
							<c:param name="category" value="${ pageVO.category }"/>
				</c:url>
				<div class="viewBtn-wrap">
					<button class="nextBtn" onclick="location='${ dboardPrev }'">
						<i class="xi-angle-left-min"></i> 이전
					</button>
					<button class="listBtn" onclick="location='${ dlistMove }'">
						<i class="xi-rotate-left"></i> 목록
					</button>
					
						<button class="deleteBtn" onclick="location='${ dboardHide }'">
							<i class="xi-cut"></i> 숨김
						</button>
						<button class="modifiedBtn" onclick="location='${ dupPageMove }'">
							<i class="xi-pen-o"></i> 수정
						</button>
					
					<button class="prevBtn" onclick="location='${ dboardNext }'">
						다음 <i class="xi-angle-right-min"></i>
					</button>
				</div>
				<!-- 버튼 끝 -->

              
            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>