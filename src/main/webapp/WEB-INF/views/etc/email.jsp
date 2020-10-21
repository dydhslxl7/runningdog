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
            <c:import url="/WEB-INF/views/include/header.jsp"/>
			<!-- 컨텐츠 -->
			<div id="content">
			    <!--서브 비주얼/타이틀-->
                <div class="visual-sub-vagas animal-vagas">
                <div class="vsv-copy sub-title">
                   <div>
                        <ul class="navi">
                            <li><a href="#none">홈</a></li>
                            <li class="xi-angle-right"><a href="#none">이메일무단수집거부</a></li>
                        </ul>
                    </div>
                    <h2><span>이메일무단수집거부</span></h2>
                    <h3>이메일무단수집거부입니다.</h3>
                </div>
            </div>
            <!--서브 비주얼/타이틀 끝-->

            <!-- 이메일무단수집거부 -->
            <div class="terms">
                <div>
                    <h1>E-Mail주소 무단수집거부</h1>
                    <p>
                        <i class="xi-mail-read-o"></i>&nbsp;&nbsp;&nbsp;본 홈페이지에 게시된 이메일 주소가 전자우편 수집프로 그램이나 그 밖의 기술적인 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반시 정보통신망법에 의해 형사처벌됨을 유념하시기 바랍니다. <br />
                        [게시일 2020년 10월 16일]
                    </p>
                 </div>
            </div>
            <!-- 이메일무단수집거부 끝 -->
        </div>
        <!-- 컨텐츠 끝 -->

        <c:import url="/WEB-INF/views/include/footer.jsp"/>
    </div>
</body>
</html>