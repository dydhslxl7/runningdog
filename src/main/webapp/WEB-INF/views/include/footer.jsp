<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<button id="topRollBtn"><i class="xi-caret-up"></i><br/>top</button>
<div class="collapse" id="navbarToggleExternalContent">
    <ul>
        <li><a href="/runningdog/"><i class="xi-home-o"></i> 홈으로</a></li>
        <li><a href="/WEB-INF/views/animal/animalList.jsp">유기동물정보</a></li>
        <li><a href="/WEB-INF/views/animal/chooseList.jsp">유기동물분양</a></li>
        <li><a href="/WEB-INF/views/protect/protectList.jsp">보호센터정보</a></li>
    </ul>
</div>
<div id="fmobileMenu">
	<c:if test="${ !empty sessionScope.loginMember}">
    <ul class="fmypage_menu">
		<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk eq 'Y' }">
        <li><a href="memberAllList.ad">관리자페이지</a></li>
        <li><a href="logout.do">로그아웃</a></li>
	    </c:if>
		<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk ne 'Y' }">
        <li><a href="mypage.do?userId=${loginMember.userId}">나의 프로필</a></li>
        <li><a href="vlistmy.do?unique_num=${loginMember.uniqueNum}">나의 자원봉사</a></li>
        <li><a href="moveChatting.do">나의 채팅</a></li>
        <li><a href="logout.do">로그아웃</a></li>
	    </c:if>
    </ul>
    </c:if>
    <a href="/runningdog/"><i class="xi-home-o"></i><br/>홈으로</a>
    <a href="#none" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="true" aria-label="Toggle navigation"><i class="xi-align-justify"></i><br/>카테고리</a>
    <a href="slist.do"><i class="xi-piggy-bank"></i><br/>후원하기</a>
    <a href="moveChatting.do"><i class="xi-message-o"></i><br/>나의채팅 <span id="unread"></span></a>
	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk eq 'Y' }">
    <a href="#none" class="mypageBtn"><i class="xi-user-plus-o"></i><br/>관리자</a>
	</c:if>
	<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk ne 'Y' }">
    <a href="#none" class="mypageBtn"><i class="xi-user-plus-o"></i><br/>마이페이지</a>
    </c:if>
    <c:if test="${ empty sessionScope.loginMember }">
    <a href="login.do?userId=${loginMember.userId}"><i class="xi-user-o"></i><br/>로그인</a>
    </c:if>
</div>
<div id="footer">
    <dl>
        <dt>
            <a href="terms.do">이용약관</a>
            <a href="privacy.do">개인정보처리방침</a>
            <a href="email.do">이메일무단수집거부</a>
        </dt>
        <dd>
        	지금 달려갈 개 | 서울특별시 중구 남대문로 120 대일빌딩 2F, 3F | 대표자 : 공유 | 개인정보 담당자 : 강동원 | 고객센터 : 1577-7777<br/>
            <span>Copyright 2020. 지금 달려갈 개. All Rights Reserved</span>
        </dd>
    </dl>
</div>
<script>
    $(".chattingController > div, .fmypage_menu").hide();
    $(".chattingController > button").click(function(){
        $(".chattingController > div").toggle(200);
        $(".chattingController > div").click(function(){
            $(".chattingController > div").hide();
        });
    });
    $("#fmobileMenu .mypageBtn").click(function(){
        $("#fmobileMenu .mypageBtn").toggleClass("on")
        $(".fmypage_menu").toggle(200);
        $(".fmypage_menu").click(function(){
            $(".fmypage_menu").hide();
        });
    });
</script>
<script type="text/javascript">
function updateTotalUnread() {
	var myChatList = ${sessionScope.myChatList};
	console.log(myChatList);
	$.ajax({
		url: "totalUnread.do",
		type: "get",
		dataType: "json",
		success: function(data) {
			console.log("success : " + data);
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			var values = "";
			if (json.count > 0) {
				values = "+" + json.count; 
			}

			$("#unread").html(values);
		},
		error : function(jqXHR, textstatus, errorthrown) {
			console.log("error : " + jqXHR + ", " + textstatus + ", "
					+ errorthrown);
		},
		complete: function() {
            setTimeout(updateTotalUnread, 30000);
	    }
	});
};
setTimeout(updateTotalUnread, 1000);
</script>
