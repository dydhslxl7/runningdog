<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="header">
    <!-- 상단메뉴 -->
    <div class="util_wrap">
        <div>
	        
	        <script src="/runningdog/resources/common/js/jquery.vticker.min.js"></script>  
	        <script type="text/javascript">
	        /* 공지사항 알림표시, 최신에 올라온거 출력 ajax */
 	        $(function() {
	        	$.ajax({
	        		url : "nstate.do",
	        		type : "post",
	        		dataType : "json",
	        		success : function(data){
	        			console.log("headerNoticeList success : " + data)
	        			var jsonStr = JSON.stringify(data);
	        			var json = JSON.parse(jsonStr);
	        			
	        			var values = "";
	        			for(var i in json.list) {
	        				values += '<li onclick="moveNoticeDetail(' + json.list[i].no + ');">' + 
	        					'<i class="xi-lightbulb-o"></i><span>[' + decodeURIComponent(json.list[i].state) + ']</span>' + 
	        					decodeURIComponent(json.list[i].title).replace(/\+/gi, " ") + '</li>';
	        			}
	        			$(".sosBell").html(values);
	        			
	        			/* 롤러처리 */
	        		    $('#roll_list').vTicker('init', {
	        		    	speed: 1300, 
	        		        pause: 3000,
	        		        showItems: 1
	        		     });
	        			
	        		},
	        		error : function(jqXHR, textstatus, errorthrown) {
	        			console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	        		}
	        	});
	        }); 
	        
 	        	/* 공지사항 상세페이지 이동 */
			function moveNoticeDetail(noticeNo){
				location.href = "ndetail.do?noticeNo=" + noticeNo;
			}
	       		
	        </script> 
	        
	        <!-- 공지사항 알림, 최신 출력 -->
	        <div class="notice_roll" id="roll_list">
	            <ul class="sosBell">
	            </ul>
	        </div>
            
            
            <ul class="util">
            	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk eq 'Y' }">
                <li><a class="hover_line01" href="memberAllList.ad">관리자페이지</a></li>
                <li><a class="hover_line01" href="logout.do">로그아웃</a></li>
                </c:if>
            	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk ne 'Y' }">
                <li><a class="hover_line01" href="mypage.do?userId=${loginMember.userId}">마이페이지</a></li>
                <c:if test="${ sessionScope.loginMember.loginType ne 'kakao' }">
                <li><a class="hover_line01" href="logout.do">로그아웃</a></li>
                </c:if>
                <c:if test="${ sessionScope.loginMember.loginType eq 'kakao' }">
                <li onclick="unlinkApp()"><a class="hover_line01" href="#none">로그아웃</a></li>
                </c:if>
            	</c:if>
            	<c:if test="${ empty sessionScope.loginMember }">
                <li><a class="hover_line01" href="login.do">로그인</a></li>
                <li><a class="hover_line01" href="join.do">회원가입</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="gnbWrap clearfix">
        <h1 onclick="location='/runningdog/'" title="지금 달려갈 개"></h1>
        <ul class="gnb clearfix">
            <li class="menuBtn"><a href="#none">전체</a></li>
            <li>
                <a href="animalList.do">유기동물정보</a>
                <div class="dep2Wrap">
                    <ul class="dep2">
                        <li><a href="animalList.do">유기동물정보</a></li>
                        <li><a href="dboardList.do">유기동물 주인찾기</a></li>
                    </ul>
                </div>
            
            </li>
            <li>
                <a href="/runningdog/movePlist.do">보호센터 정보</a>
                <div class="dep2Wrap">
                    <ul class="dep2">
                        <li><a href="/runningdog/movePlist.do">보호센터정보</a></li>
                        <li><a href="/runningdog/vlist.do">자원봉사모집</a></li>
                    </ul>
                </div>
            </li>
            <li>
                <a href="slist.do">후원하기</a>
            </li>
            <li>
                <a href="cknowlist.do">상식/이슈</a>
                <div class="dep2Wrap">
                    <ul class="dep2">
                        <li><a href="cknowlist.do">반려동물상식</a></li>
                        <li><a href="cissuelist.do">오늘의 이슈</a></li>
                    </ul>
                </div>
            </li>
           <li><a href="nlist.do">공지사항</a></li>
        </ul>
    </div>
    <!-- //상단메뉴 -->
    
    <!-- 전체메뉴 -->
    <div class="menuAll">
        <ul>
        	<li>
                <div><a href="#none">전체카테고리</a></div>
                <ul class="depth2">
                    <li><a href="aboutView.do">사이트소개</a></li>
                    <li><a href="animalList.do">유기동물정보</a></li>
                    <li><a href="dboardList.do">유기동물 주인찾기</a></li>
                    <li><a href="movePlist.do">보호센터정보</a></li>
                    <li><a href="vlist.do">자원봉사모집</a></li>
                    <li><a href="nlist.do">공지사항</a></li>
                </ul>
            </li>
            <li>
                <div><a href="slist.do">후원하기</a></div>
                <ul class="depth2">
                    <a href="slist.do">후원하기</a>
                </ul>
            </li>
            <li>
                <div><a href="#none">콘텐츠</a></div>
                <ul class="depth2">
                    <li><a href="cknowlist.do">반려동물상식</a></li>
                    <li><a href="cissuelist.do">오늘의 이슈</a></li>
                </ul>
            </li>
            <li>
                <div><a href="#none">멤버</a></div>
                <ul class="depth2">
                    <li><a href="login.do">로그인</a></li>
                    <li><a href="join.do">회원가입</a></li>
                    <li><a href="mypage.do?userId=${loginMember.userId}">나의 프로필</a></li>
                    <li><a href="vlistmy.do?unique_num=${loginMember.uniqueNum}">나의 자원봉사</a></li>
                    <li><a href="moveChatting.do">나의 채팅</a></li>
                </ul>
            </li>
            <li class="menuAll_close xi-close-square"></li>
        </ul>
    </div>
    <!-- //전체메뉴 -->
</div>
<div id="mHeader">
    <dl>
        <dt><button class="xi-backspace" onclick="javascript:history.back();"></button></dt>
        <dd><h1 onclick="location='/runningdog/'"></h1></dd>
        <dt>
            <button class="xi-align-justify collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="true" aria-label="Toggle navigation"></button>
        </dt>
    </dl>
    <ul class="mHeader_menu collapse" id="navbarSupportedContent">
        <li><a href="main.do"><i class="xi-home-o"></i> 홈으로</a></li>
        <li><a href="animalList.do">유기동물정보</a></li>
        <li><a href="dboardList.do">유기동물 주인찾기</a></li>
        <li><a href="movePlist.do">보호센터정보</a></li>
        <li><a href="vlist.do">자원봉사모집</a></li>
        <li><a href="slist.do">후원하기</a></li>
        <li><a href="cknowlist.do">반려동물상식</a></li>
        <li><a href="cissuelist.do">오늘의 이슈</a></li>
        <li><a href="moveChatting.do">나의 채팅</a></li>
        <li><a href="nlist.do">공지사항</a></li>
        <li><a href="aboutView.do">사이트소개</a></li>
    </ul>
</div>