<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
    <script>
    $(function(){
        $(".privacyCke a.con1").click(function(){
            $(".privacyCke_con textarea.con2").removeClass('on');
            $(".privacyCke_con textarea.con1").toggleClass('on');
        });
        $(".privacyCke a.con2").click(function(){
            $(".privacyCke_con textarea.con1").removeClass('on');
            $(".privacyCke_con textarea.con2").toggleClass('on');
        });
    });
	</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="../include/admin_header.jsp"/>

        <div id="container">
            <c:import url="../include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>전체회원 관리</h3>
                    <h2>| 추가</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="adminInfo_wrap">
                <h2>회원 추가</h2>
                <form method="post" id="memberInsertForm" name="memberInsert" enctype="multipart/form-data">
                <table class="adminInfo">
                    <colgroup>
                        <col width="25%">
                        <col width="75%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>아이디(이메일)</td>
                            <td>
	                            <input type="text" name="userId" title="아이디(이메일)" id="userIdChk" class="form-control w80p" placeholder="아이디(이메일)" maxlength="40"/>
	                            <p id="idWarning">
	                                <span></span>
	                            </p>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td>
	                            <input type="password" name="userPwd" title="비밀번호" id="userPwdChk" class="form-control w80p" placeholder="비밀번호" maxlength="40"/>
                        	    <p id="pwdWarning">
	                                <span></span>
	                            </p>
	                            <input type="password" name="userPwd2" title="비밀번호 확인" id="userPwdChk2" class="form-control w80p" placeholder="비밀번호 확인" maxlength="40"/>
	                            <p id="pwdWarning2">
	                                <span>사용하실 비밀번호는 특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.</span>
	                            </p>
                            </td>
                        </tr>
                        <tr>
                            <td>프로필 사진</td>
                            <td><input type="file" name="profilImage" title="프로필 사진"/></td>
                        </tr>
                        <tr>
                            <td>닉네임</td>
                            <td>
                            	<input type="text" name="nickname" title="닉네임" id="nicknameChk" class="form-control w80p" placeholder="닉네임" maxlength="40"/>
	                            <p id="nicknameWarning">
	                                <span></span>
	                            </p>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰번호</td>
                            <td class="telArea">
                            <input type="tel" name="phone" title="휴대폰번호" id="phoneChk" class="form-control w80p" placeholder="'-' 포함 입력" maxlength="40"/>
                            <p id="phoneWarning">
                                <span></span>
                            </p>
                            </td>
                        </tr>
                        <tr>
                            <td>관리자 권한부여</td>
                            <td>
                                <select name="adminChk" class="adminChk" id="adminChk">     
		                            <option value="N">일반 회원</option>                   
		                            <option value="Y">관리자 권한부여</option>
                       			</select>
	                            <p id="adminChkWarning">
	                            </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="privacyCke" style="text-align:center;">
                            	<label><input type="checkbox" name="" id="chkY"/>서비스의 <a href="#none" class="con1">이용약관</a>과 <a href="#none" class="con2">개인정보처리방침</a>에 동의합니다.</label>
		                        <div class="privacyCke_con">
		                            <c:import url="/WEB-INF/views/include/termsCon.jsp"/>
		                            <c:import url="/WEB-INF/views/include/privacyCon.jsp"/>
		                        </div>
							</td>
                        </tr>
                    </tbody>
                </table>
	
                <div class="write-btn">
                    <input type="reset" class="btn btn-list" value="취소하기">
                    <input id="adminMemberInsertAction" type="button" class="btn btn-success memberInsert_btn" value="회원등록">
                </div>
				</form>
            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>