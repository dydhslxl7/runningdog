<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="../include/admin_header.jsp"/>

        <div id="container">
            <c:import url="../include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>탈퇴회원 관리</h3>
                    <h2>| 상세</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="adminInfo_wrap">
                <h2>탈퇴한 회원정보</h2>
                
                
                <!-- 프로필 -->
				<dl class="profile">
					<dt>
						<div>
							<c:if test="${ selectLeaveUser.leaveRenameProfile eq null }">
							<img src="/runningdog/resources/images/common/userBg.png"/>
							</c:if>
							<c:if test="${ selectLeaveUser.leaveRenameProfile ne null }">
								<c:if test="${ selectLeaveUser.leaveLoginType eq null or selectLeaveUser.leaveLoginType eq 'facebook' }">
								<img src="/runningdog/resources/images/memberImg/${selectLeaveUser.leaveRenameProfile}"/>
								</c:if>
								<c:if test="${ selectLeaveUser.leaveLoginType ne null and selectLeaveUser.leaveLoginType ne 'facebook' }">
								<img src="${selectLeaveUser.leaveRenameProfile}"/>
								</c:if>
							</c:if>
						</div>
					</dt>
					<dd>
						<div><span>회원번호</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leaveUniqueNum}</div>
						<div><span>아이디(이메일)</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leaveUserId}</div>
						<div><span>닉네임</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leaveNickname}</div>
						<div><span>전화번호</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leavePhone}</div>
						<div><span>가입일</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leaveJoinDate}</div>
						<div><span>탈퇴일</span>&nbsp;&nbsp;:&nbsp;&nbsp;${selectLeaveUser.leaveDate}</div>
						<div class="loginType"><span>로그인유형</span>&nbsp;&nbsp;:&nbsp;&nbsp;
							<c:if test="${ selectLeaveUser.leaveLoginType eq 'kakao' }">
							<i class="xi-kakaotalk"></i>
							</c:if>
							<c:if test="${ selectLeaveUser.leaveLoginType eq 'facebook' }">
							<i class="xi-facebook-official"></i>
							</c:if>
							<c:if test="${ selectLeaveUser.leaveLoginType eq 'naver' }">
							<i class="xi-naver-square"></i></td>
							</c:if>
							<c:if test="${ selectLeaveUser.leaveLoginType eq null }">
							일반
							</c:if>
						</div>
					</dd>
				</dl>
				<!-- 프로필 끝 -->
                <div class="write-btn">
                    <input type="button" class="btn btn-list" value="이전으로" onclick="history.go(-1);">
                </div>
            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>