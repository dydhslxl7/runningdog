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
                                <li class="xi-angle-right"><a href=cknowlist.do>반려동물 상식</a></li>
                            </ul>
                        </div>
                        <h2><span>반려동물 상식</span></h2>
                        <h3>작은 천사들에게 필요한<br/>정보를 알기 쉽게 알려드려요.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        <!--서브 검색-->                
                        <div class="search_wrap">
                            <form action="cknowlist.do">
                            <select name="searchKnow">
                            	<option value="subject" class="fontColor-dark" ${ page.search eq 'subject' ? 'selected' : '' }>제목</option>
                            	<option value="comment" class="fontColor-dark" ${ page.search eq 'comment' ? 'selected' : '' }>내용</option>
                            </select>
                            <div class="search-box">
                                <input type="text" name="keyword" placeholder="검색어를 검색해주세요." value="${ page.keyword }" required >
                                <input type="hidden" name="animal" value="${ animal }">
                                <button type="submit" class="xi-search"></button>
                            </div>
                            </form>
                        </div>
                        <!--서브 검색 끝-->
                        
                        <div class="sort-area">  
                            <h4>전체 ${ page.listCount }개의 상식</h4>
                            <div>
                                <div>
                                
                                <form action="" name="">
                                <c:if test="${ animal eq 'dog' }">
                                    <a class="active" href="#none" onclick="moveSearchKnow('dog')">강아지</a>
                                    <a href="#none" onclick="moveSearchKnow('cat')">고양이</a>
                                    <a href="#none" onclick="moveSearchKnow('other')">기타</a>
                                </c:if>
                                <c:if test="${ animal eq 'cat' }">
                                    <a href="#none" onclick="moveSearchKnow('dog')">강아지</a>
                                    <a class="active" href="#none" onclick="moveSearchKnow('cat')">고양이</a>
                                    <a href="#none" onclick="moveSearchKnow('other')">기타</a>
                                </c:if>
                                <c:if test="${ animal eq 'other' }">
                                    <a href="#none" onclick="moveSearchKnow('dog')">강아지</a>
                                    <a href="#none" onclick="moveSearchKnow('cat')">고양이</a>
                                    <a class="active" href="#none" onclick="moveSearchKnow('other')">기타</a>
                                </c:if>
                                </form>
                                
                                </div>
                            </div>
                        </div>
                        
                        <!--리스트-->
                        <div class="list-area">
                            <table>
                                <colgroup>
                                    <col width="10%">
                                    <col width="*">
                                    <col width="20%">
                                </colgroup>
                                <tbody>
                                
                                	<!-- 상식 리스트 출력 -->
	                                <c:forEach items="${ requestScope.list }" var="c">
	                                	
	                                	<!-- 상세페이지 이동 -->
		                                <c:url var="cdeurl" value="cknowdetail.do">
		                                	<c:param name="title" value="${ c.title }" />
		                                	<c:param name="link" value="${ c.link }" />
		                                	<c:param name="readcount" value="${ c.readcount }" />
		                                </c:url>
	                                    <tr onclick="location.href='${ cdeurl }'">
	                                        <td class="number">${ c.no }</td>
	                                        <td class="title">
	                                            <h2><span>상식</span>${ c.title }</h2>
	                                            <ul>
	                                                <!-- <li>2020.08.28</li> -->
	                                                <li>조회수 : ${ c.readcount }</li>
	                                            </ul>
	                                        </td>
	                                        <td class="writerUser">작성자 : 유기견센터</td>
	                                    </tr>
	                                </c:forEach>
	                                
	                            	 <!-- 목록이 없을 때 -->
									<c:if test="${ page.listCount eq 0 }">
										<tr>
											<td colspan="3">
												<div class="list-no">
													<p>
														<img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" />
													</p>
													<h1>목록이 없습니다.</h1>
												</div>
											</td>
										</tr>
									</c:if>
                                    
                                </tbody>
                            </table>
                        </div>
                        <!-- 리스트 끝 -->
                    
					<!-- 페이징 -->
					<dl class="list-paging">
						<dd>
							<!-- 이전 그룹 페이지 이동 -->
							<c:if test="${ (page.currentPage - 5) lt page.startPage and (page.currentPage - 5) ge 1 }">
								<c:url var="npurl1" value="cknowlist.do">
									<c:param name="page" value="${ page.startPage - 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="animal" value="${ animal }" />
									<c:param name="searchKnow" value="${ page.search }" />
									<c:param name="keyword" value="${ page.keyword }" />
								</c:url>
								<a href="${ npurl1 }"><i class="xi-angle-left"></i></a>
							</c:if>
							<%-- <c:if test="${ !((page.currentPage - 5) lt page.startPage and (page.currentPage - 5) >= 1) }">
								 	<a href="#none"><i class="xi-angle-left"></i></a>
								</c:if> --%>

							<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리  -->
							<c:forEach var="p" begin="${ page.startPage }" end="${ page.endPage }" step="1">
								<c:if test="${ p eq page.currentPage }">
									<a href="#none" class="active">${ p }</a>
								</c:if>
								<c:if test="${ p ne page.currentPage }">
									<c:url var="npurl2" value="cknowlist.do">
										<c:param name="page" value="${ p }" />
										<!-- 검색값 유지 -->
										<c:param name="animal" value="${ animal }" />
										<c:param name="searchKnow" value="${ page.search }" />
										<c:param name="keyword" value="${ page.keyword }" />
									</c:url>
									<a href="${ npurl2 }">${ p }</a>
								</c:if>
							</c:forEach>

							<!-- 다음 그룹 페이지 이동 -->
							<c:if test="${ (page.currentPage + 5) gt page.endPage and page.endPage lt page.maxPage }">
								<c:url var="npurl3" value="cknowlist.do">
									<c:param name="page" value="${ page.startPage + 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="animal" value="${ animal }" />
									<c:param name="searchKnow" value="${ page.search }" />
									<c:param name="keyword" value="${ page.keyword }" />
								</c:url>
								<a href="${ npurl3 }"><i class="xi-angle-right"></i></a>
							</c:if>
							<%-- <c:if test="${ !((page.currentPage + 5) > page.endPage and page.endPage < page.maxPage) }">
									<a href="#none"><i class="xi-angle-right"></i></a>
								</c:if> --%>
						</dd>
					</dl>
					<!-- //페이징 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>