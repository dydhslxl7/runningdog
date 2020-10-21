<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="currentPage"  value="${ requestScope.currentPage }"/>
<c:set var="listCountVreply"  value="${ requestScope.listCountVreply }"/>
<c:set var="vr" value="${requestScope.vreply}"/>

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
                                <li class="xi-angle-right"><a href="vlist.do">자원봉사모집</a></li>
                            </ul>
                        </div>
                        <h2><span>자원봉사모집</span></h2>
                        <h3>작은 천사들을 위해 도와주실<br/>자원봉사자 여러분을 모집하고 있습니다.</h3>
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
                                Tip. 전화상 문의하실 때에는 '지금 달려갈 개, 자원봉사 모집글 보고 연락드렸습니다.' 라고 문의주시면 빠른 답변이 가능합니다.
                            </p>
                            <dl>
                                <dt>
                                    <div class="viewImg">                                        
                                        <div class="swiper-container gallery-top">
										  <ul class="swiper-wrapper">
											<c:if test="${ empty volunteer.volre1 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre1 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre1 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre2 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre2 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre2 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre3 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre3 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre3 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre4 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre4 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre4 }" /></li>
											</c:if>
										  </ul>
										<!-- Add Arrows -->
                                            <div class="swiper-button-next swiper-button-white"></div>
                                            <div class="swiper-button-prev swiper-button-white"></div>
                                        </div>
									<div class="swiper-container gallery-thumbs">
										<ol class="swiper-wrapper">
											<c:if test="${ empty volunteer.volre1 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre1 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre1 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre2 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre2 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre2 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre3 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre3 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre3 }" /></li>
											</c:if>
											<c:if test="${ empty volunteer.volre4 }">
												<li class="swiper-slide"><img src="/runningdog/resources/images/common/noImage02.png" /></li>
											</c:if>
											<c:if test="${ !empty volunteer.volre4 }">
												<li class="swiper-slide"><img
													src="/runningdog/resources/vfiles/${volunteer.volre4 }" /></li>
											</c:if>
										</ol>
									</div>
									<!-- Initialize Swiper -->
									<script>
										var galleryThumbs = new Swiper(
												'.gallery-thumbs',
												{
													slidesPerView : 4,
													freeMode : true,
													watchSlidesVisibility : true,
													watchSlidesProgress : true,
												});
										var galleryTop = new Swiper(
												'.gallery-top',
												{
													loop : true,
													autoplay : {
														delay : 2500,
														disableOnInteraction : false,
													},
													navigation : {
														nextEl : '.swiper-button-next',
														prevEl : '.swiper-button-prev',
													},
													thumbs : {
														swiper : galleryThumbs,
													},
												});
									</script>
								</div>
								
                                    
                                    <a class="linkBtn" href="tel:010-3387-7583"><i class="xi-call"></i> 전화하기</a>
                                    <c:if test="${sessionScope.loginMember.getNickname() != volunteer.volwriter}">
                                    <a class="linkBtn" href="startChat.do?receiver=${volunteer.volwriter}&receiverNo=${volunteer.unique_num}"><i class="xi-message-o"></i> 채팅하기</a>
                                    </c:if>
                                    <c:if test="${sessionScope.loginMember.getNickname() == volunteer.volwriter}">
                                    <a class="linkBtn" onclick="location.href=alert('자신에게 채팅할 수 없습니다'); location.reload();"><i class="xi-message-o"></i> 채팅하기</a>
                                    </c:if>
                                    <a class="linkBtn" href="#none" data-toggle="popover3" data-title="${ volunteer.voltitle }" data-image="${ volunteer.volre1 }"><i class="xi-share-alt-o"></i> 공유하기</a>
                                </dt>
                                <dd>
                                <!-- 카카오지도 -->
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
                                
                        </div>
                        <!-- 상세 끝 -->
                    
                        <!-- 버튼 -->
                        <div class="viewBtn-wrap">
                            <c:url var="vpre" value="vpre.do">
                            	<c:param name="volno" value="${volunteer.volno}"/>
                            	<c:param name="searchFiled" value="${ searchFiled }" />
								<c:param name="searchValue" value="${ searchValue }" />
								<c:param name="volche" value="${ volunteer.volche }"/>
                            </c:url>
                            <c:url var="vdel" value="vdelete.do">
                            	<c:param name="volno" value="${volunteer.volno}"/>
                            </c:url>
                            <c:url var="vup" value="vUpdateView.do">
                            	<c:param name="volno" value="${volunteer.volno}"/>
                            	<c:param name="unique_num" value="${ volunteer.unique_num}"/>
                            </c:url>
                            <c:url var="vnext" value="vnext.do">
                            	<c:param name="volno" value="${volunteer.volno}"/>
                            	<c:param name="searchFiled" value="${ searchFiled }" />
								<c:param name="searchValue" value="${ searchValue }" />
								<c:param name="volche" value="${ volunteer.volche }"/>
                            </c:url>
                            
                            <button class="prevBtn" onclick="javascript:location.href='${vpre}'">이전<i class="xi-angle-right-min"></i></button>
                            <button class="listBtn" onclick="location.href='vlist.do'"><i class="xi-rotate-left"></i>목록</button>
                            <c:if test= "${ sessionScope.loginMember.nickname == volunteer.volwriter }">
                            <button class="deleteBtn" onclick="javascript:location.href='${vdel}'"><i class="xi-cut"></i>삭제</button>
                            <button class="modifiedBtn" onclick="javascript:location.href='${vup}'"><i class="xi-pen-o"></i>수정</button>
                            </c:if>
                            <button class="nextBtn" onclick="javascript:location.href='${vnext}'"><i class="xi-angle-left-min"></i>다음</button>
                        </div>
                        <!-- 버튼 끝 --> 
                        
         			 <!-- 댓글등록폼 -->
                        <div class="cmt_wrap" id="listReply">
                            <form name="vreply" id="vreply" role="vreply"> <!-- action="vrinsert.do" -->
                                <fieldset>
                                    <div class="cmt_form">
                                        <h4 class="cmt_head" id="totalcount"></h4>
                                        <div class="cmt_body">
        <textarea id="vreply_content" name="vreply_content" style="resize: none; width:100%; min-height:100px; max-height:100px;" onfocus="this.value='';">비방글은 작성하실 수 없습니다.</textarea>
                                            <input type="hidden" name="volno" value="${ volunteer.volno}">
                                            <input type="hidden" name="nickname" value="${ sessionScope.loginMember.nickname}">
                                             <input type="hidden" name="unique_num" value="${ sessionScope.loginMember.uniqueNum}">
                                            <div class="cmt_ok"><input type="submit" id="btn_vreplyInsert" value="등록"></div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        <!-- 댓글리스트 보기 -->
                           <ul id="VreplyList" class="cmt_con">
                     	   </ul>
                          </div>
                            
                   </div>   
                </div>
            </div>
            <!-- 컨텐츠 끝 -->
<script type="text/javascript">
$(document).ready(function(){
	showReplyList();
});
function showReplyList(){
	var paramData = {"volno" : ${ volunteer.volno}};

	$.ajax({
        type: "get",
        url: "vreplylist.do",
        data: paramData,
        dataType: "json",
        success: function(result) {
        	console.log("success : " + result); 
        	console.log("this.vreply_date : " + this.vreply_date);
			console.log("댓글 나오기"); 
			
			
			var totalcount = 0;
			var htmls = "";
			
			$(result).each(function(){
				
				var vreply_levell = this.vreply_level
				
				console.log(vreply_levell);
				 		if( vreply_levell == 1){
				htmls +='<li id="vreply_no'+this.vreply_no+'">'+
							'<dl>'+
							'<dt class="img"><img src="/runningdog/resources/images/test/animalImg02.jpg"></dt>'+
							'<dd><h4>'+ this.nickname+' / #'+this.unique_num +'</h4></dd>'+
							'<dt class="cmt_date">' + this.vreply_date +'</dt>'+
							' </dl>'+
							'<p>'+ this.vreply_content +'</p>'+
							'<div class="cmt_conBtn">'+
							'<c:if test="${ !empty sessionScope.loginMember }">'+
							'<button id="insertvreply" onclick="fn_SecondVreply(' + this.vreply_no + ', \'' + this.nickname + '\', \'' + this.vreply_content + '\' , \'' + this.unique_num + '\')">댓글</button>'+
							'<button class="Cmt_delete_ctn" onclick="fn_DeleteVreply(' + this.vreply_no + ', \'' + this.nickname + '\')">삭제</button>'+
							'<button id="Cmt_update_btn" onclick="fn_UpdateVreply(' + this.vreply_no + ', \'' + this.nickname + '\', \'' + this.vreply_content + '\', \'' + this.unique_num + '\' )">수정</button>'+
							'</c:if>'+
							'</div>'+
							'</li>'	;
				 		}
							else if( vreply_levell == 2){
					 htmls += '<li id="vreply_no'+this.vreply_no+'" style="background-color: #f0f0f0; padding: 0.375rem 3rem;">'+
								'<dl>'+
								'<dt class="img"><img src="/runningdog/resources/images/test/animalImg02.jpg"></dt>'+
								'<dd><h4>'+ this.nickname+' / #'+this.unique_num +'</h4></dd>'+
								'<dt class="cmt_date">' + this.vreply_date +'</dt>'+
								' </dl>'+
								'<p>'+ this.vreply_content +'</p>'+
								'<div class="cmt_conBtn">'+
								'<c:if test="${ !empty sessionScope.loginMember }">'+
								'<button class="Cmt_delete_ctn" onclick="fn_DeleteVreply(' + this.vreply_no + ', \'' + this.nickname + '\')">삭제</button>'+
								'<button id="Cmt_update_btn" onclick="fn_UpdateVreply(' + this.vreply_no + ', \'' + this.nickname + '\', \'' + this.vreply_content + '\', \'' + this.unique_num + '\' )">수정</button>'+
								'</c:if>'+
								'</div>'+
								'</li>';
							  }
							  
							
							
							totalcount = totalcount + 1
			}); //for in 
			
			$("#totalcount").text('전체'+ totalcount + '개');
			$('#VreplyList').html(htmls);
			
        },	  // Ajax success end
        error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus
						+ ", " + errorthrown); 
		}
	});	// Ajax end
}

//댓글저장
$("#btn_vreplyInsert").click(function(){
	var nickname = "${ sessionScope.loginMember.nickname}";
	if( nickname == "" )
		alert("로그인 후 이용해주세요.");
	
		var VreplyContent = $('#vreply_content').val();
		console.log(VreplyContent+"VreplyContent");
		var paramData = JSON.stringify({ "vreply_content" : $('#vreply_content').val() , nickname : '${ sessionScope.loginMember.nickname}', unique_num : '${ sessionScope.loginMember.uniqueNum}',"volno" : ${ volunteer.volno} });
		var headers = {"Content-Type" : "application/json" , "X-HTTP-Method-Override" : "POST"};
		$.ajax({
			url : 'vrinsert.do',
			data : paramData,
			headers : headers,
			type : 'post',
			dataType : 'text',
			success : function(result){
				
				$('#vreply_content').val();
				$('#nickname').val();
				$('#unique_num').val();
				showReplyList();
			},
			error : function(jqXHR, textstatus, errorthrown) {
				alert("댓글 등록을 실패하였습니다.");
				console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
			}
		});
});
//댓글수정폼
function fn_UpdateVreply(vreply_no, nickname, vreply_content, unique_num){
	var user = "${ sessionScope.loginMember.nickname}";
	var result = confirm("수정하시겠습니까?");
	var nickname = nickname
	if( user == "" )
		alert("로그인 후 이용해주세요.");
	else
		if( user == nickname )
			if(result == true){
				var htmls = "";
				htmls +='<li id="vreply_no'+vreply_no+'">'+
						'<dl>'+
						'<dt class="img"><img src="/runningdog/resources/images/test/animalImg02.jpg"></dt>'+
						'<dd><h4>'+ nickname +'</h4></dd>'+
						' </dl>'+
						'<p><textarea id="editContent" name="editContent" style="resize: none; width:100%; min-height:100px; max-height:100px;">'+ vreply_content +'</textarea></p>'+
						'<div class="cmt_conBtn">'+
						'<button class="Cmt_delete_ctn" onclick="showReplyList();">취소</button>'+
						'<button class="Cmt_update_btn" onclick="updateVreply(' + vreply_no + ', \'' + nickname + '\', \'' + unique_num + '\')">저장</button>'+
						'</div>'+
						'</li>'
							$('#vreply_no'+vreply_no).replaceWith(htmls);
							$('#vreply_no'+vreply_no+'#editContent').focus();
			}else
				return;
		else
			alert("작성자만 이용하실 수 있습니다.");
	
}
//댓글수정내용저장
function updateVreply(vreply_no, nickname){
	var editContent = $('#editContent').val();
	var paramData = JSON.stringify({"vreply_content" : editContent, "vreply_no" : vreply_no});
	var headers = {"Content-Type" : "application/json" , "X-HTTP-Method-Override" : "POST"};
	
	$.ajax({
		url : "vrupdate.do",
		headers : headers,
		data : paramData,
		type : 'POST',
		dataType :'text',
		success : function(result){
			console.log(result);
			alert("댓글이 수정되었습니다.");
			showReplyList(); 
		},
		error : function(jqXHR, textstatus, errorthrown) {
			console.log("error : " + jqXHR + ", " + textstatus
					+ ", " + errorthrown);
		} 
		
	});
}
//대댓글폼
function fn_SecondVreply(vreply_no, nickname, vreply_content, unique_num){
	var user = "${ sessionScope.loginMember.nickname}";
	var nickname = nickname
				var htmls = "";
				htmls += '<li id="vreply_no'+vreply_no+'">'+
						'<dl>'+
						'<dt class="img"><img src="/runningdog/resources/images/test/animalImg02.jpg"></dt>'+
						'<dd><h4>'+ nickname +' / #'+ unique_num +'</h4></dd>'+
						' </dl>'+
						'<p>'+ vreply_content +'</p>'+
						'</li>'	+
						'<form name="" id="" role="vreply">'+
						'<fieldset>'+
						'<div class="cmt_form">'+
						'<h4 class="cmt_head" id="totalcount"></h4>'+
						'<div class="cmt_body">'+
						'<textarea id="second_content" name="second_content" style="resize: none; width:100%; min-height:100px; max-height:100px;"></textarea>'+
						'<input type="hidden" name="volno" value="${ volunteer.volno}">'+
						'<input type="hidden" name="nickname" value="${ sessionScope.loginMember.nickname}">'+
						'<input type="hidden" name="unique_num" value="${ sessionScope.loginMember.uniqueNum}">'+
						'<div class="cmt_ok"><input type="button" id="btn_vreplyInsert" value="등록" onclick="insertSVrLevel(' + vreply_no + ', \'' + nickname + '\', \'' + unique_num + '\')"></div>'+
						'</div>'+
						'</div>'+
						'</fieldset>'+
						'</form>'+
						'<li id="vreply_no'+vreply_no+'">'+
						'</li>'
						
						$('#vreply_no'+vreply_no).html(htmls);
						$('#vreply_no'+vreply_no+'#second_content').focus();
						
						
}

//대댓글내용저장
function insertSVrLevel(vreply_no, nickname, unique_num){
	var secondcontent = $('#second_content').val();
	var paramData = JSON.stringify({"vreply_content" : secondcontent, "vreply_no" : vreply_no, "nickname" : nickname, "unique_num" : unique_num, "volno" : ${ volunteer.volno} });
	var headers = {"Content-Type" : "application/json" , "X-HTTP-Method-Override" : "POST"};
	
	$.ajax({
		url : "vrinsertlevel.do",
		headers : headers,
		data : paramData,
		type : 'POST',
		dataType :'text',
		success : function(result){
			console.log(result);
			alert("댓글이 등록되었습니다.");
			showReplyList(); 
		},
		error : function(jqXHR, textstatus, errorthrown) {
			console.log("error : " + jqXHR + ", " + textstatus
					+ ", " + errorthrown);
		} 
		
	});
}

//댓글삭제기능
function fn_DeleteVreply( vreply_no, nickname ){
	var paramData = { "vreply_no" : vreply_no };
	var user = "${ sessionScope.loginMember.nickname}";
	var result = confirm("삭제하시겠습니까?");
	var nickname = nickname
	if( user == "" )
		alert("로그인 후 이용해주세요.");
	else
		if( user == nickname )
			if(result == true){
		$.ajax({
			url : "vrdelete.do",
			data : paramData,
			type : 'POST',
			dataType :'text',
			success : function(result){
				console.log(result);
				showReplyList();
			},
			error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus
						+ ", " + errorthrown);
			} 
		});
			}else
				return;
		else
			alert("작성자만 이용하실 수 있습니다.");
}


</script> 
            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>