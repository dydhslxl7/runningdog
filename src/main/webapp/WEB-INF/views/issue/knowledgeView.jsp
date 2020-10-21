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
                                <li class="xi-angle-right"><a href="#none">반려동물 상식</a></li>
                            </ul>
                        </div>
                        <h2><span>반려동물 상식</span></h2>
                        <h3>작은 천사들에게 필요한<br/>정보를 알기 쉽게 알려드려요.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">

                    <!-- 상세 -->
                    <div class="view-area">
                        <h3><span>상식</span></h3>
                        <h2>${ title }</h2>
                        <ul>
                            <li><span>작성자 : </span>유기견센터</li>
                            <!-- <li><span>등록일 : </span>2020.08.28</li> -->
                            <li><span>조회수 : </span>${ readcount }</li>
                        </ul>

                        <div class="view-ctn" >
                  
                        <pre style="background-color: rgba(255, 0, 0, 0);"><c:out value="${ content }"/></pre>
                        
                        </div>
                    </div>
                    <!-- 상세 끝 -->
                    
                    <!-- 버튼 -->
                    <div class="viewBtn-wrap">
                        <!-- <button class="nextBtn"><i class="xi-angle-left-min"></i> 이전</button> -->
                        <button class="listBtn" onclick="javascript:history.back();"><i class="xi-rotate-left"></i> 목록</button>
                        <!-- <button class="prevBtn">다음 <i class="xi-angle-right-min"></i></button> -->
                    </div>
                    <!-- 버튼 끝 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->
            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>