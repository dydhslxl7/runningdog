<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
	</head>
	<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
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
                                <li class="xi-angle-right"><a href="movePlist.do">보호센터 정보</a></li>
                            </ul>
                        </div>
                        <h2><span>보호센터 정보</span></h2>
                        <h3>지역 안의 보호센터의<br/>위치와 정보를 알려드립니다.</h3>
                    </div>
                </div>
                <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        <!--상세-->
                        <div class="serviceView">
                            <p class="topText" style="text-align:center;">
                                Tip. 보호센터의 정보는 본 내용과 같거나 다를 수 있습니다. 정확한 정보를 원하실 경우 이메일 또는 전화로 문의주시기 바랍니다.
                            </p>
                            <dl>
                                <dt>
                                    <div class="viewImg">                                        
                                        <div class="swiper-container gallery-top">
                                            <ul class="swiper-wrapper">
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                            </ul>
                                            <!-- Add Arrows -->
                                            <div class="swiper-button-next swiper-button-white"></div>
                                            <div class="swiper-button-prev swiper-button-white"></div>
                                        </div>
                                        <div class="swiper-container gallery-thumbs">
                                            <ol class="swiper-wrapper">
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
                                                <li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png"/></li>
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
                                    <a class="linkBtn" href="tel:010-3387-7583"><i class="xi-call"></i> 전화하기</a>
                                    <a class="linkBtn" href="#none" data-toggle="popover3" data-title="${ volunteer.voltitle }" data-image="${ volunteer.volre1 }"><i class="xi-share-alt-o"></i> 공유하기</a>
                                </dt>
                                <dd>
                                    <div id="map" style="width:100%;height:350px;"></div>
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
                                  geocoder.addressSearch('${protect.proaddressnew}', function(result, status) {

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
                                          content: '<div style="width:150px;text-align:center;padding:6px 0;">${protect.proname }</div>'
                                      });
                                      infowindow.open(map, marker);

                                      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                                      map.setCenter(coords);
                                  } 
                                  });
                                  </script>
                                    <!-- <div><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6324.481505654264!2d127.00051190256856!3d37.572948171699984!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca325b4d9b81b%3A0xba2de96c741b670a!2z7ISc7Jq47Yq567OE7IucIOyiheuhnOq1rCDsooXroZw1LjbqsIDrj5k!5e0!3m2!1sko!2skr!4v1598454835067!5m2!1sko!2skr" width="100%" height="281.3rem" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe></div> -->
                                    <h3 class="mt30" id="detail" >센터정보</h3>
                                    
                                    <table id="pdetail" class="serviceInfo">
                                       <colgroup>
                                           <col width="15%">
                                           <col width="35%">
                                           <col width="15%">
                                           <col width="35%">
                                       </colgroup>
                                        <tbody>
                                           <tr>
                                                <th>동물보호센터명</th>
                                                <td colspan="3">${ protect.proname }</td>
                                            </tr>
                                            <tr>
                                                <th>동물보호센터유형</th>
                                                <td>${ protect.protype }</td>
                                                <th>연락처</th>
                                                <td>${ protect.protel }</td>
                                            </tr>
                                            <tr>
                                                <th>관할구역</th>
                                                <td>${ protect.proorgnm }</td>
                                                <th>운영시간</th>
                                                <td>9:00 ~ 18:00 (평일)</td>
                                            </tr>
                                            <tr>
                                                <th>도로명주소</th>
                                                <td colspan="3">${ protect.proaddressnew }</td>
                                            </tr>
                                            <tr>
                                                <th>소재지번주소</th>
                                                <td colspan="3">${ protect.proaddressold }</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </dd>
                            </dl>
                            <div class="textCon">
                                바람직한 반려동물 문화 조성, 동물학대 사건대응, 피학대 동물 구조 및 보호, 유기동물재입양, 개식용금지, 길고양이와 공존 등 다양한 분야에 대한 제도 정비 및 인식 개선 캠페인을 진행하고 있습니다.
                            </div>
                        </div>
                        <!-- 상세 끝 -->
                    
                        <!-- 버튼 -->
                        <div class="viewBtn-wrap">
                        	<c:url var="ppre" value="ppre.do">
                            	<c:param name="prono" value="${protect.prono}"/>
                            	<c:param name="searchFiled" value="${ searchFiled }" />
								<c:param name="searchValue" value="${ searchValue }" />
                            </c:url>
                            <c:url var="pnext" value="pnext.do">
                            	<c:param name="prono" value="${protect.prono}"/>
                            	<c:param name="searchFiled" value="${ searchFiled }" />
								<c:param name="searchValue" value="${ searchValue }" />
                            </c:url>
                       		<button class="nextBtn" onclick="javascript:location.href='${pnext}'"><i class="xi-angle-left-min"></i>다음</button>
                            <button class="listBtn"onclick="location.href='movePlist.do'"><i class="xi-rotate-left"></i> 목록</button>
                            <button class="prevBtn" onclick="javascript:location.href='${ppre}'">이전<i class="xi-angle-right-min"></i></button>
                        </div>
                        <!-- 버튼 끝 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
		
				<!-- ajax로 JSON객체 가져오기 -->
<!-- <script type="text/javascript">

$(function(){
	var careNm = '${careNm}';/* '<c:out value="${careNm}"/>' */	
	console.log(careNm)
	$.ajax({
		url : "resources/ProtectXml/protectlist.xml",
		cache : "false", 
		dataType: "xml", //받는 값
		success : function(data){
			console.log("success:성공");
			var info = "";
			$(data).find("item").each(function(){
				info += 
					"<tr>"
            		    +"<th>동물보호센터명</th>"
            		    +"<td colspan='3'>"+$(this).find("careNm").text() +"</td>"
            		    +"</tr>"
            		    +"<tr>"
            		    +"<th>동물보호센터유형</th>"
            		    +"<td>" + $(this).find("divisionNm").text() + "</td>"
            		    +"<th>연락처</th>"
            		    +"<td>" + $(this).find("careTel").text() + "</td>"
            		    +"</tr>"
            		    +"<tr>"
            		    +"<th>운영방식</th>"
            		    +"<td>" +  $(this).find("divisionNm").text() + "</td>"
            		   // +"<th>운영시간</th>"
            		   // +"<td> " + json.list[i].weekOprStime +"~"+json.list[i].weekOprEtime + " (평일)</td>"
            		    +"</tr>"
            		    +"<tr>"
            		    +"<th>도로명 주소</th>"
            		    +"<td colspan='3'>"+ $(this).find("careAddr").text() +"</td>"
            		   + "</tr>"
           		 $('#pdetail > tbody').html(info); 
			});//success
				
            },
            error : function(jqXHR, textstatus, errorthrown) {
               console.log("error : " + jqXHR + ", " + textstatus
                     + ", " + errorthrown); 
		}
	});//ajax
	
});//document.ready

</script>  -->
	</body>
</html>