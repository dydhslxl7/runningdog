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
							<li><a href="#none">홈</a></li>
							<li class="xi-angle-right"><a href="#none">공지사항</a></li>
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
					<!--상세-->
					<form name="formname" method="post" enctype="multipart/form-data" action="nupdate.ad" id="noticeUpdateForm" class="form-inline">
					<input type="hidden" name="noticeNo" value="${ notice.noticeNo }">
		            <input type="hidden" name="noticeOriginalFilename1" value="${ notice.noticeOriginalFilename1 }">
					<input type="hidden" name="noticeOriginalFilename2" value="${ notice.noticeOriginalFilename2 }">
					<input type="hidden" name="noticeOriginalFilename3" value="${ notice.noticeOriginalFilename3 }">
					<input type="hidden" name="noticeRenameFilename1" value="${ notice.noticeRenameFilename1 }">
					<input type="hidden" name="noticeRenameFilename2" value="${ notice.noticeRenameFilename2 }">
					<input type="hidden" name="noticeRenameFilename3" value="${ notice.noticeRenameFilename3 }">
					<input type="hidden" name="returnView" value="user">	
					
						<div class="write-area" id="inHere">

							<h2>${ notice.noticeNo }번공지사항 수정</h2>
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
							<input type="button" class="btn btn-list" onclick="javascript:history.go(-1); return false;" value="이전으로">
							<input type="reset" class="btn btn-cancel" onclick="Refresh()" value="취소하기"> 
							<input type="submit" class="btn btn-success" value="수정하기">
						</div>
					</form>
					<!-- 글쓰기 끝 -->
				</div>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->

		<c:import url="/WEB-INF/views/include/footer.jsp" />
	</div>
</body>
</html>