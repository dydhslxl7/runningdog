<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
	</head>
	<body oncontextmenu="return false" ondragstart="return false">
		<div id="wrap">
            <c:import url="/WEB-INF/views/include/header.jsp"/>
			<!-- 컨텐츠 -->
			<div id="content">
			    <!--서브 비주얼/타이틀-->
                <div class="visual-sub-vagas animal-vagas">
                    <div class="vsv-copy sub-title">
                       <div>
                            <ul class="navi">
                                <li><a href="main.do">홈</a></li>
                                <li class="xi-angle-right"><a href="animalList.do">유기동물매칭</a></li>
                            </ul>
                        </div>
                        <h2><span>유기동물매칭</span></h2>
                        <h3>가족을 기다리는 작은 천사에게<br/>가족과 친구가 되어주세요.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        
                        <!--상세-->
                        <div class="animalView">
                            <p class="topText">*「동물보호법」 제17조, 시행령7조 및 동법 시행규칙 제20조에 따라 유기·유실동물을 보호하고 있는 경우에는 소유자 등이 보호조치 사실을 알 수 있도록 7일 동안 공고하여야 합니다.</p>
                            <dl>
                                <dt>
                                    <div class="viewImg"><img src="${ animal.popfile }" id="imgControll" onclick="fnImgPop(this.src)"></div>
                                    <!-- <a class="linkBtn" href="mailto:spark720@naver.com"><i class="xi-mail-o"></i> 메일보내기</a> -->
                                    <a class="linkBtn" href="tel:010-3387-7583"><i class="xi-call"></i> 전화하기</a>
                                    <a data-id="${ animal.desertionNo }" data-title="${ animal.careAddr }" data-summary="${ animal.specialMark }" data-image="${ animal.popfile }"
                                    class="linkBtn" data-toggle="popover5"><i class="xi-share-alt-o" ></i> 공유하기</a> 
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
                                                <th>공고번호</th>
                                                <td>${ animal.noticeNo }</td>
                                                <th>견종</th>
                                                <td>${ animal.kindCd }</td>
                                            </tr>
                                            <tr>
                                                <th>색상</th>
                                                <td>${ animal.colorCd }</td>
                                                <th>나이/체중</th>
                                                <td>${ animal.age } / ${ animal.weight }</td>
                                            </tr>
                                            <tr>
                                                <th>성별</th>
                                                <td>${ animal.sexCd eq 'F'? "여/女" : "남/男" }</td>
                                                <th>중성화 여부</th>
                                                <td>${ animal.neuterYn } / <span class="protectOn">${ animal.processState }</span><!-- span class="protectOut">${ animal.processState }</span--></td>
                                            </tr>
                                            <tr>
                                                <th>특징/성향</th>
                                                <td>${ animal.specialMark }</td>
                                                <th>공고기한</th>
                                                <td><fmt:parseDate var="animalDate" value="${animal.noticeSdt}" pattern="yyyyMMdd"/>
                                                	<fmt:formatDate value="${animalDate}" pattern="yyyy-MM-dd"/>

                                                 ~ <br><fmt:parseDate var="animalDate2" value="${animal.noticeEdt}" pattern="yyyyMMdd"/>
                                                	<fmt:formatDate value="${animalDate2}" pattern="yyyy-MM-dd"/>
                                                	</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    
                                    <h3 class="mt30">센터정보</h3>
                                    <table class="animalInfo">
                                       <colgroup>
                                           <col width="15%">
                                           <col width="35%">
                                           <col width="15%">
                                           <col width="35%">
                                       </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>보호센터</th>
                                                <td>${ animal.careNm }</td>
                                                <th>연락처</th>
                                                <td>${ animal.careTel }</td>
                                            </tr>
                                            <tr>
                                                <th>지역</th>
                                                <td colspan="3">${ animal.careAddr }</td>
                                            </tr>
                                            <tr>
                                                <th>관할기관</th>
                                                <td>${ animal.orgNm }</td>
                                                <th>조회수</th>
                                                <td>${ animal.aCount }</td>
                                            </tr>
                                            <tr>
                                                <th>연락처</th>
                                                <td colspan="3">${ animal.officetel }</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </dd>
                            </dl>
                            <div class="map_wrap mb50">
									<div class="hAddr">
										<div id="map"
											style="width: 1000px; height: 300px; position: relative; overflow: hidden;">
										</div>
									</div>
								</div> <script type="text/javascript"
									src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68c702b1618fe5e7850fb8b93c89734b&libraries=services"></script>
								<script>
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							    mapOption = {
							        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
							        level: 8 // 지도의 확대 레벨
							    };  

							// 지도를 생성합니다    
							var map = new kakao.maps.Map(mapContainer, mapOption); 

							// 주소-좌표 변환 객체를 생성합니다
							var geocoder = new kakao.maps.services.Geocoder();

							// 주소로 좌표를 검색합니다
							geocoder.addressSearch('${ animal.careAddr }', function(result, status) {

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
							            content: '<div style="width:150px;text-align:center;padding:6px 0;">' +"센터위치<br>${ animal.careAddr }</div>"
							        });
							        infowindow.open(map, marker);

							        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							        map.setCenter(coords);
							    } 
							});    
							</script>
                            
                            <div class="textCon">
                                상기 동물을 분실하신 소유주께서는 보호센터로 문의하시어 동물을 찾아가시기 바라며, 동물보호 법 제17조의 규정에 따른 공고가 있는 날부터 10일이 경과하여도 소유자 등을 알 수 없는 경우에는 유실물법 제12조 및 민법 제253조의 규정에 불구하고 해당 시,군,구 자치구가 그 동물의 소유권을 취득하게 됩니다.<br/>
                                2020년 08월 25일<br>
                                공공 데이터 제공 : 농림축산식품부 농림축산검역본부 
                            </div>

                                
                        </div>
                        <!-- 상세 끝 -->
                    
                        <!-- 버튼 -->
                        
                        <c:url var = "alistMove" value= "animalList.do">
							<c:param name="pageNo" value="${ animal.pageNo }"/>
							<c:param name="searchFiled" value="${ pageVO.searchFiled }" />
							<c:param name="searchValue" value="${ pageVO.searchValue }" />
						</c:url>
						<c:url var="animalNext" value="animalNext.do">
							<c:param name="desertionNo" value="${ animal.desertionNo }"/>
                            <c:param name="searchFiled" value="${ pageVO.searchFiled }" />
							<c:param name="searchValue" value="${ pageVO.searchValue }" />
						</c:url>
						<c:url var="animalPrev" value="animalPrev.do">
							<c:param name="desertionNo" value="${ animal.desertionNo }"/>
                            <c:param name="searchFiled" value="${ pageVO.searchFiled }" />
							<c:param name="searchValue" value="${ pageVO.searchValue }" />
						</c:url>
                        
                        
                        <div class="viewBtn-wrap">
                            <button class="nextBtn" onclick="location='${ animalPrev }'" ><i class="xi-angle-left-min"></i> 이전</button>
                            <button class="listBtn" onclick="location='${ alistMove }'" ><i class="xi-rotate-left"></i> 목록</button>
                            <button class="prevBtn" onclick="location='${ animalNext }'" >다음 <i class="xi-angle-right-min"></i></button>
                        </div>
                        <!-- 버튼 끝 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>