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
					<h2>| 상세</h2>
				</div>
			</div>
			<!-- //상단 타이틀 -->

			<!-- 공지사항 new 알람을 위한 한달 전 날짜 -->
			<jsp:useBean id="nowDate" class="java.util.Date" />
			<jsp:setProperty name="nowDate" property="time" value="${nowDate.time - 86400000 * 32}" />
			<fmt:formatDate value="${nowDate}" type="date" pattern="yyyy/MM/dd" var="monthAgo" />

			<!-- 본문내용 -->
			<div class="view-area">
				<!-- 공지사항 알림 여부에 따라 표시 -->
				<c:if test="${ !empty notice.noticeState }">
					<h3>
						<span>공지</span>
					</h3>
				</c:if>
				<c:if test="${ empty notice.noticeState }">
					<fmt:formatDate value="${notice.noticeDate}" type="date" pattern="yyyy/MM/dd" var="ndate" />
					<c:if test="${ monthAgo < ndate }">
						<h3>
							<span>new</span>
						</h3>
					</c:if>
				</c:if>

				<h2>${ notice.noticeTitle }</h2>
				<ul>
					<li><span>작성자 : </span>${ notice.noticeWriter }</li>
					<li><span>등록일 : </span>${ notice.noticeDate }</li>
					<li><span>조회수 : </span>${ notice.noticeReadcount }</li>
				</ul>

				<!-- 파일 순서대로 저장했기때문에 단계별로 보여주기 -->
				<c:if test="${ !empty notice.noticeOriginalFilename1 }">
					<ul>
						<li><span>첨부파일 : </span> 
						<c:url var="nfdurl1" value="nfdown.do">
							<c:param name="ofile" value="${ notice.noticeOriginalFilename1 }" />
							<c:param name="rfile" value="${ notice.noticeRenameFilename1 }" />
						</c:url> <a href="${nfdurl1}">${ notice.noticeOriginalFilename1 }</a></li>

						<c:if test="${ !empty notice.noticeOriginalFilename2 }">
							<c:url var="nfdurl2" value="nfdown.do">
								<c:param name="ofile" value="${ notice.noticeOriginalFilename2 }" />
								<c:param name="rfile" value="${ notice.noticeRenameFilename2 }" />
							</c:url>
							<li><a href="${nfdurl2}">${ notice.noticeOriginalFilename2 }</a></li>
						</c:if>

						<c:if test="${ !empty notice.noticeOriginalFilename3 }">
							<c:url var="nfdurl3" value="nfdown.do">
								<c:param name="ofile" value="${ notice.noticeOriginalFilename3 }" />
								<c:param name="rfile" value="${ notice.noticeRenameFilename3 }" />
							</c:url>
							<li><a href="${ nfdurl3 }">${ notice.noticeOriginalFilename3 }</a></li>
						</c:if>
					</ul>
				</c:if>

				<div class="view-ctn" style="white-space: pre">
					<pre style="background-color: rgba(255, 0, 0, 0);"><c:out value="${ notice.noticeContent }" /></pre>
				</div>

				<!-- 버튼 -->
				<div class="viewBtn-wrap">

					<!-- 이전글 -->
					<c:url var="npre" value="ndetail.ad">
						<c:param name="noticeNo" value="${ preNo }" />
						<c:param name="currentPage" value="${ noticePage.currentPage }" />
						<c:param name="search" value="${ noticePage.search }" />
						<c:param name="keyword" value="${ noticePage.keyword }" />
					</c:url>
					<c:if test="${ preNo ne 0 }">
						<button class="nextBtn" onclick="moveNoticePreDetail('${ preNo }', '${ npre }')"><i class="xi-angle-left-min"></i> 이전</button>
					</c:if>
					<c:if test="${ preNo eq 0 }">
						<button class="nextBtn offBtn" onclick="moveNoticePreDetail('${ preNo }', '${ npre }')"><i class="xi-angle-left-min"></i> 이전</button>
					</c:if>

					<!-- 목록 -->
					<c:url var="nlisturl" value="nlist.ad">
						<c:param name="page" value="${ noticePage.currentPage }" />
						<c:param name="searchNotice" value="${ noticePage.search }" />
						<c:param name="keyword" value="${ noticePage.keyword }" />
					</c:url>
					<button class="listBtn" onclick="location.href='${nlisturl}'">
						<i class="xi-rotate-left"></i> 목록
					</button>

					<!-- 삭제 -->
					<c:url var="ndelurl" value="ndelete.do">
						<c:param name="noticeNo" value="${ notice.noticeNo }" />
						<c:param name="rfile1" value="${ notice.noticeRenameFilename1 }" />
						<c:param name="rfile2" value="${ notice.noticeRenameFilename2 }" />
						<c:param name="rfile3" value="${ notice.noticeRenameFilename3 }" />
					</c:url>
					<button class="deleteBtn" onclick="location.href='${ndelurl}'">
						<i class="xi-cut"></i> 삭제
					</button>

					<!-- 수정 -->
					<c:url var="nupviewurl" value="nupview.ad">
						<c:param name="noticeNo" value="${ notice.noticeNo }" />
					</c:url>
					<button class="modifiedBtn" onclick="location.href='${nupviewurl}'">
						<i class="xi-pen-o"></i> 수정
					</button>

					<!-- 다음글 -->
					<c:url var="nnext" value="ndetail.ad">
						<c:param name="noticeNo" value="${ nextNo }" />
						<c:param name="currentPage" value="${ noticePage.currentPage }" />
						<c:param name="search" value="${ noticePage.search }" />
						<c:param name="keyword" value="${ noticePage.keyword }" />
					</c:url>
					<c:if test="${ nextNo ne 0 }">
						<button class="prevBtn" onclick="moveNoticeNextDetail('${ nextNo }', '${ nnext }')">다음 <i class="xi-angle-right-min"></i></button>
					</c:if>
					<c:if test="${ nextNo eq 0 }">
						<button class="prevBtn offBtn" onclick="moveNoticeNextDetail('${ nextNo }', '${ nnext }')">다음 <i class="xi-angle-right-min"></i> </button>
					</c:if>

				</div>
				<!-- 버튼 끝 -->
			</div>
		</div>
		<c:import url="/WEB-INF/views/admin/include/admin_footer.jsp" />
	</div>
</body>
</html>