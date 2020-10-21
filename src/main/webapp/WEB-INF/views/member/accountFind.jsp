<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" class="animalBg">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
	</head>
	<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
		<div id="wrap">
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 로그인 -->
                <div class="member_wrap">
                    <div class="login_wrap">
                        <form name="idFind" method="post" id="idFind">
                        <legend>아이디(이메일) 찾기</legend>
                        <h1 onclick="location='/runningdog/'"><img src="/runningdog/resources/images/common/logo_over.png" alt="logo"></h1>
                        <div class="loginInfo">
                            <h4>아이디(이메일) 찾기</h4>
                            <div>
                                <span><i class="xi-call"></i></span>
                                <span><input type="tel" name="phone" title="휴대폰번호" id="phoneChk" class="w100p" placeholder="휴대폰번호('-'포함 입력)" maxlength="40" required/></span>
                            </div>
                            <p id="phoneWarning">
                                <span></span>
                            </p>
                            <input class="find_btn idFindBtn" type="button" name="" value="아이디(이메일) 찾기" maxlength="40">
                        </div>
                        </form>
                        <hr/>
                        <form name="pwdFind" method="post" id="pwdFind">
                        <legend>비밀번호 찾기</legend>
                        <div class="loginInfo">
                            <h4>비밀번호 찾기</h4>
                            <div>
                                <span><i class="xi-mail-o"></i></span>
                                <span><input type="email" name="userId" title="아이디(이메일)" id="userIdChk" class="w100p" placeholder="아이디(이메일)" maxlength="40" required/></span>
                            </div>
                            <p id="idWarning">
                                <span></span>
                            </p>
                            <div>
                                <span><i class="xi-call"></i></span>
                                <span><input type="tel" name="phone" title="휴대폰번호" id="phoneChk2" class="w100p" placeholder="휴대폰번호('-'포함 입력)" maxlength="40" required/></span>
                            </div>
                            <p id="phoneWarning2">
                                <span></span>
                            </p>
                            <p id="userIdPhoneWarning">
                                <span></span>
                            </p>
                            <input type="hidden" name="userPwd" title="비밀번호" id="userPwdChk" class="w100p" placeholder="비밀번호" maxlength="40"/>
                            <input class="find_btn pwdFindBtn" type="button" name="" value="비밀번호 찾기">
                        </div>
                        <div id="pwdFindView" class="pwdFindView">
                        	<p>회원님의 이메일로 임시 비밀번호가 전송되었습니다.<br/>이메일을 받지 못하셨다면 스팸함을 꼭 확인해보세요.</p>
                        	<a href="login.do">로그인</a>
                        </div>
                        </form>
                    </div>
                </div>
				<!-- 로그인 끝 -->
			</div>
			<!-- 컨텐츠 끝 -->
		</div>
	</body>
</html>