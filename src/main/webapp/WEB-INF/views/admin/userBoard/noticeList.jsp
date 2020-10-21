<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/admin/include/admin_head.jsp" />
</head>
<body oncontextmenu="return false" onselectstart="return false"
	ondragstart="return false">
	<div id="wrap">
		<c:import url="/WEB-INF/views/admin/include/admin_header.jsp" />

		<div id="container">
			<c:import url="/WEB-INF/views/admin/include/admin_util.jsp" />

			<!-- 상단 타이틀 -->
			<div class="pageTitle">
				<div class="adminPath">
					<h3>공지사항 관리</h3>
					<h2>| 리스트</h2>
				</div>
			</div>
			<!-- //상단 타이틀 -->

			<!-- 공지사항 new 알람을 위한 한달 전 날짜 -->
			<jsp:useBean id="nowDate" class="java.util.Date" />
			<jsp:setProperty name="nowDate" property="time" value="${nowDate.time - 86400000 * 32}" />
			<fmt:formatDate value="${nowDate}" type="date" pattern="yyyy/MM/dd" var="monthAgo" />

			<!-- 본문내용 -->
			<div class="list_wrap">
				<!-- 검색영역 -->
				<div class="sort-area">
					<h4>전체 게시물 ${ noticePage.listCount }개</h4>
					<form action="nlist.ad" method="get" id="">
						<div class="searchBox">
							<select name="searchNotice" class="ListSelect">
								<!-- 검색분류가 비었을 경우 -->
								<c:if test="${ empty noticePage.search or noticePage.search eq null}">
									<option value="title">제목</option>
									<option value="content">내용</option>
									<option value="both">제목 + 내용</option>
								</c:if>
								<!-- 검색분류가 있을 경우 해당값 선택되어있게 하기 -->
								<c:if test="${ !empty noticePage.search }">
									<option value="title"
										${ noticePage.search eq 'title' ? 'selected' : '' }>제목</option>
									<option value="content"
										${ noticePage.search eq 'content' ? 'selected' : '' }>내용</option>
									<option value="both"
										${ noticePage.search eq 'both' ? 'selected' : '' }>제목 + 내용</option>
								</c:if>

							</select>
							<div>
								<input type="text" name="keyword" placeholder="검색어를 입력해주세요." value="${ noticePage.keyword }">
								<button type="submit" class="top-search">
									<i class="xi-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<!-- 검색영역 끝 -->
				<table class="list">
					<colgroup>
						<col width="5%">
						<col width="5%">
						<col width="8%">
						<col width="*">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th class="checkBox"><input type="checkbox" name="allCheck" id="allCheck" value=""></th>
							<th>번호</th>
							<th>공지여부</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>첨부파일</th>
						</tr>
						<tr>
						</tr>
						<tr class="hr">
							<th colspan="7"></th>
						</tr>
					</thead>
					<tbody>

						<!-- 공지사항 목록 출력 -->
						<c:forEach items="${ requestScope.list }" var="n">
							<c:url var="ndurl" value="ndetail.ad">
								<c:param name="noticeNo" value="${ n.noticeNo }" />
								<c:param name="currentPage" value="${ noticePage.currentPage}" />
								<!-- 검색값 유지 -->
								<c:param name="search" value="${ noticePage.search }" />
								<c:param name="keyword" value="${ noticePage.keyword }" />
							</c:url>
							<tr onclick="location='${ndurl}'">
								<td class="checkBox" onclick="event.cancelBubble=true">
								<input type="checkbox" name="checkDel" id="" value="${ n.noticeNo }"></td>
								<td class="number">${ n.noticeNo }</td>
								<td class="kinds">
								<c:if test="${ !empty n.noticeState }">
									<span class="protect">공지</span>
								</c:if> 
								<c:if test="${ empty n.noticeState }">
									<fmt:formatDate value="${n.noticeDate}" type="date" pattern="yyyy/MM/dd" var="ndate" />
									<c:if test="${monthAgo < ndate}">
									<!-- 공지사항 작성일이 한달안에 작성된 공지사항은 new 알림-->
										<span class="protect">new</span>
									</c:if>
								</c:if></td>
								<td class="title">${ n.noticeTitle }</td>
								<td class="name">${ n.noticeWriter }</td>
								<td class="date">${ n.noticeDate }</td>
								<td class="file">
								<c:if test="${ !empty n.noticeOriginalFilename1 || !empty n.noticeOriginalFilename2 || !empty n.noticeOriginalFilename3 }">
									<i class="xi-file-text"></i>
								</c:if></td>

							</tr>

						</c:forEach>

						<!-- 목록이 없을 때 -->
						<c:if test="${ noticePage.listCount eq 0 }">
							<tr class="list-no">
								<td colspan="7">
									<p>
										<img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" />
									</p>
									<h1>목록이 없습니다.</h1>
								</td>
							</tr>
						</c:if>

					</tbody>
				</table>
				<p class="warning_text">*삭제된 게시물은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p>
				<!-- //게시판 -->

				<!-- 버튼 -->
				<div class="list-btn">
					<button type="button" id="selectDel" class="btn-left chkBtn" onclick="selectDel()">
						<i class="xi-cut"></i> 선택삭제
					</button>
					<button type="button" id="" class="btn-right writeBtn"
						onclick="location='ninview.ad'">
						<i class="xi-pen-o"></i> 글작성
					</button>
				</div>
				<!-- //버튼 -->

				<!-- 페이징 -->
				<dl class="list-paging">
					<dd>
						<!-- 이전 그룹 페이지 이동 -->
						<c:if test="${ (noticePage.currentPage - 5) lt noticePage.startPage and (noticePage.currentPage - 5) ge 1 }">
							<c:url var="npurl1" value="nlist.ad">
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
								<c:url var="npurl2" value="nlist.ad">
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
							<c:url var="npurl3" value="nlist.ad">
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
		<c:import url="/WEB-INF/views/admin/include/admin_footer.jsp" />
	</div>
</body>
</html>