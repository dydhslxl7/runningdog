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
                                <li><a href="main.do">홈</a></li>
                                <li class="xi-angle-right"><a href="/runningdog/vlist.do">자원봉사모집</a></li>
                            </ul>
                        </div>
                        <h2><span>자원봉사모집</span></h2>
                        <h3>작은 천사들을 위해 원하시는 곳에서<br/>봉사활동을 신청하실 수 있습니다.</h3>
                    </div>
                </div>
                <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        <!--상세-->
                        <form name="formname" method="post" enctype="multipart/form-data" action="vupdate.do" id="volun" class="form-inline">
                        <input type="hidden" name="volno" value="${ volunteer.volno }">
                        <input type="hidden" name="volor1" value="${ volunteer.volor1 }">
                        <input type="hidden" name="volor2" value="${ volunteer.volor2 }">
                        <input type="hidden" name="volor3" value="${ volunteer.volor3 }">
                        <input type="hidden" name="volor4" value="${ volunteer.volor4 }">
                        <input type="hidden" name="volre1" value="${ volunteer.volre1 }">
                        <input type="hidden" name="volre2" value="${ volunteer.volre2 }">
                        <input type="hidden" name="volre3" value="${ volunteer.volre3 }">
                        <input type="hidden" name="volre4" value="${ volunteer.volre4 }">
                        <input type="hidden" name="unique_num" value="${ sessionScope.loginMember.uniqueNum }">
                        <%-- <input type="hidden" name="volwriter" value="${ sessionScope.loginMember.nickname }"> --%>
                        <div class="write-area" id="inHere" >
                        
                            <h2>자원봉사모집 작성</h2>
                            <p>여러분의 봉사활동으로 많은 유기동물들이 보살핌을 받고 있습니다.</p>
                            
                            <table>
                                <colgroup>
                                    <col width="20%">
                                    <col width="80%">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <td>제목</td>
                                        <td><input type="text" name="voltitle" value="${volunteer.voltitle}" class="form-control w100p" required/></td>
                                    </tr>
                                    <tr>
                                        <td>첨부파일</td>
                                        <td id="files">
                                        <c:if test="${!empty volunteer.volor1 }">
                                        	<p id="original1">${  volunteer.volor1 }&nbsp;&nbsp;
                                        	<button class="deleteBtn" onclick="showFileSelect1(); deletefile1();"><i class="xi-cut"></i> 파일삭제</button></p>
                                        </c:if>
                                        <c:if test="${ empty volunteer.volor1 }">
                                            <input type="file" name="newfile1" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/>
                                        </c:if>
                                        <input type="file" id="showSelect1" name="refile1" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);' />
                                         
                                        <c:if test="${!empty volunteer.volor2 }">
                                        	<p id="original2">${  volunteer.volor2 }&nbsp;&nbsp;
                                        	<button class="deleteBtn" onclick="showFileSelect2(); deletefile2();"><i class="xi-cut"></i> 파일삭제</button></p>
                                        </c:if>
                                        <c:if test="${ empty volunteer.volor2 }">
                                            <input type="file" name="newfile2" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/>
                                        </c:if>
                                        <input type="file" id="showSelect2" name="refile2" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/> 
                                        
                                        <c:if test="${!empty volunteer.volor3 }">
                                        	<p id="original3">${  volunteer.volor3 }&nbsp;&nbsp;
                                        	<button class="deleteBtn" onclick="showFileSelect3(); deletefile3();"><i class="xi-cut"></i> 파일삭제</button></p>
                                        </c:if>
                                        <c:if test="${ empty volunteer.volor3 }">
                                            <input type="file" name="newfile3" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/>
                                        </c:if>
                                        <input type="file" id="showSelect3" name="refile3" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/> 
                                        
                                        <c:if test="${!empty volunteer.volor4 }">
                                        	<p id="original4">${  volunteer.volor4 }&nbsp;&nbsp;
                                        	<button class="deleteBtn" onclick="showFileSelect4(); deletefile4();"><i class="xi-cut"></i> 파일삭제</button></p>
                                        </c:if>
                                        <c:if test="${ empty volunteer.volor4 }">
                                            <input type="file" name="newfile4" class="mb5"accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/>
                                        </c:if>
                                        <input type="file" id="showSelect4" name="refile4" class="mb5" accept="image/jpeg,image/png,image/jpeg,image/bmp" onchange='chk_type(this);che_Size(this);'/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>*담당자</td>
                                        <td><input type="text" name="volwriter" value="${volunteer.volwriter}" class="form-control w50p" required readonly/></td>
                                    </tr>
                                    <tr>
                                        <td>*연락처</td>
                                        <td><input type="tel" name="voltel" value="${volunteer.voltel}" class="form-control w50p"  required/></td>
                                    </tr>
                                    <tr>
                                        <td>*센터명</td>
                                        <td><input type="text" name="volname" value="${volunteer.volname}" class="form-control w50p"  required readonly/></td>
                                    </tr>
                                    <tr>
                                        <td>*지역</td>
                                        <td><input type="text" name="voladdress" value="${volunteer.voladdress}" class="form-control w100p" placeholder="지역 입력" required readonly/></td>
                                    </tr>
                                    <tr>
                                        <td>*모집기간</td>
                                        <td><label><input type="radio" name="volche" value="y" ${volunteer.volche eq "y"?"checked":"" } />상시모집</label>
                                        	<label><input type="radio" name="volche" value="n" ${volunteer.volche eq "n"?"checked":"" } />모집완료</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>*봉사기간</td>
                                        <td><input type="date" name="volterm1" value="${volunteer.volterm1}" class="form-control w30p" required/>&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date" name="volterm2" value="${volunteer.volterm2}" class="form-control w30p" required/></td>
                                    </tr>
                                    <tr>
                                        <td>내용</td>
                                        <td><textarea name="volcontent" rows="" cols="" class="form-control" style="resize: none; width:100%; min-height:300px; max-height:300px;">${volunteer.volcontent}</textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="write-btn">
                            <input type="button" class="btn btn-list" onclick="javascript:history.go(-1); return false;" value="목록으로">
                            <input type="reset" class="btn btn-cancel" onclick="Refresh()" value="취소하기">
                            <input type="submit" class="btn btn-success" value="수정하기">
                        </div>
                        </form>
                        <!-- 글쓰기 끝 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	<script type="text/javascript">
	
	/* 첨부파일 선택창 숨기기 */
  	$(document).ready(function(){
  		$('#showSelect1').hide();
  		$('#showSelect2').hide();
  		$('#showSelect3').hide();
  		$('#showSelect4').hide();
  	});
  	
  	/* 파일 삭제 누르면 첨부파일 선택창 나오게 하기 */
  	function showFileSelect1(){
  		var files = document.getElementById("files");
  		var originalFile = document.getElementById("original1");
  		files.removeChild(originalFile);
  		$('#showSelect1').show();
  	}
  	function showFileSelect2(){
  		var files = document.getElementById("files");
  		var originalFile = document.getElementById("original2");
  		files.removeChild(originalFile);
  		$('#showSelect2').show();
  	}
  	function showFileSelect3(){
  		var files = document.getElementById("files");
  		var originalFile = document.getElementById("original3");
  		files.removeChild(originalFile);
  		$('#showSelect3').show();
  	}
  	function showFileSelect4(){
  		var files = document.getElementById("files");
  		var originalFile = document.getElementById("original4");
  		files.removeChild(originalFile);
  		$('#showSelect4').show();
  	}
  	
  	/* 삭제버튼 눌렀을때 original파일 이름 보내기 */
  	function deletefile1(){
  		var deleteFilename = '<c:out value="${volunteer.volor1}"/>';
  		var tag ="<input type='hidden' name='deleteFilename1' value='" + deleteFilename + "'>";
  		$("#inHere").append(tag);
  		console.log("1번 파일삭제" + deleteFilename + tag);
  	}
  	function deletefile2(){
  		var deleteFilename = '<c:out value="${volunteer.volor2}"/>';
  		var tag ="<input type='hidden' name='deleteFilename2' value='" + deleteFilename + "'>";
  		$("#inHere").append(tag);
  		console.log("2번 파일삭제" + deleteFilename + tag);
  	}
  	function deletefile3(){
  		var deleteFilename = '<c:out value="${volunteer.volor3}"/>';
  		var tag ="<input type='hidden' name='deleteFilename3' value='" + deleteFilename + "'>";
  		$("#inHere").append(tag);
  		console.log("3번 파일삭제" + deleteFilename + tag);
  	}	
  	function deletefile4(){
  		var deleteFilename = '<c:out value="${volunteer.volor4}"/>';
  		var tag ="<input type='hidden' name='deleteFilename4' value='" + deleteFilename + "'>";
  		$("#inHere").append(tag);
  		console.log("4번 파일삭제" + deleteFilename + tag);
  	}	
	
	/* 수정 최소하기 버튼 눌리면 새로고침하기 */
	function Refresh(){
		window.location.reload();
	}
	 </script>
	</body>
</html>