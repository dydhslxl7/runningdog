<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="../include/admin_head.jsp"/>
    <script type="text/javascript">
    	var content = '${ sponsor.sContent }';
    	$(function(){
    		$('#summernote').summernote(content);
    		// and set code
    		$('#summernote').summernote('code', content);
    	});
    </script>
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
                    <h2>| 수정</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <form id="editor" method="post" enctype="multipart/form-data" action="supdate.ad" class="form-inline">
            	<input type="hidden" value="${ loginMember.nickname }" name="sId">
            	<input type="hidden" value="${ sponsor.sNum }" name="sNum">
            	<input type="hidden" value="${ sponsor.sOriginal }" name="sOriginal" id="of">
            	<input type="hidden" value="${ sponsor.sRename }" name="sRename" id="rf">
            	<input type="hidden" value="${ sponsor.sChk }" name="sChk">
            <div class="write-area">
            
                <h2>후원하기 수정</h2>
                <p>후원하기 게시글을 수정해주세요.</p>
                
                <table>
                    <colgroup>
                        <col width="20%">
                        <col width="80%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>제목</td>
                            <td><input onfocus="textlength(this);" maxlength="18" type="text" name="sTitle" class="form-control w100p" placeholder="제목 입력" required value="${ sponsor.sTitle }"></td>
                        </tr>
                        <tr>
                            <td>요약 설명</td>
                            <td><input onfocus="textlength(this);" maxlength="40" type="text" name="sSummary" class="form-control w100p" placeholder="요약 설명 입력" required value="${ sponsor.sSummary }"></td>
                        </tr>
                        <tr>
                            <td>목표 금액</td>
                            <td><input value="${ amount }" onkeyup="addCommas(this.value)" id="amt" type="text" name="amount" class="form-control" placeholder="0" required style="width:150px; text-align:right;"></td>
                        </tr>
                        <tr id="file">
                            <td>썸네일</td>
                            <c:if test="${ !empty sponsor.sOriginal }">
                            	<td id="ofile">${ sponsor.sOriginal } &nbsp; &nbsp;
                            	<button class="deleteBtn" onclick="showFileSelect(${ sponsor.sNum });"><i class="xi-cut"></i> 파일삭제</button></td>
                            </c:if>
                            	<td id="showSelect"><input id="ufile" type="file" name="upfile" accept="image/*" data-ch="n"></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea id="summernote" name="sContent" class="form-control" style="resize: none; width:100%; min-height:300px; max-height:300px;"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="write-btn">
                		<c:url value="aslist.ad" var="lis">
                			<c:param name="page" value="${ page }" />
                		</c:url>
                    <input type="button" class="btn btn-list" value="목록으로" onclick="javascript:location.href='${ lis }'">
                    <input type="reset" class="btn btn-cancel" value="취소하기" onclick="Refresh();">
                    <input id="cucu" type="submit" class="btn btn-success" value="작성하기">
                </div>
            </div>
            </form>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>