<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
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
                    <h3>오늘의 이슈 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체 게시물 ${ page.listCount }개</h4>
                    <form action="cissuelist.do" method="get" id="">
	                    <div class="searchBox">
							<select name="searchOrder" class="ListSelect" id="searchOrder">
								<option value="order" ${ page.search eq 'order' ? 'selected' : '' }>발행순</option>
								<option value="view"	${ page.search eq 'view' ? 'selected' : '' }>인기순</option>
							</select>
						</div>
					</form>
                </div>
                
                <!-- 검색영역 끝 -->
                <table class="list">
                    <colgroup>
                        <col width="8%">
                        <col width="*">
                        <col width="8%">
                        <col width="10%">
                        <col width="10%">
                        <col width="8%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>썸네일</th>
                            <th>제목</th>
                            <th>작성자 썸네일</th>
                            <th>작성자</th>
                            <th>등록일</th>
                            <th>조회수</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="7"></th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    <!-- 이슈 리스트 출력 -->
                    <c:forEach items="${ requestScope.list }" var="c">
                        <c:url var="cdeurl" value="cissuedetail.ad">
	                       	<c:param name="link" value="${ c.issueLink }" />
                      	</c:url>
                        <tr onclick="location='${cdeurl}'">
                            <td class="thumbnail"><img src="${ c.issueThumbnail }"></td>
                            <td class="title">${ c.issueTitle }</td>
                            <td class="thumbnail"><img src="${ c.partnerImg }"></td>
                            <td class="name">${ c.partnerName }</td>
                            
                        <c:if test="${ page.search eq 'order'}">
                            <td class="date">${ c.issueDate }</td>
                            <td class="views">x</td>
                        </c:if>
                          
                        <c:if test="${ page.search eq 'view'}">
                          	 <td class="date">x</td>
                             <td class="views"><fmt:formatNumber value="${ c.issueReadcount }" groupingUsed="true"/></td>
                        </c:if>
                            
                        </tr>
                     </c:forEach>
                        
                    </tbody>
                </table>
               <!--  <p class="warning_text"> *삭제된 게시물은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p> -->
                <!-- //게시판 -->

                        <!-- 페이징 -->
                        <dl class="list-paging">
                            <dd>
	                            <!-- 이전 그룹 페이지 이동 -->
								<c:if test="${ (page.currentPage - 5) lt page.startPage and (page.currentPage - 5) ge 1 }">
									<c:url var="npurl1" value="cissuelist.ad">
										<c:param name="page" value="${ page.startPage - 5 }" />
										<c:param name="order" value="${ page.search }"/>
									</c:url>
									<a href="${ npurl1 }"><i class="xi-angle-left"></i></a>
								</c:if>
                                
								<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리  -->
								<c:forEach var="p" begin="${ page.startPage }" end="${ page.endPage }" step="1">
									<c:if test="${ p eq page.currentPage }">
										<a href="#none" class="active">${ p }</a>
									</c:if>
									<c:if test="${ p ne page.currentPage }">
										<c:url var="npurl2" value="cissuelist.ad">
											<c:param name="page" value="${ p }" />
											<c:param name="order" value="${ page.search }"/>
										</c:url>
										<a href="${ npurl2 }">${ p }</a>
									</c:if>
								</c:forEach>
								
	                            <!-- 다음 그룹 페이지 이동 -->
								<c:if test="${ (page.currentPage + 5) gt page.endPage and page.endPage lt page.maxPage }">
									<c:url var="npurl3" value="cissuelist.ad">
										<c:param name="page" value="${ page.startPage + 5 }" />
										<c:param name="order" value="${ page.search }"/>
									</c:url>
									<a href="${ npurl3 }"><i class="xi-angle-right"></i></a>
								</c:if>
							
                            </dd>
                        </dl>
                        <!-- //페이징 -->
            </div>
        </div>
        <c:import url="/WEB-INF/views/admin/include/admin_footer.jsp"/>
    </div>
</body>
</html>