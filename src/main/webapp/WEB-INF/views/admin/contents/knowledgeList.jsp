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
                    <h3>반려동물 상식 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체 게시물 ${ page.listCount }개</h4>
                    <form action="cknowlist.do" method="get" id="">
	                    <div class="searchBox">
							<select name="searchAnimal" class="ListSelect" id="searchAnimal">
								<option value="dog" ${ animal eq 'dog' ? 'selected' : '' }>강아지</option>
								<option value="cat"	${ animal eq 'cat' ? 'selected' : '' }>고양이</option>
								<option value="other" ${ animal eq 'other' ? 'selected' : '' }>기타</option>
							</select>
	 						<select name="searchKnow" class="ListSelect">
                            	<option value="subject" class="fontColor-dark" ${ page.search eq 'subject' ? 'selected' : '' }>제목</option>
                            	<option value="comment" class="fontColor-dark" ${ page.search eq 'comment' ? 'selected' : '' }>내용</option>
                            </select>

							<div>
								<input type="text" name="keyword" placeholder="검색어를 입력해주세요." value="${ page.keyword }">
								<input type="hidden" name="animal" value="${ animal }">
								<button type="submit" class="top-search">
									<i class="xi-search"></i>
								</button>
							</div>
						</div>
					</form>
                </div>
                <!-- 검색영역 끝 -->
                
                <table class="list">
                    <colgroup>
                        <col width="5%">
                        <col width="8%">
                        <col width="*">
                        <col width="15%">
                        <col width="10%">
                        <col width="8%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>분류</th>
                            <th>제목</th>
                            <th>작성인</th>
                            <th>등록일</th>
                            <th>조회수</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="6"></th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    <!-- 상식 리스트 출력 -->
	                <c:forEach items="${ requestScope.list }" var="c">
	                    <c:url var="cdeurl" value="cknowdetail.ad">
                            <c:param name="title" value="${ c.title }" />
                            <c:param name="link" value="${ c.link }" />
                            <c:param name="readcount" value="${ c.readcount }" />
		                </c:url>
                        <tr onclick="location='${cdeurl}'">
                            <td class="number">${ c.no }</td>
                            <td class="kinds"><span class="protect">상식</span></td>
                            <td class="title">${ c.title }</td>
                            <td class="name">유기견센터</td>
                            <td class="date">x</td>
                            <td class="views">${ c.readcount }</td>
                        </tr>
                    </c:forEach>
                    <!-- 목록이 없을 때 -->
					<c:if test="${ page.listCount eq 0 }">
						<tr class="list-no">
							<td colspan="6">
								<p>
									<img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" />
								</p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
					</c:if>
						
                    </tbody>
                </table>
                <!-- <p class="warning_text"> *삭제된 게시물은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p> -->
                <!-- //게시판 -->

					<!-- 페이징 -->
					<dl class="list-paging">
						<dd>
							<!-- 이전 그룹 페이지 이동 -->
							<c:if test="${ (page.currentPage - 5) lt page.startPage and (page.currentPage - 5) ge 1 }">
								<c:url var="npurl1" value="cknowlist.ad">
									<c:param name="page" value="${ page.startPage - 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="animal" value="${ animal }" />
									<c:param name="searchKnow" value="${ page.search }" />
									<c:param name="keyword" value="${ page.keyword }" />
								</c:url>
								<a href="${ npurl1 }"><i class="xi-angle-left"></i></a>
							</c:if>

							<!-- 현재 페이지가 속한 페이지그룹의 숫자 출력 처리  -->
							<c:forEach var="p" begin="${ page.startPage }" end="${ page.endPage }" step="1">
								<c:if test="${ p eq page.currentPage }">
									<a href="#none" class="active">${ p }</a>
								</c:if>
								<c:if test="${ p ne page.currentPage }">
									<c:url var="npurl2" value="cknowlist.ad">
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
								<c:url var="npurl3" value="cknowlist.ad">
									<c:param name="page" value="${ page.startPage + 5 }" />
									<!-- 검색값 유지 -->
									<c:param name="animal" value="${ animal }" />
									<c:param name="searchKnow" value="${ page.search }" />
									<c:param name="keyword" value="${ page.keyword }" />
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