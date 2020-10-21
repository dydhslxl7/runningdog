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
                    <h3>사용자약관 관리</h3>
                    <h2>| 수정</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <form name="formname" method="post" enctype="" action="" class="form-inline">
            <div class="write-area">
            
                <h2>사용자약관 수정</h2>
                <p>사용자약관 페이지 내용을 수정하실 수 있습니다.</p>
                
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="80%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>분류</td>
                            <td>
                                <select name="" id="">
                                    <option value="">이용약관</option>
                                    <option value="">개인정보처리방침</option>
                                    <option value="">이메일무단수집거부</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea name="" rows="" cols="" class="form-control" style="resize: none; width:100%; min-height:600px; max-height:600px;"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="write-btn">
                    <input type="button" class="btn btn-list" value="목록으로">
                    <input type="reset" class="btn btn-cancel" value="취소하기">
                    <input type="submit" class="btn btn-success" value="작성하기">
                </div>
            </div>
            </form>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>