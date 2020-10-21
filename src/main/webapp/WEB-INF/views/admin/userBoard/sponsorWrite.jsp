<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
</head>
<body oncontextmenu="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="../include/admin_header.jsp"/>

        <div id="container">
            <c:import url="../include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>후원하기 관리</h3>
                    <h2>| 작성</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <form id="editor" method="post" enctype="multipart/form-data" action="sinsert.ad" class="form-inline">
            	<input type="hidden" value="${ loginMember.nickname }" name="sId">
            	<input type="hidden" value="n" name="sChk">
            <div class="write-area">
            
                <h2>후원하기 작성</h2>
                <p>후원하기 게시글을 작성해주세요.</p>
                
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="80%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>제목</td>
                            <td><input onfocus="textlength(this);" type="text" name="sTitle" class="form-control w100p" placeholder="제목 입력" maxlength="18" required></td>
                        </tr>
                        <tr>
                            <td>요약 설명</td>
                            <td><input onfocus="textlength(this);" maxlength="40" type="text" name="sSummary" class="form-control w100p" placeholder="요약 설명 입력" required></td>
                        </tr>
                        <tr>
                            <td>목표 금액</td>
                            <td><input onkeyup="addCommas(this.value)" id="amt" type="text" name="amount" class="form-control" placeholder="0" required style="width:150px; text-align:right;"></td>
                        </tr>
                        <tr>
                            <td>썸네일</td>
                            <td><input id="wfile" type="file" name="upfile" accept="image/*"></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea id="summernote" name="sContent" rows="" cols="" class="form-control" style="resize: none; width:100%; min-height:300px; max-height:300px;"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="write-btn">
                    <input type="button" class="btn btn-list" value="목록으로" onclick="javascript:location.href='aslist.ad'">
                    <input type="reset" class="btn btn-cancel" value="취소하기" onclick="Refresh(); return false;">
                    <input type="submit" class="btn btn-success" value="작성하기">
                </div>
            </div>
            </form>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>