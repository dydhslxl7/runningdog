<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko" class="animalBg">
<head>
<c:import url="/WEB-INF/views/include/head.jsp" />
<!-- Load the JS SDK asynchronously -->


</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<div id="wrap">
		<!-- 컨텐츠 -->
		<div id="content">
			<!-- 로그인 -->
			<div class="member_wrap">
				<form name="loginFrom" method="post" action="loginAction.do">
					<legend>로그인</legend>
					<div class="login_wrap">
						<h1 onclick="location='/runningdog/'">
							<img src="/runningdog/resources/images/common/logo_over.png"
								alt="logo">
						</h1>
						<div class="loginInfo">
							<div>
								<span><i class="xi-mail-o"></i></span> <span><input type="email" name="userId" title="아이디" id="userIdChk" class="userLoginId w100p" placeholder="아이디(이메일)" maxlength="40" required/></span>
							</div>
							<p id="idWarning">
								<span></span>
							</p>
							<div>
								<span><i class="xi-lock-o"></i></span> <span><input type="password" name="userPwd" title="비밀번호" id="userPwdChk" class="w100p" placeholder="비밀번호" maxlength="40" required/></span>
							</div>
							<p id="pwdWarning">
								<span></span>
							</p>
							<dl>
								<dt>
									<label><input type="checkbox" name="" id="idSaveCheck">이메일 저장</label>
								</dt>
								<dd onclick="location='accountFind.do'">아이디(이메일)/비밀번호 찾기 <i class="xi-angle-right"></i></dd>
							</dl>
							<input class="login_btn" type="submit" name="" value="로그인">
						</div>
						<a href="join.do" class="join_btn">회원가입</a>

						<ul class="snsLogin">
							<li class="kLogin" onclick="javascript:loginWithKakao()"><span><i class="xi-kickstarter"></i></span>카카오 로그인</li>
							<li id="naverIdLogin naver_id_login" class="nLogin" onclick="javascript:naverLogin()"><span><i class="xi-naver"></i></span>네이버 로그인</li>
							<li id="status" scope="public_profile,email" onclick="javascript:facebookLogin();" class="fLogin"><span><i class="xi-facebook"></i></span>페이스북 로그인</li>
            			</ul>
            			<script>
            				function naverLogin(){
            					location.href="${naverAuthUrl}";
            				}
            			</script>
					</div>
				</form>
				
			</div>
			<!-- 로그인 끝 -->
		</div>
		<!-- 컨텐츠 끝 -->
	</div>
</body>

</html>