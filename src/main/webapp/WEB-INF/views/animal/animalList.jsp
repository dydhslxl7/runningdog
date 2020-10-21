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
                                <li class="xi-angle-right"><a href="animalList.do">유기동물정보</a></li>
                            </ul>
                        </div>
                        <h2><span>유기동물정보</span></h2>
                        <h3>가족을 기다리는 작은 천사에게<br/>가족과 친구가 되어주세요.</h3>
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
                            <form action="animalList.do" name="">
                            <select name="searchFiled" id = "searchS">
                                <option value="kind_cd" class="fontColor-dark" ${ pageVO.searchFiled eq "kindCd" ? "selected":"" }>견종</option>
                                <option value="care_addr" class="fontColor-dark" ${ pageVO.searchFiled eq "careAddr" ? "selected" : ""}>지역</option>
                                <option value="care_nm" class="fontColor-dark"${ pageVO.searchFiled eq "careNm" ? "selected" : "" }>보호센터</option>
                            </select>
                            <div class="search-box">
                                <input type="text" id="searchI" name="searchValue" value="${ pageVO.searchValue }" placeholder="작은 천사들을 검색해주세요.">
                                <button type="submit" value="SEARCH" class="xi-search"></button>
                            </div>
                            </form>
                        </div>
                        <!--서브 검색 끝-->
                        
                        <div class="sort-area">  
                            <h4>전체 ${ totalCount }마리 '작은 천사'</h4>
                            <div>
                                <div>
                                 <!-- <form action="" name="">
                                    <a class="active" href="#none">전체</a>
                                    <a href="insertAnimal.do">강아지</a>
                                    <a href="#none">고양이</a> 
                                </form> -->
                                </div>
                            </div>
                        </div>
                        
                        <!--리스트-->
                        <div class="animalList">
                            <ul class="grid">
                                <li class="grid-sizer"></li>
                                <c:forEach items="${ requestScope.animalList}" var="a">
                                	<c:url var="animalView" value="animalView.do">
                                		<c:param name="pageNo" value="${ pageVO.pageNo}"/>
                                		<c:param name="desertionNo" value="${ a.desertionNo }"/>
                                		<c:param name="searchFiled" value="${ pageVO.searchFiled }"/>
                                		<c:param name="searchValue" value="${ pageVO.searchValue }"/>
                                	</c:url>
                                <li class="grid-item" >
                                    <div>
                                        <a href="${ animalView }" class="chooseIcon">분양중</a>
                                        <a data-id="${ a.desertionNo }" data-title="${ a.careAddr }" data-summary="${ a.specialMark }" data-image="${ a.popfile }"
                                  		data-toggle="popover5" class="urlIcon xi-share-alt-o"></a>
                                        <a class="animalImg" href="${ animalView }"><img src="${ a.popfile }"></a>
                                    </div>
                                    <h3 onclick="location='${ animalView }'">${ a.kindCd }</h3>
                                    <p onclick="location='${ animalView }'">
                                        나이 : ${ a.age }<br/>
                                        보호센터 : ${ a.careNm }<br/>
                                        지역 : ${ a.careAddr }
                                        <span>공고시작일 : <fmt:parseDate var="animalDate" value="${a.noticeSdt}" pattern="yyyyMMdd"/>
                                                			<fmt:formatDate value="${animalDate}" pattern="yyyy-MM-dd"/>
                                         </span>
                                    </p>
                                </li>
                               </c:forEach>
                            </ul>
                        </div>
                        <!-- 리스트 끝 -->
                    
                        <!-- 페이징 -->
                        <dl class="list-paging">
                            <dd>
								<c:if test="${pageVO.pageNo >0 }">
									<c:if test="${pageVO.startPageNo >5 }">
										<c:url var = "dl1" value="animalList.do">
											<c:param name="pageNo" value="${ pageVO.startPageNo-5 }"/>
											<c:param name="searchFiled" value="${ pageVO.searchFiled }"/>
                                			<c:param name="searchValue" value="${ pageVO.searchValue }"/>
										</c:url>
										<a href="${dl1 }"><i class="xi-angle-left"></i></a>
									</c:if>
									<c:forEach var="i" begin="${pageVO.startPageNo}"
										end="${ pageVO.endPageNo }" step="1">
										<c:url var = "dl2" value="animalList.do">
												<c:param name="pageNo" value="${ i }"/>
												<c:param name="searchFiled" value="${ pageVO.searchFiled }"/>
                                				<c:param name="searchValue" value="${ pageVO.searchValue }"/>
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
										<c:url var = "dl3" value= "animalList.do">
											<c:param name="pageNo" value="${ pageVO.endPageNo +1 }"/>
                                			<c:param name="searchFiled" value="${ pageVO.searchFiled }"/>
                                			<c:param name="searchValue" value="${ pageVO.searchValue }"/>
										</c:url>
										<a href="${dl3 }"><i
											class="xi-angle-right"></i></a>
									</c:if>
								</c:if>
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