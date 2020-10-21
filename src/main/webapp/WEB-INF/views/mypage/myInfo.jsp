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
                                <li class="xi-angle-right"><a href="#none">나의 프로필</a></li>
                            </ul>
                        </div>
                        <h2><span>나의 프로필</span></h2>
                        <h3>나의 프로필 정보를 변경할 수 있습니다.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->
                    <div class="subContent">
                        <div class="mypage_area">
                            <h2 class="mypage_title">나의 프로필 수정</h2>
                            <c:if test="${ loginMember.loginType eq null }">
                            <form method="post" id="myinfoForm" name="myinfoAction.do" enctype="multipart/form-data">
                    		<legend>나의 프로필</legend>
                            <table class="InfoModify_table">
                                <colgroup>
                                    <col width="25%">
                                    <col width="75%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td>아이디(이메일)</td>
                                        <td>
                                        	<input type="hidden" name="uniqueNum" title="회원번호(고유번호)" class="form-control w80p" placeholder="회원번호(고유번호)" value="${sessionScope.loginMember.uniqueNum}" readonly/>
                                        	<input type="text" name="userId" title="아이디(이메일)" class="form-control w80p" placeholder="아이디(이메일)" value="${sessionScope.loginMember.userId}" maxlength="40" readonly/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>프로필 사진</td>
                                        <td class="profilImage">
                                       	 	<c:if test="${ !empty loginMember.originProfile }">
											${ loginMember.originProfile } &nbsp;
											<label><input type="checkbox" name="deleteFlag" value="yes">이미지삭제</label>
											</c:if>
											<c:if test="${ empty loginMember.originProfile }">
											<input type="file" name="profilImage" title="프로필 사진"/>
											</c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>닉네임</td>
                                        <td>
                                        <input type="text" name="nickname" title="닉네임" id="nicknameChk" class="form-control w80p" placeholder="닉네임" value="${sessionScope.loginMember.nickname}" maxlength="40"/>
				                        <p id="nicknameWarning">
				                       		<span></span>
				                        </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>휴대폰번호</td>
                                        <td class="telArea">
                                        <input type="tel" name="phone" title="휴대폰번호" id="phoneChk" class="form-control w80p" placeholder="'-' 포함 입력"  value="${sessionScope.loginMember.phone}" maxlength="40"/>
			                            <p id="phoneWarning">
			                                <span></span>
			                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>비밀번호</td>
                                        <td>
                                        	<input type="password" name="userPwd" title="비밀번호" id="userPwdChk" class="form-control w80p" placeholder="기존 비밀번호" maxlength="40"/>
				                            <p id="pwdWarning">
				                                <span></span>
				                            </p>
                                       	</td>
                                    </tr>
                                    <tr>
                                        <td>새 비밀번호</td>
                                        <td class="newPwd">
                                            <input type="password" name="newUserPwd" title="새 비밀번호" id="newUserPwdChk" class="form-control w80p mb5" placeholder="새 비밀번호 입력" maxlength="40"/><br/>
                                            <input type="password" name="newUserPwd2" title="새 비밀번호 재확인" id="newUserPwdChk2" class="form-control w80p mb10" placeholder="새 비밀번호 재입력" maxlength="40"/><br/>
                                            <button type="button" class="myPwdChangeBtn">변경하기</button>
                                            <p id="newUserPwdWarning">
				                                <span></span>
				                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <button type="button" class="leaveBtn">탈퇴하기</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
            				</form>
                            <div class="write-btn">
                                <input type="reset" class="btn btn-list" value="취소하기">
                                <input type="button" class="btn btn-success myinfoBtn" value="수정하기">
                            </div>
                            </c:if>
                            
                            
                            
                            <c:if test="${ loginMember.loginType ne null }">
                            <form method="post" id="socialMyinfoForm" name="socialMyinfoAction.do" enctype="multipart/form-data">
                    		<legend>나의 프로필</legend>
                            <table class="InfoModify_table">
                                <colgroup>
                                    <col width="25%">
                                    <col width="75%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td>아이디(이메일)</td>
                                        <td>
                                        	<input type="hidden" name="uniqueNum" title="회원번호(고유번호)" class="form-control w80p" placeholder="회원번호(고유번호)" value="${sessionScope.loginMember.uniqueNum}" readonly/>
                                        	<input type="text" name="userId" title="아이디(이메일)" class="form-control w80p" placeholder="아이디(이메일)" value="${sessionScope.loginMember.userId}" maxlength="40" readonly/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>프로필 사진</td>
                                        <td class="profilImage">
                                       	 	<c:if test="${ loginMember.loginType eq null }">
												<c:if test="${ !empty loginMember.originProfile  }">
												${ loginMember.originProfile } &nbsp;
												<label><input type="checkbox" name="deleteFlag" value="yes">이미지삭제</label>
												</c:if>
												<c:if test="${ empty loginMember.originProfile  }">
												<input type="file" name="profilImage" title="프로필 사진"/>
												</c:if>
											</c:if>
											
                                       	 	<c:if test="${ loginMember.loginType ne null }">
												<c:if test="${ !empty loginMember.renameProfile  }">
												${ loginMember.renameProfile } &nbsp;
													<c:if test="${ loginMember.loginType ne 'kakao' }">
													<label><input type="checkbox" name="deleteFlag" value="yes">이미지삭제</label>
													</c:if>
												</c:if>
												<c:if test="${ empty loginMember.renameProfile }">
												<input type="file" name="profilImage" title="프로필 사진"/>
												</c:if>
											</c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>닉네임</td>
                                        <td>
                                        <input type="text" name="nickname" title="닉네임" id="nicknameChk" class="form-control w80p" placeholder="닉네임" value="${sessionScope.loginMember.nickname}" maxlength="40"/>
				                        <p id="socialNicknameWarning">
				                       		<span></span>
				                        </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>휴대폰번호</td>
                                        <td class="telArea">
                                        <input type="tel" name="phone" title="휴대폰번호" id="phoneChk" class="form-control w80p" placeholder="'-' 포함 입력"  value="${sessionScope.loginMember.phone}" maxlength="40"/>
			                            <p id="socialPhoneWarning">
			                                <span></span>
			                            </p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <button onclick="unlinkApp()" type="button" class="socialMemberLeaveBtn api-btn">탈퇴하기</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
            				</form>
                            <div class="write-btn">
                                <input type="reset" class="btn btn-list" value="취소하기">
                                <input type="button" class="btn btn-success socialMyinfoBtn" value="수정하기">
                            </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>