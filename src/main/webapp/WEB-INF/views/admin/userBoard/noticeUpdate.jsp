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
					<h2>| 수정</h2>
				</div>
			</div>
			<!-- //상단 타이틀 -->

			<!-- 본문내용 -->
			<form name="formname" method="post" enctype="multipart/form-data" action="nupdate.ad" id="noticeUpdateForm" class="form-inline">
			<input type="hidden" name="noticeNo" value="${ notice.noticeNo }">
            <input type="hidden" name="noticeOriginalFilename1" value="${ notice.noticeOriginalFilename1 }">
			<input type="hidden" name="noticeOriginalFilename2" value="${ notice.noticeOriginalFilename2 }">
			<input type="hidden" name="noticeOriginalFilename3" value="${ notice.noticeOriginalFilename3 }">
			<input type="hidden" name="noticeRenameFilename1" value="${ notice.noticeRenameFilename1 }">
			<input type="hidden" name="noticeRenameFilename2" value="${ notice.noticeRenameFilename2 }">
			<input type="hidden" name="noticeRenameFilename3" value="${ notice.noticeRenameFilename3 }">
			<input type="hidden" name="returnView" value="admin">	
				
				<div class="write-area" id="inHere">

					<h2>${ notice.noticeNo }번글공지사항 수정</h2>
					<p>수정사항을 입력해주세요.</p>

					<table>
						<colgroup>
							<col width="20%">
							<col width="80%">
						</colgroup>
						<tbody>
							<tr>
								<td>알림</td>
								<td><label><input type="radio" name="noticeState" id="state" value="checked" ${ notice.noticeState } />필수여부</label></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input type="text" name="noticeTitle" class="form-control w100p" placeholder="제목 입력" required value="${ notice.noticeTitle }" /></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td><input type="text" name="noticeWriter" class="form-control w100p" readonly value="${ sessionScope.loginMember.nickname }"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="noticeContent" class="form-control" style="resize: none; width: 100%; min-height: 300px; max-height: 300px;">${ notice.noticeContent }</textarea></td>
							</tr>
							<tr>
							<tr>
								<td>첨부파일</td>
								<td id="files">
								<!-- 첨부파일 여부에 따라 보이는거 다르게 하기 --> 
								<c:if test="${ !empty notice.noticeOriginalFilename1 }">
									<p id="original1">${ notice.noticeOriginalFilename1 }&nbsp;&nbsp;
									<button class="deleteBtn" onclick="showFileSelect1(); deletefile1();"><i class="xi-cut"></i> 파일삭제</button></p>
								</c:if> 
								<c:if test="${ empty notice.noticeOriginalFilename1 }">
									<input type="file" name="newfile1" class="mb5">
								</c:if> 
								<input type="file" id="showSelect1" name="refile1" class="mb5"> 
								<c:if test="${ !empty notice.noticeOriginalFilename2 }">
									<p id="original2">${ notice.noticeOriginalFilename2 }&nbsp;&nbsp;
									<button class="deleteBtn" onclick="showFileSelect2(); deletefile2();"><i class="xi-cut"></i> 파일삭제</button>	</p>
								</c:if> 
								<c:if test="${ empty notice.noticeOriginalFilename2 }">
									<input type="file" name="newfile2" class="mb5">
								</c:if> 
								<input type="file" id="showSelect2" name="refile2"class="mb5"> 
								<c:if test="${ !empty notice.noticeOriginalFilename3 }">
									<p id="original3">${ notice.noticeOriginalFilename3 }&nbsp;&nbsp;
									<button class="deleteBtn" onclick="showFileSelect3(); deletefile3();"><i class="xi-cut"></i> 파일삭제</button></p>
								</c:if> 
								<c:if test="${ empty notice.noticeOriginalFilename3 }">
									<input type="file" name="newfile3" class="mb5">
								</c:if> 
								<input type="file" id="showSelect3" name="refile3" class="mb5">
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="write-btn">
					<input type="button" class="btn btn-list"onclick="javascript:history.go(-1); return false;" value="이전으로">
					<input type="reset" class="btn btn-cancel" onclick="Refresh()"value="취소하기"> 
					<input type="submit" class="btn btn-success" value="수정하기">
				</div>
			</form>
		</div>
		<c:import url="/WEB-INF/views/admin/include/admin_footer.jsp" />
	</div>
</body>
</html>