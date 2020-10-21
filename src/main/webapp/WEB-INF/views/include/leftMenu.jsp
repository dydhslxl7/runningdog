<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="leftMenu_wrap">
    <div class="leftProfile">
        <div>
			<c:if test="${ loginMember.loginType ne 'kakao' }">
	        <c:if test="${ sessionScope.loginMember.renameProfile eq null }">
	        <img src="/runningdog/resources/images/common/userBg.png">
	        </c:if>        
	        <c:if test="${ sessionScope.loginMember.renameProfile ne null }">
	        <img src="/runningdog/resources/images/memberImg/${sessionScope.loginMember.renameProfile}"/>
	        </c:if>
	        </c:if>
											
			<c:if test="${ sessionScope.loginMember.loginType eq 'kakao' }">
			<img src="${sessionScope.loginMember.renameProfile}">
			</c:if>
        </div>
        <c:if test="${ !empty sessionScope.loginMember}">
        <h3>${sessionScope.loginMember.nickname} 님 </h3>
        <ul>
            <li>회원번호<b> #${sessionScope.loginMember.uniqueNum}</b></li>
            <li><button type="button" onclick="location.href='logout.do'">로그아웃</button></li>
        </ul>
        </c:if>
        <c:if test="${ empty sessionScope.loginMember}">
        <h3>로그인이 필요합니다.</h3>
        <ul>
            <li>회원번호<b> #000</b></li>
            <li><button type="button" onclick="location.href='login.do'">로그인</button></li>
        </ul>
        </c:if>
    </div>
    <ul class="leftGnb">
	   	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk eq 'Y'  }">
	        <li><a href="memberAllList.ad">관리자페이지</a></li>
	       </c:if>
	   	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk ne 'Y' }">
	        <li><a href="mypage.do?userId=${loginMember.userId}">나의 프로필</a></li>
	        <li><a href="vlistmy.do?unique_num=${loginMember.uniqueNum}">나의 자원봉사</a></li>
	        <li><a href="moveChatting.do">나의 채팅</a></li>
	   	</c:if>
    </ul>

    <ul class="leftBanner">
        <li onclick="location='slist.do'">
            <h2><i class="xi-piggy-bank"></i> 후원 참여하기</h2>
            <p>
                함께하는 여러분의 따뜻한 손길이 모여 큰 힘이 됩니다.<br>
            </p>
        </li>
        <li onclick="location='nlist.do'">
            <h2><i class="xi-bell-o"></i> 공지사항 확인</i></h2>
            <p>'지금 달려갈 개'의 공지사항을 꼭 확인해주세요.<br>&nbsp;</p>
        </li>
    </ul>
</div>