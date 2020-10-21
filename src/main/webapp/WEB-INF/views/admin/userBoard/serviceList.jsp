<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="listCount" value="${ requestScope.totalCount }" />
<c:set var="startPage"  value="${ requestScope.startPage }"/>
<c:set var="endPage"  value="${ requestScope.endPage }"/>
<c:set var="maxPage"  value="${ requestScope.maxPage }"/>
<c:set var="currentPage"  value="${ requestScope.currentPage }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <c:import url="/WEB-INF/views/admin/include/admin_head.jsp"/>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <c:import url="/WEB-INF/views/admin/include/admin_header.jsp"/>

        <div id="container">
            <c:import url="/WEB-INF/views/admin/include/admin_util.jsp"/>

            <!-- 상단 타이틀 -->
            <div class="pageTitle">
                <div class="adminPath">
                    <h3>자원봉사모집 관리</h3>
                    <h2>리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->
            
<script type="text/javascript">
//검색 분류 선택 확인
$(function(){
   $("[name='sel']").on("click", function(){
      if($("select[name='type'] option:selected").val().length == 0) {
         alert("분류를 선택해주세요");
         return false;
      }
   });
});

//(전체/선택) 삭제
function checkAll(){
	if($("input[name=checkAll]").is(":checked")){
		$("input[name=checkDel]").prop("checked", true);
	}else{
		$("input[name=checkDel]").prop("checked", false);
	}
}

function deleteAction(){
	var checkRow = "";
	$("input[name='checkDel']:checked").each(function(){
		checkRow = checkRow + $(this).val()+",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(","));
	
	if(checkRow == ""){
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	
	console.log("### checkRow => {"+checkRow+"}");
	
	if(confirm("삭제 하시겠습니까?"))
		location.href = "vdeleteche.ad?checkRow=" + checkRow ;
}
</script>
            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체 ${requestScope.totalCount}개</h4>
                    <form action="vlist.ad" method="get" id="">
                    <div class="searchBox">
                        <select name="searchFiled" class="ListSelect">
                                 <option value="voltitle" class="fontColor-dark" ${pageVO.searchFiled eq"voltitle"?"selected":""}>제목</option>
                                <option value="voladdress" class="fontColor-dark" ${pageVO.searchFiled eq"voladdress"?"selected":""}>지역</option>
                                <option value="volterm2" class="fontColor-dark"${pageVO.searchFiled eq"volterm2"?"selected":""}>기간</option>
                        </select>
                        <div>
                            <input type="text" name="searchValue" value ="${ pageVO.searchValue }"  placeholder="검색어를 입력해주세요.">
                            <button type="submit" name="sel" class="top-search"><i class="xi-search"></i></button>
                        </div>
                    </div>
                    </form>
                </div>
                <!-- 검색영역 끝 -->
                <table class="list">
                    <colgroup>
                        <col width="5%">
                        <col width="5%">
                        <col width="8%">
                        <col width="8%">
                        <col width="*">
                        <col width="8%">
                        <col width="8%">
                        <col width="15%">
                        <col width="8%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="checkBox"><input type="checkbox" name="checkAll" onclick="checkAll();"></th>
                            <th>번호</th>
                            <th>모집상태</th>
                            <th>썸네일</th>
                            <th>제목</th>
                            <th>센터명</th>
                            <th>지역</th>
                            <th>기간</th>
                            <th>등록일</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="9"></th>
                        </tr>
                    </thead>
                    <tbody>
                     <c:forEach var="v" items="${requestScope.Vlist}">
                     		<c:url var="vd" value="vdetail.ad">
                                  	<c:param name="volno" value="${ v.volno}"/>
                                  	<c:param name="pageNo" value="${ pageVO.pageNo }"/>
                          			<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
									<c:param name="volche" value="${ v.volche }"/>
                            </c:url>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="checkDel" id="" value="${v.volno }"></td>
                            <td class="number" onclick="location.href='${vd}'">${v.volno}</td>
                            <c:if test="${ v.volche eq'y'}">
                            <td class="kinds" onclick="location.href='${vd}'"><span class="protect">상시모집</span></td>
                            </c:if>
                             <c:if test="${ v.volche eq'n'}">
                            <td class="kinds" onclick="location.href='${vd}'"><span class="protect">모집완료</span></td>
                            </c:if>
                            <td class="thumbnail" onclick="location.href=''">
                            <c:if test="${ empty v.volre1 }">
                            	<img src="/runningdog/resources/images/common/noImage02.png" style="border:2px solid #ff92a8;">
                            </c:if>
                            <c:if test="${ !empty v.volre1 }">
                            	<img src="/runningdog/resources/vfiles/${v.volre1}">
                            </c:if>
                            </td>
                            <td class="title" onclick="location.href='${vd}'">${ v.voltitle }</td>
                            <td class="name" onclick="location.href='${vd}'">${v.volname}</td>
                            <td class="location" onclick="location.href='${vd}'">${v.voladdress}</td>
                            <td class="date" onclick="location.href='${vd}'">${v.volterm1}~${v.volterm2}</td>
                            <td class="date" onclick="location.href='${vd}'">${v.voldate}</td>
                        </tr>
                        
                     	<c:if test="${ listCount eq 0}">
                        <tr class="list-no">
							<td colspan="9">
								<p><img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
                    	</c:if>
                     </c:forEach>
                    </tbody>
                </table>
                <p class="warning_text"> *삭제된 게시물은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn" onclick="deleteAction();"><i class="xi-cut"></i> 선택삭제</button>
                </div>
                <!-- //버튼 -->

                <!-- 페이징 -->
                <c:if test="${listCount > 0}">
                        <dl class="list-paging">
					<dd>
						<c:if test="${pageVO.pageNo >0 }">
							<c:if test="${pageVO.startPageNo >5 }">
								<c:url var="VadminPage" value="vlist.ad">
									<c:param name="pageNo" value="${ pageVO.startPageNo-5 }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
								</c:url>
								<a href="${ VadminPage }"><i class="xi-angle-left"></i></a>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPageNo}"
								end="${ pageVO.endPageNo }" step="1">
								<c:url var="dl2" value="vlist.ad">
									<c:param name="pageNo" value="${ i }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
								</c:url>
								<c:choose>
									<c:when test="${i eq pageVO.pageNo }">
										<a href="${dl2}" class="active">${ i }</a>
									</c:when>
									<c:otherwise>
										<a href="${dl2}" class="">${ i }</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${pageVO.pageNo != pageVO.finalPageNo and pageVO.finalPageNo > 5}">
								<c:url var="dl3" value="vlist.ad">
									<c:param name="pageNo" value="${ pageVO.endPageNo +1 }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
								</c:url>
								<a href="${dl3 }"><i class="xi-angle-right"></i></a>
							</c:if>
						</c:if>
					</dd>
				</dl>
               </c:if>                        
                <!-- //페이징 -->

            </div>
        </div>
        <c:import url="/WEB-INF/views/admin/include/admin_footer.jsp"/>
    </div>
</body>
</html>