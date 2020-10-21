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
                                <li><a href="main.do">홈</a></li>
                                <li class="xi-angle-right"><a href="cissuelist.do">오늘의 이슈</a></li>
                            </ul>
                        </div>
                        <h2><span>오늘의 이슈</span></h2>
                        <h3>오늘의 이슈를 통해<br/>새로운 정보를 빠르게 찾아보세요.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        
                        <!--상세-->
                        <div class="issueView">
                            <p class="topText">'지금 달려갈 개'의 오늘의 이슈 게시물의 저작권은 1boon 사이트에서 활동하고 있는 원작자에게 있습니다.</p>
                            <dl>
                                <dt>
                                    <div class="viewImg"><img src="${ issue.issueThumbnail }"></div>
                                    <a class="linkBtn" href="${ issue.issueLink }" target="_blank"><i class="xi-share"></i>원글보기</a>
                                    <a class="linkBtn" data-toggle="popover2" data-url="http://192.168.30.34:9392/runningdog/cissuedetail.do?link=${ issue.issueLink }"
                                    data-title="${ issue.issueTitle }" data-image="${ issue.issueThumbnail }"><i class="xi-share-alt-o"></i> 공유하기</a>
                                </dt>
                                <dd>
                                    <div>
                                        <img src="${ issue.partnerImg }">
                                        <h4>${ issue.partnerName }</h4>
                                    </div>
                                    <h2>${ issue.issueTitle }</h2>
                                    <p>조회수 : <fmt:formatNumber value="${ issue.issueReadcount }" groupingUsed="true"/> · ${ issue.issueDate }</p>
                                </dd>
                            </dl>
                            
                            <div class="textCon">
                            ${ issue.content }
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