<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
        <link href="/runningdog/resources/common/css/about.css" rel="stylesheet"> <!-- about.css 연결 -->
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
                                <li class="glyphicon glyphicon-menu-right"><a href="#none">사이트 소개</a></li>
                            </ul>
                        </div>
                        <h2><span>사이트 소개</span></h2>
                        <h3>'지금 달려갈 개'의 소개페이지 입니다.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                    	<div class="aboutContainer">
		                    <br><br>
		                    <!-- 사이트 소개 -->
		                    <div class="subContainer">
			                    <div id="siteIntroduction"><h1><span>'지금 달려갈 개'</span>란?</h1><br>
			                    <h3>유기된 동물, 도움이 필요한 동물들에게 새로운 가족을 빠른 시간 내에 찾아 주고 싶다는 의미로 홈페이지를 만들게 되었습니다.</h3></div>
			                    <div id="runningdogImg"><img src="/runningdog/resources/images/about/runningdog.png" alt="달려가는 강아지"></div>
			                    <br><br>
		                    </div>
		                    
	                    	<!-- 기획의도 이미지들 -->
	                    	<div class="aboutImage1"><img src="/runningdog/resources/images/about/Intention_1.png" alt="기획의도1"></div>
	                       	<div class="aboutImage2"><img src="/runningdog/resources/images/about/Intention_2.png" alt="기획의도2"></div>
	                       	
	                       	<!-- 서비스들 -->
	                       	<div class="aboutFunctions">
	                       		<h2>지금 달려갈 개의<br/><span>'서비스들'</span>을 만나보세요</h2>
		                       	<ul>
			                       	<li onclick="location='dboardList.do'">
			                       		<div>
			                       			<img src="/runningdog/resources/images/about/animal_match.png" alt="유기동물 매칭 아이콘">
			                       		</div>
			          					<h3>유기동물 주인찾기</h3>
			          					<p>가족을 기다리는 작은 천사들에게 가족과 친구가 되어주세요.</p>
			          				</li>
			          				
			          				<li onclick="location='animalList.do'">
			          					<div>
			                       			<img src="/runningdog/resources/images/about/animal_information.png" alt="유기동물 정보 아이콘">
			                       		</div>
			          					<h3>유기동물 정보</h3>
			          					<p>현재 유기된 동물들의 정보를 확인할 수 있습니다. 해당 동물의 정보에 관심가지고 귀 기울여 주세요.</p>
			          				</li>
			          				
			          				<li onclick="location='movePlist.do'">
			          					<div>
			                       			<img src="/runningdog/resources/images/about/protect.png" alt="보호시설 아이콘">
			                       		</div>
			          					<h3>보호센터 정보</h3>
			          					<p>보호센터 정보을 제공하고 있습니다.자신이 사는 위치에 도움이 필요한 보호소가 있는지 확인해보세요.</p>
			          				</li>
			          				
			          				<li onclick="location='vlist.do'">	
			          					<div>
			                       			<img src="/runningdog/resources/images/about/service.png" alt="자원봉사 아이콘">
			                       		</div>
			          					<h3>자원봉사</h3>
			          					<p>도움이 필요한 작은 천사들이 많습니다. 따뜻한 손길을 전해주세요.</p>
			          				</li>
			          				
			          				<li onclick="location='slist.do'">	
			          					<div>
			                       			<img src="/runningdog/resources/images/about/sponsor.png" alt="후원 아이콘">
			                       		</div>
			          					<h3>후원</h3>
			          					<p>작은 도움이 모아 큰 도움이 됩니다. 작은 생명에게 새 삶을 찾아주세요.</p>
			          				</li>
			          				
			          				<li onclick="location='#none'">	
			          					<div>
			                       			<img src="/runningdog/resources/images/about/chat.png" alt="채팅 아이콘">
			                       		</div>
			          					<h3>채팅</h3>
			          					<p>나와 같은 생각을 하고있는 회원이 보인다면 연락해보세요.실시간 채팅을 제공합니다.</p>
			          				</li>
			          				
			          				<li onclick="location='cknowlist.do'">
			          					<div>
			                       			<img src="/runningdog/resources/images/about/contents.png" alt="콘텐츠 아이콘">
			                       		</div>
			          					<h3>콘텐츠</h3>
			          					<p>작은천사를에 있어 알아두면 좋은 상식들과 오늘의 이슈들을 통해 새로운 정보를 빠르게 찾아보세요.</p>
			          				</li>
			          				
									<li onclick="location='nlist.do'">
										<div>
			                       			<img src="/runningdog/resources/images/about/notice.png" alt="공지사항 아이콘">
			                       		</div>
			          					<h3>공지사항</h3>
			          					<p>'지금 달려갈 개'의 공지사항을 꼭 확인해주세요.</p>
			          				</li>
		                     	</ul>  
		                      	<br><br>		          				
		               		</div>
		                <!-- 서비스들 끝 -->
	                	</div> 
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>