<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="../include/admin_header.jsp"/>

        <div id="container">
            <c:import url="../include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>관리자 정보수정</h3>
                    <h2>| 수정</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="adminInfo_wrap">
                <h2>관리자 정보수정</h2>
                <table class="adminInfo">
                    <colgroup>
                        <col width="25%">
                        <col width="75%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>아이디(이메일)</td>
                            <td><input type="text" name="" title="아이디(이메일)" class="form-control w80p" placeholder="taeung103@naver.com" readonly/></td>
                        </tr>
                        <tr>
                            <td>프로필 사진</td>
                            <td><input type="file" name="" title="프로필 사진"/></td>
                        </tr>
                        <tr>
                            <td>닉네임</td>
                            <td><input type="text" name="" title="닉네임" class="form-control w80p" placeholder="닉네임" value="관리자" readonly/></td>
                        </tr>
                        <tr>
                            <td>휴대폰번호</td>
                            <td class="telArea"><input type="tel" name="" title="휴대폰번호" class="form-control w80p" placeholder="'-' 포함 입력" value="010-3387-7583"/></td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="" title="비밀번호" class="form-control w80p" placeholder="기존 비밀번호"/></td>
                        </tr>
                        <tr>
                            <td>신규 비밀번호</td>
                            <td class="newPwd">
                                <input type="password" name="" title="신규 비밀번호" class="form-control w80p mb5" placeholder="신규 비밀번호 입력"/><br/>
                                <input type="password" name="" title="신규 비밀번호 재확인" class="form-control w80p mb10" placeholder="신규 비밀번호 재입력"/><br/>
                                <button>변경하기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="write-btn">
                    <input type="reset" class="btn btn-list" value="취소하기">
                    <input type="submit" class="btn btn-success" value="수정하기">
                </div>

            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>