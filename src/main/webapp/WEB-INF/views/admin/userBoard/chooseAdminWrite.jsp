<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>

<style>
.map_wrap {
	position: relative;
	width: 100%;
	height: 350px;
}

.title {
	font-weight: bold;
	display: block;
}

.hAddr {
	position: absolute;
	left: 10px;
	top: 10px;
	border-radius: 2px;
	background: #fff;
	background: rgba(255, 255, 255, 0.8);
	z-index: 1;
	padding: 5px;
}

#centerAddr {
	display: block;
	margin-top: 2px;
	font-weight: normal;
}

.bAddr {
	padding: 5px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
</style>
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
                    <h2>| 작성</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <form name="formname" method="post" onsubmit="return check()" enctype="multipart/form-data" action="dinsert.ad" class="form-inline">
            <div class="write-area">
            	 <input type="hidden" name="userId" value="${ sessionScope.loginMember.userId }">
                 <input type="hidden" name="uniqueNum" value="${ sessionScope.loginMember.uniqueNum }">
                 <input type="hidden" name="dWriter" value="${ sessionScope.loginMember.nickname }">
            	
            
                <h2>유기동물 주인찾기 작성</h2>
                <p>가족을 잃은 동물들에게 가족을 찾아주세요.</p>
                
                
                
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="80%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>제목 *</td>
                            <td><input type="text" name="dTitle" title="dTitle" class="form-control w100p" minlength="8" maxlength="30" placeholder="제목 입력" required/></td>
                        </tr>
                        <tr>
                            <td>썸네일 *</td>
                            <td><input type="file" name="upfile" title="" accept="image/jpeg,image/png,image/jpeg,image/bmp" 
                                onchange='chk_file_type(this);checkSize(this);' required/></td>
                        </tr>
                        <tr>
                            <td>발견날짜 *</td>
                            <td>
                            <input type="date" name="dFindDate" id="datePickerId" title="" class="form-control w50p" placeholder="발견날짜 입력" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>보호중 반려동물 *</td>
                            <td>
                            	<label><input type="radio" name="dCategory" value="d" checked/>강아지</label>
                                <label><input type="radio" name="dCategory" value="c" />고양이</label>
                                <label><input type="radio" name="dCategory" value="e" />기타</label>
                            </td>
                        </tr>
                        <tr>
                            <td>성별 *</td>
                            <td>
                            	<label><input type="radio" name="dGender" value="m" checked/>수컷</label>
                                <label><input type="radio" name="dGender" value="f"/>암컷</label>
                            </td>
                        </tr>
                        <tr>
                            <td>연락처 *</td>
                            <td>
                           		 <input type="text" name="dPhone" id ="dPhone" onKeyup="inputTelNumber(this);" maxlength="13" class="form-control w50p" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" placeholder="특수문자없이 숫자만 입력해 주세요" required/>
                            </td>
                        </tr>

							<tr>
								<td>보호자 대략 위치 *</td>
								<td><select name="dLocal" required="required">
										<option value="0">서울시</option>
										<option value="1">인천시</option>
										<option value="2">대전시</option>
										<option value="3">광주시</option>
										<option value="4">대구시</option>
										<option value="5">울산시</option>
										<option value="6">부산시</option>
										<option value="7">경기도</option>
										<option value="8">강원도</option>
										<option value="9">세종시</option>
										<option value="10">충청남도</option>
										<option value="11">충청북도</option>
										<option value="12">전라남도</option>
										<option value="13">전라북도</option>
										<option value="14">경상남도</option>
										<option value="15">경상북도</option>
										<option value="16">제주도</option>
								</select> <!-- <input type="text" name="dFindLocal" title="" class="form-control w50p" placeholder="발견장소 입력 구/동" required/> -->
								</td>
							</tr>

							<tr>
                            <td>특이사항 *</td>
                            <td>
                            	<input type="text" name="dPoint" title="" class="form-control w100p" minlength="10" maxlength="60" placeholder="특징/성향/색상 입력" required/>
                            </td>
                        </tr>

							<tr>
								<td>발견 장소를 클릭해 주세요</td>
								<!-- 카카오 지도 출력 -->
								<td>
									<div class="map_wrap">
										<div class="hAddr">
											<div id="map"
												style="width: 750px; height: 300px; position: relative; overflow: hidden;">
											</div>
										</div>
									</div> <script type="text/javascript"
										src="//dapi.kakao.com/v2/maps/sdk.js?appkey=68c702b1618fe5e7850fb8b93c89734b&libraries=services"></script>
									<script>
										var mapContainer = document
												.getElementById('map'), // 지도를 표시할 div 
										mapOption = {
											center : new kakao.maps.LatLng(
													36.627718, 127.967794), // 지도의 중심좌표
											level : 13
										// 지도의 확대 레벨
										};

										// 지도를 생성합니다    
										var map = new kakao.maps.Map(
												mapContainer, mapOption);

										// 주소-좌표 변환 객체를 생성합니다
										var geocoder = new kakao.maps.services.Geocoder();

										var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
										infowindow = new kakao.maps.InfoWindow(
												{
													zindex : 1
												}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

										// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
										searchAddrFromCoords(map.getCenter(),
												displayCenterInfo);

										// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
										kakao.maps.event
												.addListener(
														map,
														'click',
														function(mouseEvent) {
															searchDetailAddrFromCoords(
																	mouseEvent.latLng,
																	function(
																			result,
																			status) {
																		if (status === kakao.maps.services.Status.OK) {
																			var detailAddr = result[0].address.address_name;

																			var content = '<div class="bAddr">'
																					+ detailAddr;

																			// 마커를 클릭한 위치에 표시합니다 
																			marker
																					.setPosition(mouseEvent.latLng);
																			marker
																					.setMap(map);
																			var dFindLocal = detailAddr;
																			// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
																			infowindow
																					.setContent(content);
																			infowindow
																					.open(
																							map,
																							marker);
																			// 클릭한 위도, 경도 정보를 가져옵니다 
																			var latlng = mouseEvent.latLng;

																			var mapX = latlng
																					.getLng(); //경도
																			var mapY = latlng
																					.getLat(); //위도

																			marker
																					.setPosition(latlng);

																			var resultDiv = document
																					.getElementById('clickLatlng');

																			console
																					.log("mapX : "
																							+ mapX);
																			console
																					.log("mapY : "
																							+ mapY);
																			console
																					.log("dFindLocal : "
																							+ dFindLocal);
																			document.formname.mapX.value = mapX;
																			document.formname.mapY.value = mapY;
																			document.formname.dFindLocal.value = dFindLocal;

																		}
																	});
														});

										// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
										kakao.maps.event.addListener(map,
												'idle', function() {
													searchAddrFromCoords(map
															.getCenter(),
															displayCenterInfo);
												});

										function searchAddrFromCoords(coords,
												callback) {
											// 좌표로 행정동 주소 정보를 요청합니다
											geocoder.coord2RegionCode(coords
													.getLng(), coords.getLat(),
													callback);
										}

										function searchDetailAddrFromCoords(
												coords, callback) {
											// 좌표로 법정동 상세 주소 정보를 요청합니다
											geocoder.coord2Address(coords
													.getLng(), coords.getLat(),
													callback);
										}

										// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
										function displayCenterInfo(result,
												status) {
											if (status === kakao.maps.services.Status.OK) {
												var infoDiv = document
														.getElementById('centerAddr');

											}
										}
									</script> <input type="hidden" name="mapX" id="mapX" required>
									<input type="hidden" name="mapY" id="mapY" required> <input
									type="hidden" name="dFindLocal" id="dFindLocal" required>
								</td>
							</tr>


							<tr>
                            <td>세부내용 *</td>
                            <td>
                            <textarea name="dContent"  minlength="15" maxlength="1000" rows="" cols="" class="form-control" style="resize: none; width:100%; min-height:300px; max-height:300px;" required placeholder="게시판 성격과 다른글을 올리시면,사이트 이용이 정지되실 수 있습니다."></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="write-btn">
                <input type="button" class="btn btn-list" value="목록으로" onClick="history.go(-1)">
                <input type="reset" class="btn btn-cancel" value="취소하기">
                <input type="submit" class="btn btn-success" value="작성하기">
            </div>
            </form>
            <!-- 글쓰기 끝 -->
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>