<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:import url="/WEB-INF/views/include/head.jsp" />
</head>
<body oncontextmenu="return false" onselectstart="return false"
	ondragstart="return false">
	<div id="wrap">
		<c:import url="/WEB-INF/views/include/header.jsp" />
		<!-- 컨텐츠 -->
		<div id="content">
			<!--서브 비주얼/타이틀-->
			<div class="visual-sub-vagas animal-vagas">
				<div class="vsv-copy sub-title">
					<div>
						<ul class="navi">
							<li><a href="main.do">홈</a></li>
							<li class="xi-angle-right"><a href="moveChatting.do">나의
									채팅</a></li>
						</ul>
					</div>
					<h2>
						<span>나의 채팅</span>
					</h2>
					<h3>
						나의 채팅 목록을 한눈에<br />확인하실 수 있습니다.
					</h3>
				</div>
			</div>
			<!--서브 비주얼/타이틀 끝-->

			<div class="subContent_wrap">
				<!-- 좌측메뉴 -->
				<c:import url="/WEB-INF/views/include/leftMenu.jsp" />
				<!-- 좌측메뉴 끝 -->

				<div class="subContent">
					<!--서브 검색-->
					<div class="search_wrap">
						<form action="searchChatUser.do" method="get">
							<select name="searchnickname">
								<option value="" class="fontColor-dark">이름</option>
							</select>
							<div class="search-box">
								<input type="text" placeholder="회원의 이름를 검색해주세요." name="nickname">
								<button class="xi-search"></button>
							</div>
						</form>
					</div>
					<!--서브 검색 끝-->

					<div class="sort-area">
						<h4>전체 ${ usercount }명의 유저</h4>
					</div>
					<table class="chattingList">
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<tbody>
							<c:if test="${ !empty list }">
								<c:forEach var="user" items="${ list }">
									<tr
										onclick="location='startChat.do?receiver=${user.getNickname()}&receiverNo=${user.getUniqueNum()}'">
										<td class="img"><img
											src="/runningdog/resources/images/memberImg/${user.getRenameProfile()}"></td>
										<td class="title">
											<h2>${ user.nickname }</h2> <!-- <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p> -->
										</td>
										<td class="img"></td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${ empty list }">
								<tr class="list-no">
									<td colspan="10">
										<p>
											<img
												src="/runningdog/resources/images/btnIcn/icn_big_listNo.png"
												alt="" title="" />
										</p>
										<h1>검색 결과가 없습니다.</h1>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<!-- 페이징 -->
					<!-- <dl class="list-paging">
                            <dd>
                                <a href="#none"><i class="xi-angle-left"></i></a>
                                <a href="#none" class="active">1</a>
                                <a href="#none">2</a>
                                <a href="#none">3</a>
                                <a href="#none">4</a>
                                <a href="#none">5</a>
                                <a href="#none"><i class="xi-angle-right"></i></a>
                            </dd>
                        </dl> -->
					<!-- //페이징 -->
				</div>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->

		<c:import url="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>