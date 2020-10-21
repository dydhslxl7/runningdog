<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" class="animalBg">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
        <script>
            $(function(){
                $(".privacyCke a.con1").click(function(){
                    $(".privacyCke_con textarea.con2").removeClass('on');
                    $(".privacyCke_con textarea.con1").toggleClass('on');
                });
                $(".privacyCke a.con2").click(function(){
                    $(".privacyCke_con textarea.con1").removeClass('on');
                    $(".privacyCke_con textarea.con2").toggleClass('on');
                });
            });
        </script>
	</head>
	<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
		<div id="wrap">
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 로그인 -->
                <div class="member_wrap">
                    <form method="post" id="joinForm" name="joinAction" enctype="multipart/form-data">
                    <legend>회원가입</legend>
                    <div class="login_wrap">
                        <h1 onclick="location='/runningdog/'"><img src="/runningdog/resources/images/common/logo_over.png" alt="logo"></h1>
                        <div class="loginInfo">
                            <div>
                                <span><i class="xi-mail-o"></i></span>
                                <span><input type="email" name="userId" title="아이디(이메일)" id="userIdChk" class="w100p" placeholder="아이디(이메일)" maxlength="40"/></span>
                            </div>
                            <p id="idWarning">
                                <span></span>
                            </p>
                            <div>
                                <span><i class="xi-lock-o"></i></span>
                                <span><input type="password" name="userPwd" title="비밀번호" id="userPwdChk" class="w100p" placeholder="비밀번호" maxlength="40"/></span>
                            </div>
                            <div>
                                <span><i class="xi-lock"></i></span>
                                <span><input type="password" name="userPwd2" title="비밀번호 확인" id="userPwdChk2" class="w100p" placeholder="비밀번호 확인" maxlength="40"/></span>
                            </div>
                            <p id="pwdWarning">
                                <span>사용하실 비밀번호는 특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.</span>
                            </p>
                            <div>
                                <span><i class="xi-profile-o"></i></span>
                                <span>
	                                <input type="file" name="profilImage" title="프로필 사진" class="w100p"/>
                                </span>
                            </div>
                            <div>
                                <span><i class="xi-user-o"></i></span>
                                <span><input type="text" name="nickname" title="닉네임" id="nicknameChk" class="w100p" placeholder="닉네임" maxlength="40"/></span>
                            </div>
                            <p id="nicknameWarning">
                                <span></span>
                            </p>
                            <div>
                                <span><i class="xi-call"></i></span>
                                <span><input type="tel" name="phone" title="휴대폰번호" id="phoneChk" class="w100p" placeholder="휴대폰번호('-'포함 입력)" maxlength="40"/></span>
                            </div>
                            <p id="phoneWarning">
                                <span></span>
                            </p>
                            <p class="privacyCke" style="margin:1.25rem 0;">
                                <label><input type="checkbox" name="" id="chkY"/> 서비스의 <a href="#none" class="con1">이용약관</a>과 <a href="#none" class="con2">개인정보처리방침</a>에 동의합니다.</label>
                            </p>

                            <input id="joinAction" class="joinAction join_btn" type="button" name="" value="회원가입">
                        </div>
                        <div class="privacyCke_con">
                            <c:import url="/WEB-INF/views/include/termsCon.jsp"/>
                            <c:import url="/WEB-INF/views/include/privacyCon.jsp"/>
                        </div>
                    </div>
				    </form>
                </div>
				<!-- 로그인 끝 -->
			</div>
			<!-- 컨텐츠 끝 -->
		</div>
	</body>
</html>