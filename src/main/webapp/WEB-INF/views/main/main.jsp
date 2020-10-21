<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
        <script src="resources/common/js/issueShare.js"></script>
        <script type="text/javascript">

        $(function() {

        	$.ajax({
        		url : "dboardNew4.do",
        		type : "post",
        		dataType : "json",
        		success : function(data) {
        			console.log("success : " + data);
        			// object ==> string으로 변환
        			var jsonStr = JSON.stringify(data);
        			// string ==> json 객채로 바꿈
        			var json = JSON.parse(jsonStr);
        			var values = "";
        			for ( var i in json.list) {
        				values += '<li onclick="location='+ "'dboardView.do?dNum="+json.list[i].dNum +"'" + '">'
                        	   +'<div><img src="/runningdog/resources/dboard/dboardImage/'+json.list[i].listImage+'">'
                        	   +'</div><h3>' + decodeURIComponent(json.list[i].dTitle).replace(/\+/gi, " ") +'</h3><p>임시보호자 :'
                        	   + decodeURIComponent(json.list[i].dWriter).replace(/\+/gi, " ") +'<br/>'
                        	   +'발견날짜 : '+ json.list[i].dFindDate +'<br/>'
                        	   +'발견지역 :'+ decodeURIComponent(json.list[i].dFindLocal).replace(/\+/gi, " ")
                        	   +'<span>등록일 :'+json.list[i].dDate +'</span></p></li>'
        						
        					} // for in

        					$("#dtoplist").html($("#dtoplist").html() + values);
        				},
        				error : function(jqXHR, textstatus, errorthrown) {
        					console.log("error : " + jqXHR + ", " + textstatus + ", "
        							+ errorthrown);
        				}
        			});
        });
      	//공백만 입력하고 검색할 때
        $(function(){
        	$("#dsub").on("click", function(){
        	var keyword = $.trim($("input[name=searchValue]").val());
        		if(keyword == "") {
        			alert("내용을 입력해주세요.");
        			return false;
        		}
        	});
        });
        </script>
	</head>
	<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
		<div id="wrap">
            <c:import url="/WEB-INF/views/include/header.jsp"/>

            <!-- 비주얼영역 -->
            <!-- Swiper -->
            <div id="main_visual" class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide first">
                        <div class="main_visual">
                            <h2>가족이 되어주세요.</h2>
                            <p>매년 수많은 반려동물이 유기되어 가족을 잃은<br/>슬픔을 안고 보호센터에서 살아가고 있어요.</p>
                            <a href="dboardList.do" role="button">자세히보기<i class="xi-long-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="swiper-slide middle">
                        <div class="main_visual">
                            <h2>가족이 되어주세요.</h2>
                            <p>매년 수많은 반려동물이 유기되어 가족을 잃은<br/>슬픔을 안고 보호센터에서 살아가고 있어요.</p>
                            <a href="dboardList.do" role="button">자세히보기<i class="xi-long-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="swiper-slide last">
                        <div class="main_visual">
                            <h2>가족이 되어주세요.</h2>
                            <p>매년 수많은 반려동물이 유기되어 가족을 잃은<br/>슬픔을 안고 보호센터에서 살아가고 있어요.</p>
                            <a href="dboardList.do" role="button">자세히보기<i class="xi-long-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <!-- Add Arrows -->
                <div class="swiper-button-next xi-angle-right"></div>
                <div class="swiper-button-prev xi-angle-left"></div>
                <script>
                    var swiper = new Swiper('.swiper-container', {
                        loop: true,
                        autoplay: {
                            delay: 2500,
                            disableOnInteraction: false,
                        },
                        pagination: {
                            el: '.swiper-pagination',
                            type: 'progressbar',
                        },
                        navigation: {
                            nextEl: '.swiper-button-next',
                            prevEl: '.swiper-button-prev',
                        },
                    });
                </script>
            </div>
			<!-- 비주얼영역 끝 -->
            
            <div id="main_content">
                <div class="search_wrap">
                    <form action="dboardList.do" name="">
                    <div class="search-box">
                        <input type="text" name="searchValue" placeholder="작은 천사들을 검색해주세요.">
                        <input type="hidden" name="searchFiled" value="d_title"/>
                        <button id="dsub" type="submit" class="xi-search"></button>
                    </div>
                </form>
                </div>
                
                <div class="main_animalInfo">
                    <h2><span>'작은 생명'</span>의 소중한 친구가<br/>될 수 있는 <span>'작은 실천'</span></h2>
                    <ul id="dtoplist">

                    </ul>
                </div>

                <div class="main_banner">
                    <ul>
                        <li onclick="location.href='movePlist.do'">
                            <a href="movePlist.do" class="xi-plus-circle-o"></a>
                            <h2>보호센터 정보 <i class="xi-maker-drop"></i></h2>
                            <p>필요한 편의시설의 정보를 한눈에!</p>
                        </li>
                        <li onclick="location.href='slist.do'">
                            <a href="#none" class="xi-plus-circle-o"></a>
                            <h2>후원하기 <i class="xi-piggy-bank"></i></h2>
                            <p>작은 천사에게 용품을 후원해 주세요!</p>
                        </li>
                    </ul>
                </div>

		        
		        <!-- 오늘의 이슈 최신순 리스트 출력 -->
                <div class="main_animalNews">
                    <h2><span>'나의 작은 천사'</span>천사와<br/>함께보는 오늘의 이슈!</h2>
                    <ul class="grid" id="mainIssueList">
                        <li class="grid-sizer"></li>
                        <c:forEach items="${ requestScope.issuelist }" var="c">
                        <li class="grid-item" onclick="moveIssueDetail(`${c.issueLink}`)">
                            <div>
                                <a class="xi-share-alt-o" onclick="event.cancelBubble=true" data-toggle="popover2" 
                                data-url="http://192.168.30.34:9392/runningdog/cissuedetail.do?link=${ c.issueLink }"
                                data-title="${ c.issueTitle }" data-image="${ c.issueThumbnail }"></a>
                                <img src="${ c.issueThumbnail }">
                            </div>
                            <dl>
                                <dt><img src="${ c.partnerImg }"></dt>
                                <dd>
                                    <h3>${ c.issueTitle }</h3>
                                    <p>
                                        작성자 : ${ c.partnerName }<br/>
                                        작성일 : ${ c.issueDate }
                                    </p>
                                </dd>
                            </dl>
                        </li>
                        </c:forEach>
                    </ul>
                </div>


                <div class="main_banner2">
                    <ul>
                        <li onclick="location.href='vlist.do'">
                            <a href="vlist.do" class="xi-plus-circle-o"></a>
                            <h2>자원봉사모집 <i class="xi-note-o"></i></h2>
                            <p>
                                함께하는 여러분의 따뜻한<br/>손길이 모여 큰 힘이 됩니다.
                            </p>
                        </li>
                        <li onclick="location.href='cknowlist.do'">
                            <a href="cknowlist.do" class="xi-plus-circle-o"></a>
                            <h2>상식/이슈 <i class="xi-message-o"></i></h2>
                            <p>사랑스러운 반려동물의<br/>유용한 소식을 알려드립니다.</p>
                        </li>
                        <li onclick="location.href='nlist.do'">
                            <a href="nlist.do" class="xi-plus-circle-o"></a>
                            <h2>공지사항 <i class="xi-bell-o"></i></h2>
                            <p>'지금 달려갈 개'의<br/>공지사항을 꼭 확인해주세요.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
	
	<!-- 오늘의 이슈 ajax -->
 	<script> 	
	$(function(){
		$.ajax({
			url : "mainIssueList.do",
		    type : "post",
		    dataType : "json",
		    success : function(data) {
		    	console.log("mainIssueList success : " + data)
		        var jsonStr = JSON.stringify(data);
		        var json = JSON.parse(jsonStr);
		        			 
		        var values = "";
		        for( var i in json.list) {
		        	values +=  '<li class="grid-item" onclick=moveIssueDetail("'+ json.list[i].link +'");>'
		        		+ '<div><a class="xi-share-alt-o" onclick="event.cancelBubble=true" data-toggle="popover2" data-link="http://192.168.130.170:9392/runningdog/cissuedetail.do?link=' + json.list[i].link + '" data-title="' + decodeURIComponent(json.list[i].title) + '" data-image="' + json.list[i].thumbnail + '"></a>' 
		        	    + '<img src="' + json.list[i].thumbnail + '"></div>'
		        	    + '<dl><dt><img src="' + json.list[i].partnerImg + '"></dt>'
		                + '<dd><h3>' + decodeURIComponent(json.list[i].title) + '</h3>'
		                + '<p>'
		                + '작성자 : ' + decodeURIComponent(json.list[i].partnerName) + '<br/>'
		                + '작성일 : ' + json.list[i].date  
		                + '</p></dd></dl></li>';
		        				 
		        }
		        
		        $("#mainIssueList").html(values);
		        
			},
		 	error: function(jqXHR, textstatus, errorthrown) {
		 		console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
		 	}
		}); //ajax
		        	 
	}); //document.ready 
	</script> 
</html>