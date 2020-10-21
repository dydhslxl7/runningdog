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
                    <h3>전체회원 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체회원 ${ memberPage.listCount }명</h4>
                    <form action="" id="">
                    <div class="searchBox">
                        <select name="memberSearch" class="ListSelect">                        
								<!-- 검색분류가 비었을 경우 -->
								<c:if test="${ empty memberPage.search or memberPage.search eq null}">
		                            <option value="userId">아이디(이메일)</option>
		                            <option value="nickname">닉네임</option>
		                            <option value="phone">휴대폰번호</option>
								</c:if>
								<!-- 검색분류가 있을 경우 해당값 선택되어있게 하기 -->
								<c:if test="${ !empty memberPage.search }">
		                            <option value="userId" ${ memberPage.search eq 'userId' ? 'selected' : '' }>아이디(이메일)</option>
		                            <option value="nickname" ${ memberPage.search eq 'nickname' ? 'selected' : '' }>닉네임</option>
		                            <option value="phone" ${ memberPage.search eq 'phone' ? 'selected' : '' }>휴대폰번호</option>
								</c:if>
                        </select>
                        <div>
                            <input type="text" name="keyword" placeholder="검색어를 입력해주세요." value="${ memberPage.keyword }">
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
                        <col width="*">
                        <col width="10%">
                        <col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <col width="6%">
                        <col width="5%">
                        <col width="5%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>번호</th>
                            <th>아이디(이메일)</th>
                            <th>닉네임</th>
                            <th>휴대폰번호</th>
                            <th>가입일</th>
                            <th>최근접속일</th>
                            <th>로그인유형</th>
                            <th>접근제한</th>
                            <th>관리자</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="10"></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:if test="${ list.size() ne 0 }">
					    <c:set var="listNo" value="${ memberPage.listCount - (memberPage.listLimit *( memberPage.currentPage - 1)) }"/>
                   		<c:forEach var="member" items="${ requestScope.list }">
	                       <tr>
							<c:url var="memberView" value="adminMemberView.ad">
								<c:param name="uniqueNum" value="${ member.uniqueNum }" />
								<c:param name="page" value="${ page }" />
							</c:url>
								<td class="checkBox"><input type="checkbox" name="leaveChk" id="${ member.uniqueNum }" value=""></td>
								<td class="number" onclick="location='${ memberView }'">${ listNo }</td>
								<td class="userId" onclick="location='${ memberView }'">${ member.userId }</td>
								
								<c:if test="${ member.renameProfile eq null }">
								<td class="userName" onclick="location='${ memberView }'"><img src="/runningdog/resources/images/common/userBg.png"/>${ member.nickname }</td>
								</c:if>
								<c:if test="${ member.renameProfile ne null }">
								<c:if test="${ member.loginType eq null or member.loginType eq 'facebook' }">
								<td class="userName" onclick="location='${ memberView }'"><img src="/runningdog/resources/images/memberImg/${member.renameProfile}"/>${ member.nickname }</td>
								</c:if>
								<c:if test="${ member.loginType ne null and member.loginType ne 'facebook' }">
								<td class="userName" onclick="location='${ memberView }'"><img src="${member.renameProfile}"/>${ member.nickname }</td>
								</c:if>
								</c:if>
								
								<td class="phone" onclick="location='${ memberView }'">${ member.phone }</td>
								<td class="joinDate" onclick="location='${ memberView }'"><fmt:formatDate pattern="yyyy.MM.dd" value="${ member.joinDate }"/></td>
								<td class="lastAccessDate" onclick="location='${ memberView }'"><fmt:formatDate pattern="yyyy.MM.dd" value="${ member.lastAccessDate }"/></td>
								<c:if test="${ member.loginType eq 'kakao' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-kakaotalk"></i></td>
								</c:if>
								<c:if test="${ member.loginType eq 'facebook' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-facebook-official"></i></td>
								</c:if>
								<c:if test="${ member.loginType eq 'naver' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-naver-square"></i></td>
								</c:if>
								<c:if test="${ member.loginType eq null }">
								<td class="loginType" onclick="location='${ memberView }'">일반</td>
								</c:if>
								
								<c:if test="${ member.loginLimit == 'Y'}">
								<td class="loginLimit" onclick="location='${ memberView }'"><i class="xi-check-circle-o"></i></td>
								</c:if>
								<c:if test="${ member.loginLimit == 'N'}">
								<td class="loginLimit" onclick="location='${ memberView }'"></td>
								</c:if>
								
								<c:if test="${ member.adminChk == 'Y'}">
								<td class="adminChk" onclick="location='${ memberView }'"><i class="xi-check-circle-o"></i></td>
								
								</c:if>
								<c:if test="${ member.adminChk == 'N'}">
								<td class="adminChk" onclick="location='${ memberView }'"></td>
								</c:if>
							<c:set var="listNo" value="${listNo - 1}"/>
							</tr>
	                   	</c:forEach>
						</c:if>
                    	<c:if test="${ list.size() eq 0 }">
						<tr class="list-no">
							<td colspan="10">
								<p><img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
						</c:if>
                    </tbody>
                </table>
                <p class="warning_text"> *탈퇴된 회원은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn" onclick="leaveChkAction()"><i class="xi-cut"></i> 선택탈퇴</button>
                    <button type="button" id="" class="btn-right writeBtn" onclick="location='adminMemberInsert.ad'"><i class="xi-pen-o"></i> 회원추가</button>
                </div>
                <!-- //버튼 -->

                <!-- 페이징 -->
                <dl class="list-paging">
                    <dd>
                   	<c:if test="${ 1 < memberPage.currentPage}">
                   		<c:url var="prevPaging" value="memberAllList.ad">
						<c:param name="page" value="${ memberPage.currentPage - 1 }" />
						<!-- 검색값 유지 -->
						<c:param name="memberSearch" value="${ memberPage.search }" />
						<c:param name="keyword" value="${ memberPage.keyword }" />
                   		<a href="${ prevPaging }"><i class="xi-angle-left"></i></a>
                  		</c:url>
                   		<a href="${ prevPaging }"><i class="xi-angle-left"></i></a>
                    </c:if>
                   	<c:if test="${ memberPage.currentPage == 1 }">
                   		<a href="#none"><i class="xi-angle-left"></i></a>
                    </c:if>
                    
                   	<c:forEach var="p" begin="${ memberPage.startPage }" end="${ memberPage.endPage }">
                   		<c:if test="${ p ne memberPage.currentPage }">
							<c:url var="memberPaging" value="memberAllList.ad">
								<c:param name="page" value="${ p }" />
								<!-- 검색값 유지 -->
								<c:param name="memberSearch" value="${ memberPage.search }" />
								<c:param name="keyword" value="${ memberPage.keyword }" />
							</c:url>
							<a href="${ memberPaging }">${ p }</a>
                    	</c:if>
                    </c:forEach>
               		<c:if test="${ memberPage.listCount eq 0 }">
                    <a href="#none" class="active">1</a>
                    </c:if>
                    
					
                   	<c:if test="${ memberPage.currentPage < memberPage.maxPage }">
                   	<c:url var="nextPaging" value="memberAllList.ad">
						<c:param name="page" value="${ memberPage.currentPage + 1 }" />
						<!-- 검색값 유지 -->
						<c:param name="memberSearch" value="${ memberPage.search }" />
						<c:param name="keyword" value="${ memberPage.keyword }" />
                  		</c:url>
                        <a href="${ nextPaging }"><i class="xi-angle-right"></i></a>
                    </c:if>
                   	<c:if test="${ memberPage.currentPage >= memberPage.maxPage }">
                   		<a href="#none"><i class="xi-angle-right"></i></a>
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