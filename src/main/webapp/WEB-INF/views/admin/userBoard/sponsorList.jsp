<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="page" value="${ page }"/>
<c:set var="totalList" value="${ totalList }"/>
<c:set var="totalPage" value="${ totalPage }"/>
<c:set var="startPage" value="${ startPage }"/>
<c:set var="endPage" value="${ endPage }"/>
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
                    <h3>후원하기 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체 게시물 ${ totalList }개</h4>
                    <form action="ssearch.ad">
                    <div class="searchBox">
                        	<select name="selected">
								<option value="" selected disabled>분류 선택</option>
                            	<option value="title" class="fontColor-dark">제목</option>
                            	<option value="content" class="fontColor-dark">내용</option>
                            </select>
                        <div>
                            <input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
                            <button id='seld' type="submit" class="top-search"><i class="xi-search"></i></button>
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
                        <col width="10%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="checkBox"><input type="checkbox" name="checkAll" onclick="checkAll();"></th>
                            <th>번호</th>
                            <th>분류</th>
                            <th>썸네일</th>
                            <th>제목</th>
                            <th>목표금액</th>
                            <th>모집금액</th>
                            <th>작성자</th>
                            <th>등록일</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="9"></th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<c:if test="${ list.size() ne 0 }">
	                    	<c:forEach var="s" items="${ list }">
		                        <tr>
		                        	<c:url var="sdt" value="asdetial.ad">
                                    	<c:param name="sNum" value="${ s.sNum }"/>
                                    	<c:param name="page" value="${ page }" />
                                    </c:url>
		                        	<td class="checkBox"><input type="checkbox" name="checkDel" value="${ s.sNum }"></td>
			                        <td class="number" onclick="location='${ sdt }'">${ s.sNum }</td>
			                        <c:if test="${ s.sAmount > s.sCurrent }">
			                        	<td class="kinds" onclick="location='${ sdt }'"><span class="protect">후원중</span></td>
			                        </c:if>
			                        <c:if test="${ s.sAmount <= s.sCurrent }">
			                            <td class="kinds" onclick="location='${ sdt }'"><span class="complete">후원마감</span></td>
			                        </c:if>
			                        <td class="thumbnail" onclick="location='${ sdt }'"><img src="resources\\sponsor\\thumbnail/${ s.sRename }"></td>
			                        <td class="title" onclick="location='${ sdt }'">${ s.sTitle }</td>
			                        <td class="name" onclick="location='${ sdt }'">${ s.sAmount } 원</td>
			                        <td class="name" onclick="location='${ sdt }'">${ s.sCurrent } 원</td>
			                        <td class="name" onclick="location='${ sdt }'">${ s.sId }</td>
			                        <td class="date" onclick="location='${ sdt }'"><fmt:formatDate value="${ s.sDate }" pattern="yyyy.MM.dd"/></td>
		                        </tr>
	                        </c:forEach>
                        </c:if>
                        
                        <c:if test="${ list.size() eq 0 }">
						<tr class="list-no">
							<td colspan="9">
								<p><img src="resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
						</c:if>
                    </tbody>
                </table>
                <p class="warning_text"> *삭제된 게시물은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn" onclick="deleteAction(${ page });"><i class="xi-cut"></i> 선택삭제</button>
                    <button type="button" id="" class="btn-right writeBtn" onclick="location='aswrite.ad'"><i class="xi-pen-o"></i> 글작성</button>
                </div>
                <!-- //버튼 -->

                <!-- 페이징 -->
                <c:if test="${ totalPage <= 1 }"><br><br></c:if>
                	<!-- 검색x 페이징 -->
               <c:if test="${ empty selected && totalPage > 1 }">
					<dl class="list-paging">
						<dd>
							<c:if test="${ page > 1 }">
								<c:url var="sl1" value="aslist.ad">
									<c:param name="page" value="1" />
								</c:url>
								<a href="${ sl1 }"><i class="xi-angle-left"></i></a>
							</c:if>
							<c:if test="${ page eq 1 }">
								<a><i class="xi-angle-left"></i></a>
							</c:if>

							<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
								step="1">
								<c:if test="${ page eq p }">
									<a class="active">${ p }</a>
								</c:if>
								<c:if test="${ page ne p }">
									<c:url var="sl2" value="aslist.ad">
										<c:param value="${ p }" name="page" />
									</c:url>
									<a href="${ sl2 }">${ p }</a>
								</c:if>
							</c:forEach>

							<c:if test="${ page < totalPage }">
								<c:url var="sl3" value="aslist.ad">
									<c:param name="page" value="${ totalPage }" />
								</c:url>
								<a href="${ sl3 }"><i class="xi-angle-right"></i></a>
							</c:if>
							<c:if test="${ page eq totalPage }">
								<a><i class="xi-angle-right"></i></a>
							</c:if>
						</dd>
					</dl>
				</c:if>
				
				<!-- 검색 페이징 -->
				<c:if test="${ !empty selected && totalPage > 1 }">
					<dl class="list-paging">
						<dd>
							<c:if test="${ page > 1 }">
								<c:url var="ss1" value="ssearch.ad">
									<c:param name="page" value="1" />
									<c:param name="selected" value="${ selected }" />
									<c:param name="keyword" value="${ keyword }" />
								</c:url>
								<a href="${ ss1 }"><i class="xi-angle-left"></i></a>
							</c:if>
							<c:if test="${ page eq 1 }">
								<a><i class="xi-angle-left"></i></a>
							</c:if>

							<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
								step="1">
								<c:if test="${ page eq p }">
									<a class="active">${ p }</a>
								</c:if>
								<c:if test="${ page ne p }">
									<c:url var="ss2" value="ssearch.ad">
										<c:param value="${ p }" name="page" />
										<c:param name="selected" value="${ selected }" />
										<c:param name="keyword" value="${ keyword }" />
									</c:url>
									<a href="${ ss2 }">${ p }</a>
								</c:if>
							</c:forEach>

							<c:if test="${ page < totalPage }">
								<c:url var="ss3" value="ssearch.ad">
									<c:param name="page" value="${ totalPage }" />
									<c:param name="selected" value="${ selected }" />
									<c:param name="keyword" value="${ keyword }" />
								</c:url>
								<a href="${ ss3 }"><i class="xi-angle-right"></i></a>
							</c:if>
							<c:if test="${ page eq totalPage }">
								<a><i class="xi-angle-right"></i></a>
							</c:if>
						</dd>
					</dl>
				</c:if>
                <!-- //페이징 -->

            </div>
        </div>
        <c:import url="../include/admin_footer.jsp"/>
    </div>
</body>
</html>