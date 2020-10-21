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
					<h2>| 작성</h2>
				</div>
			</div>
			<!-- //상단 타이틀 -->

			<!-- 본문내용 -->
			<form name="formname" method="post" enctype="multipart/form-data" action="ninsert.ad" class="form-inline">
				<input type="hidden" name="returnView" value="admin">
				<div class="write-area">

					<h2>공지사항 작성</h2>
					<p>공지사항을 입력해주세요.</p>

					<table>
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
							<tr>
								<td>알림</td>
								<td><label><input type="radio" name="noticeState" id="state" value="checked">필수여부</label></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input type="text" name="noticeTitle" class="form-control w100p" placeholder="제목 입력" required></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td><input type="text" name="noticeWriter" class="form-control w100p" readonly value="${ sessionScope.loginMember.nickname }"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="noticeContent" rows="" cols=""class="form-control"
									style="resize: none; width: 100%; min-height: 300px; max-height: 300px;" required></textarea>
								</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td><input type="file" name="ofile1" class="mb5"> 
									<input type="file" name="ofile2" class="mb5"> 
									<input type="file" name="ofile3" class="mb5">
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="write-btn">
					<input type="button" class="btn btn-list" onclick="location.href='nlist.ad'" value="목록으로"> 
					<input type="reset" class="btn btn-cancel" value="취소하기"> 
					<input type="submit" class="btn btn-success" value="작성하기">
				</div>
			</form>
		</div>
		<c:import url="/WEB-INF/views/admin/include/admin_footer.jsp" />
	</div>
</body>
</html>