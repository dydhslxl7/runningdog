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
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 로그인 -->
                <div class="member_wrap">
                    <div class="login_wrap">
                        <form name="pwdChange" method="post" action="/WEB-INF/">
                        <legend>비밀번호 변경</legend>
                        <h1 onclick="location='/WEB-INF/'"><img src="/runningdog/resources/images/common/logo_over.png" alt="logo"></h1>
                        <div class="loginInfo">
                            <h4>비밀번호 변경</h4>
                            <div>
                                <span><i class="xi-lock-o"></i></span>
                                <span><input type="password" name="" title="신규 비밀번호" class="w100p" placeholder="신규 비밀번호" maxlength="40" required/></span>
                            </div>
                            <div>
                                <span><i class="xi-lock"></i></span>
                                <span><input type="password" name="" title="신규 비밀번호 확인" class="w100p" placeholder="신규 비밀번호 확인" maxlength="40" required/></span>
                            </div>
                            <p>
                                <span>비밀번호를 입력해주세요.</span>
                                <span>신규 비밀번호가 동일하지 않습니다.</span>
                            </p>
                            <input class="pwdChange_btn" type="submit" name="" value="비밀번호 변경완료">
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