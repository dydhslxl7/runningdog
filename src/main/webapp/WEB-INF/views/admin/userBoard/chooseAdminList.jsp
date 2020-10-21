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
                    <h3>유기동물 주인찾기 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체 게시물 : ${ requestScope.totalCount }</h4>
                    <form action="dboardList.ad" method="" id="">
                    <div class="searchBox">
                        <select name="searchFiled" class="ListSelect">
                               <option value="d_title" class="fontColor-dark" ${pageVO.searchFiled eq"d_title"?"selected":""}>제목</option>
                               <option value="d_writer" class="fontColor-dark" ${pageVO.searchFiled eq"d_writer"?"selected":""}>임시보호자</option>
                               <option value="d_find_local" class="fontColor-dark" ${pageVO.searchFiled eq"d_find_local"?"selected":""}>발견지역</option>
                        </select>
                        <div>
                            <input type="text"id="searchI" name="searchValue" value ="${ pageVO.searchValue }" placeholder="검색어를 입력해주세요.">
                            <button type="submit" class="top-search"><i class="xi-search"></i></button>
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
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th class="checkBox"><input type="checkbox" name="checkHideAll" id="checkHideAll" onclick="checkHideAll();"></th>
							<th>번호</th>
							<th>분류</th>
							<th>썸네일</th>
							<th>제목</th>
							<th>임시보호자</th>
							<th>등록일</th>
						</tr>
						<tr>
						</tr>
						<tr class="hr">
							<th colspan="8"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
						
						<!-- 관리자용 게시물 번호를 따로 만들기 위해서 listNo 생성 -->
							<c:set var="listNo" value="${ totalCount - ( 10*(pageVO.pageNo-1)) }" />
							<c:forEach items="${requestScope.dboardList }" var="d">
								<c:url var="dboardView" value="dboardView.ad">
									<c:param name="pageNo" value="${ pageVO.pageNo }"/>
                                 	<c:param name="dNum" value="${ d.dNum }"/>
                                 	<c:param name="searchFiled" value="${ pageVO.searchFiled }" />
									<c:param name="searchValue" value="${ pageVO.searchValue }" />
									<c:param name="category" value="${ pageVO.category }"/>
								</c:url>
								<td class="checkBox">
								<input type="checkbox" name="checkHide" id="" value="${ d.dNum }"></td>
								<td class="number" onclick="location='${ dboardView }'">${ listNo }</td>
								<td class="kinds" onclick="location='${ dboardView }'">
								<c:if test="${d.dSuccess eq 'n'}">
										<span class="protect">보호중</span></td>
								</c:if>
								<c:if test="${d.dSuccess eq 'y'}">
									<span class="complete">인계완료</span></td>
								</c:if>

								<td class="thumbnail" onclick="location='${ dboardView }'"><img src="/runningdog/resources/dboard/dboardImage/${d.listImage }"></td>
								<td class="title" onclick="location='${ dboardView }'">${ d.dCheck eq 'n' ? '[숨김]' : "[표시중]" }${ d.dTitle }</td>
								<td class="name" onclick="location='${ dboardView }'">${ d.dWriter }/${ d.uniqueNum }</td>
								<td class="date" onclick="location='${ dboardView }'">${ d.dDate }</td>
								<c:set var="listNo" value="${listNo -1 }" /></tr>
						</c:forEach>
						<c:if test="${ listCount eq 0 }">
							<tr class="list-no">
								<td colspan="8">
									<p>
										<img src="/WEB-INF/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" />
									</p>
									<h1>목록이 없습니다.</h1>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<p class="warning_text"> *게시물 표시 여부 업데이트 입니다.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn" onclick="dboardHide(${ pageVO.pageNo })"><i class="xi-cut"></i> 표시업데이트</button>
                    <button type="button" id="" class="btn-right writeBtn" onclick="location='dinsertPage.ad'"><i class="xi-pen-o"></i> 글작성</button>
                </div>
                <!-- //버튼 -->

                <!-- 페이징 -->
				<dl class="list-paging">
					<dd>
						<c:if test="${pageVO.pageNo >0 }">
							<c:if test="${pageVO.startPageNo >5 }">
								<c:url var="adminPage" value="dboardList.ad">
									<c:param name="pageNo" value="${ pageVO.startPageNo-5 }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
									<c:param name="category" value="${pageVO.category }" />
									<c:param name="local" value="${ pageVO.local }" />
								</c:url>
								<a href="${ adminPage }"><i class="xi-angle-left"></i></a>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPageNo}"
								end="${ pageVO.endPageNo }" step="1">
								<c:url var="dl2" value="dboardList.ad">
									<c:param name="pageNo" value="${ i }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
									<c:param name="category" value="${pageVO.category }" />
									<c:param name="local" value="${ pageVO.local }" />
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
							<c:if test="${pageVO.pageNo != pageVO.finalPageNo and pageVO.finalPageNo > 5 and pageVO.endPageNo != pageVO.finalPageNo}">
								<c:url var="dl3" value="dboardList.ad">
									<c:param name="pageNo" value="${ pageVO.endPageNo +1 }" />
									<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
									<c:param name="category" value="${pageVO.category }" />
									<c:param name="local" value="${ pageVO.local }" />
								</c:url>
								<a href="${dl3 }"><i class="xi-angle-right"></i></a>
							</c:if>
						</c:if>
					</dd>
				</dl>
				<!-- //페이징 -->

            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>