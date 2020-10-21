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
							<li class="xi-angle-right"><a href="nlist.do">공지사항</a></li>
						</ul>
					</div>
					<h2>
						<span>공지사항</span>
					</h2>
					<h3>'지금 달려갈 개'의 공지사항을 꼭 확인해주세요.</h3>
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
						<form action="nlist.do" name="">
							<select name="searchNotice">
								<!-- 검색분류가 비었을 경우 -->
								<c:if test="${ empty noticePage.search or noticePage.search eq null}">
									<option value="title" class="fontColor-dark">제목</option>
									<option value="content" class="fontColor-dark">내용</option>
									<option value="both" class="fontColor-dark">제목 + 내용</option>
								</c:if>
								<!-- 검색분류가 있을 경우 해당값 선택되어있게 하기 -->
								<c:if test="${ !empty noticePage.search }">
									<option value="title" class="fontColor-dark"
										${ noticePage.search eq 'title' ? 'selected' : '' }>제목</option>
									<option value="content" class="fontColor-dark"
										${ noticePage.search eq 'content' ? 'selected' : '' }>내용</option>
									<option value="both" class="fontColor-dark"
										${ noticePage.search eq 'both' ? 'selected' : '' }>제목 + 내용</option>
								</c:if>
							</select>
							<div class="search-box">
								<input type="text" placeholder="원하시는 키워드를 검색해주세요." name="keyword" value="${ noticePage.keyword }">
								<!-- 검색값 유지 -->
								<button type="submit" class="xi-search"></button>
							</div>
						</form>
					</div>
					<!--서브 검색 끝-->

					<div class="sort-area">
						<h4>전체 ${ noticePage.listCount }개의 공지사항</h4>
						
						<div>
						<!-- 관리자일때만 등록버튼 나오기 -->
						<c:if test="${ !empty sessionScope.loginMember and loginMember.adminChk eq 'Y' }">
							<a href="ninview.do" class="writeBtn">글쓰기</a>
						</c:if>
						</div>
						
					</div>

					<!--리스트-->
					<div class="list-area">
						<table>
							<colgroup>
								<col width="10%">
								<col width="*">
								<col width="15%">
							</colgroup>
							<tbody>

								<!-- 공지사항 new 알람을 위한 한달 전 날짜 -->
								<jsp:useBean id="nowDate" class="java.util.Date" />
								<jsp:setProperty name="nowDate" property="time" value="${nowDate.time - 86400000 * 32}" />
								<fmt:formatDate value="${nowDate}" type="date" pattern="yyyy/MM/dd" var="monthAgo" />

								<!-- 공지사항 목록 출력 -->
								<c:forEach items="${ requestScope.list }" var="n">

									<!-- 알림설정 되어있는 경우 -->
									<c:if test="${ !empty n.noticeState }">
										<c:url var="ndurl" value="ndetail.do">
											<c:param name="noticeNo" value="${ n.noticeNo }" />
											<c:param name="currentPage" value="${ noticePage.currentPage}" />
											<!-- 검색값 유지 -->
											<c:param name="search" value="${ noticePage.search }" />
											<c:param name="keyword" value="${ noticePage.keyword }" />
										</c:url>
										<tr onclick="location.href='${ ndurl }';" class="active">
											<td class="number">${n.noticeNo}</td>
											<td class="title">
												<h2>
													<span>공지</span>${ n.noticeTitle }</h2>
												<ul>
													<li>${ n.noticeDate }</li>
													<li>${ n.noticeReadcount }</li>
												</ul>
											</td>
											<td class="fileIcon">
											<c:if test="${ !empty n.noticeOriginalFilename1 || !empty n.noticeOriginalFilename2 || !empty n.noticeOriginalFilename3 }">
												<i class="xi-file-text"></i>
											</c:if></td>
										</tr>
									</c:if>

									<!-- 알림설정이 안되어있는 경우 -->
									<c:if test="${ empty n.noticeState }">
										<c:url var="ndurl" value="ndetail.do">
											<c:param name="noticeNo" value="${ n.noticeNo }" />
											<c:param name="currentPage" value="${ noticePage.currentPage}" />
											<!-- 검색값 유지 -->
											<c:param name="search" value="${ noticePage.search }" />
											<c:param name="keyword" value="${ noticePage.keyword }" />
										</c:url>
										<tr onclick="location.href='${ ndurl}';">
											<td class="number">${n.noticeNo}</td>
											<td class="title">
											<fmt:formatDate value="${n.noticeDate}" type="date" pattern="yyyy/MM/dd" var="ndate" />
												<h2>
													<c:if test="${monthAgo < ndate}">
														<!-- 공지사항 작성일이 한달안에 작성된 공지사항은 new 알림-->
														<span>new</span>
													</c:if>
													${ n.noticeTitle }
												</h2>
												<ul>
													<li>${ n.noticeDate }</li>
													<li>${ n.noticeReadcount }</li>
												</ul></td>
											<td class="fileIcon">
											<c:if test="${ !empty n.noticeOriginalFilename1 || !empty n.noticeOriginalFilename2 || !empty n.noticeOriginalFilename3 }">
											<!-- 첨부파일이 하나라도 있을경우 -->
												<i class="xi-file-text"></i>
											</c:if></td>
										</tr>
									</c:if>
								</c:forEach>
								<!-- 공지사항 목록 출력 끝 -->

								<!-- 목록이 없을 때 -->
								<c:if test="${ noticePage.listCount eq 0 }">
									<tr>
										<td colspan="3">
											<div class="list-no">
												<p>
													<img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" />
												</p>
												<h1>목록이 없습니다.</h1>
											</div>
										</td>
									</tr>
								</c:if>


							</tbody>
						</table>
					</div>
					<!-- 리스트 끝 -->

					<!-- 페이징 -->
					<dl class="list-paging">
						<dd>
							<!-- 이전 그룹 페이지 이동 -->
							<c:if test="${ (noticePage.currentPage - 5) lt noticePage.startPage and (noticePage.currentPage - 5) ge 1 }">
								<c:url var="npurl1" value="nlist.do">
									<c:param name="page" value="${ noticePage.startPage - 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="searchNotice" value="${ noticePage.search }" />
									<c:param name="keyword" value="${ noticePage.keyword }" />
								</c:url>
								<a href="${ npurl1 }"><i class="xi-angle-left"></i></a>
							</c:if>
							<%-- <c:if test="${ !((noticePage.currentPage - 5) lt noticePage.startPage and (noticePage.currentPage - 5) >= 1) }">
								 	<a href="#none"><i class="xi-angle-left"></i></a>
								</c:if> --%>

							<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리  -->
							<c:forEach var="p" begin="${ noticePage.startPage }" end="${ noticePage.endPage }" step="1">
								<c:if test="${ p eq noticePage.currentPage }">
									<a href="#none" class="active">${ p }</a>
								</c:if>
								<c:if test="${ p ne noticePage.currentPage }">
									<c:url var="npurl2" value="nlist.do">
										<c:param name="page" value="${ p }" />
										<!-- 검색값 유지 -->
										<c:param name="searchNotice" value="${ noticePage.search }" />
										<c:param name="keyword" value="${ noticePage.keyword }" />
									</c:url>
									<a href="${ npurl2 }">${ p }</a>
								</c:if>
							</c:forEach>

							<!-- 다음 그룹 페이지 이동 -->
							<c:if test="${ (noticePage.currentPage + 5) gt noticePage.endPage and noticePage.endPage lt noticePage.maxPage }">
								<c:url var="npurl3" value="nlist.do">
									<c:param name="page" value="${ noticePage.startPage + 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="searchNotice" value="${ noticePage.search }" />
									<c:param name="keyword" value="${ noticePage.keyword }" />
								</c:url>
								<a href="${ npurl3 }"><i class="xi-angle-right"></i></a>
							</c:if>
							<%-- <c:if test="${ !((noticePage.currentPage + 5) > noticePage.endPage and noticePage.endPage < noticePage.maxPage) }">
									<a href="#none"><i class="xi-angle-right"></i></a>
								</c:if> --%>
						</dd>
					</dl>
					<!-- //페이징 -->

				</div>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->

		<c:import url="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>