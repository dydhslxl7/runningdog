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
                    <h3>탈퇴회원 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>탈퇴회원 ${ memberPage.listCount }명</h4>
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
		                            <option value="userId" ${ memberPage.search eq 'leaveUserId' ? 'selected' : '' }>아이디(이메일)</option>
		                            <option value="nickname" ${ memberPage.search eq 'leaveNickname' ? 'selected' : '' }>닉네임</option>
		                            <option value="phone" ${ memberPage.search eq 'leavePhone' ? 'selected' : '' }>휴대폰번호</option>
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
                <table class="list listTwo">
                    <colgroup>
                        <col width="5%">
                        <col width="5%">
                        <col width="*">
                        <col width="10%">
                        <col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <col width="8%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>번호</th>
                            <th>아이디(이메일)</th>
                            <th>닉네임</th>
                            <th>휴대폰번호</th>
                            <th>가입일</th>
                            <th>탈퇴일</th>
                            <th>로그인유형</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="8"></th>
                        </tr>
                    </thead>
                    <tbody>
                        
                    	<c:if test="${ list.size() ne 0 }">
					    <c:set var="listNo" value="${ memberPage.listCount - (memberPage.listLimit *( memberPage.currentPage - 1)) }"/>
                   		<c:forEach var="leaveMember" items="${ requestScope.list }">
	                       <tr>
							<c:url var="memberView" value="adminMemberLeaveView.ad">
								<c:param name="leaveUniqueNum" value="${ leaveMember.leaveUniqueNum }" />
								<c:param name="page" value="${ page }" />
							</c:url>
								<td class="checkBox"><input type="checkbox" name="deleteChk" id="${ leaveMember.leaveUniqueNum }" value=""></td>
								<td class="number" onclick="location='${ memberView }'">${ listNo }</td>
								<td class="userId" onclick="location='${ memberView }'">${ leaveMember.leaveUserId }</td>
	                           
	                           
                        		<c:if test="${ leaveMember.leaveRenameProfile eq null }">
								<td class="userName" onclick="location='${ memberView }'"><img src="/runningdog/resources/images/common/userBg.png"/>${ leaveMember.leaveNickname }</td>
								</c:if>
								<c:if test="${ leaveMember.leaveRenameProfile ne null }">
								<c:if test="${ leaveMember.leaveLoginType eq null or leaveMember.leaveLoginType eq 'facebook' }">
								<td class="userName" onclick="location='${ memberView }'"><img src="/runningdog/resources/images/memberImg/${leaveMember.leaveRenameProfile}"/>${ leaveMember.leaveNickname }</td>
								</c:if>
								<c:if test="${ leaveMember.leaveLoginType ne null and leaveMember.leaveLoginType ne 'facebook' }">
								<td class="userName" onclick="location='${ memberView }'"><img src="${leaveMember.leaveRenameProfile}"/>${ leaveMember.leaveNickname }</td>
								</c:if>
								</c:if>
								
								<td class="phone" onclick="location='${ memberView }'">${ leaveMember.leavePhone }</td>
								<td class="joinDate" onclick="location='${ memberView }'"><fmt:formatDate pattern="yyyy.MM.dd" value="${ leaveMember.leaveJoinDate }"/></td>
								<td class="leaveDate" onclick="location='${ memberView }'"><fmt:formatDate pattern="yyyy.MM.dd" value="${ leaveMember.leaveDate }"/></td>
								<c:if test="${ leaveMember.leaveLoginType eq 'kakao' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-kakaotalk"></i></td>
								</c:if>
								<c:if test="${ leaveMember.leaveLoginType eq 'facebook' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-facebook-official"></i></td>
								</c:if>
								<c:if test="${ leaveMember.leaveLoginType eq 'naver' }">
								<td class="loginType" onclick="location='${ memberView }'"><i class="xi-naver-square"></i></td>
								</c:if>
								<c:if test="${ leaveMember.leaveLoginType eq null }">
								<td class="loginType" onclick="location='${ memberView }'">일반</td>
								</c:if>
	                       <c:set var="listNo" value="${listNo - 1}"/>
	                       </tr>
	                   	</c:forEach>
						</c:if>
                        
                    	<c:if test="${ list.size() eq 0 }">
						<tr class="list-no">
							<td colspan="8">
								<p><img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
						</c:if>
                    </tbody>
                </table>
                <p class="warning_text"> *탈퇴회원의 정보를 DB에서 삭제하시려면 삭제버튼을 눌러주세요.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn" onclick="deleteChkAction()"><i class="xi-cut"></i> 선택삭제</button>
                </div>
                <!-- //버튼 -->
                
                <!-- 페이징 -->
                <dl class="list-paging">
                    <dd>
                   	<c:if test="${ 1 < memberPage.currentPage}">
                   		<c:url var="prevPaging" value="memberLeaveList.ad">
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
							<c:url var="memberPaging" value="memberLeaveList.ad">
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
                   	<c:url var="nextPaging" value="memberLeaveList.ad">
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