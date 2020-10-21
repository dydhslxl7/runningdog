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
                    <h2>| 상세</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="issueView">
                <p class="topText">'지금 달려갈 개'의 오늘의 이슈 게시물의 저작권은 1boon 사이트에서 활동하고 있는 원작자에게 있습니다.</p>
                <dl>
                    <dt>
                        <div class="viewImg"><img src="${ issue.issueThumbnail }"></div>
                        <a class="linkBtn" href="${ issue.issueLink }" target="_blank"><i class="xi-share"></i>원글보기</a>
                        <a class="linkBtn" href="#none"><i class="xi-share-alt-o"></i> 공유하기</a>
                    </dt>
                    <dd>
                        <div>
                            <img src="${ issue.partnerImg }">
                            <h4>${ issue.partnerName }</h4>
                        </div>
                        <h2>${ issue.issueTitle }</h2>
                        <p>조회수 : <fmt:formatNumber value="${ issue.issueReadcount }" groupingUsed="true"/> · ${ issue.issueDate }</p>
                    </dd>
                </dl>
                
                <div class="textCon">
                    ${ issue.content }
                </div>

                <!-- 버튼 -->
                <div class="viewBtn-wrap">
                    <!-- <button class="nextBtn"><i class="xi-angle-left-min"></i> 이전</button> -->
                    <button class="listBtn" onclick="javascript:history.back();"><i class="xi-rotate-left"></i> 목록</button>
                    <!-- <button class="prevBtn">다음 <i class="xi-angle-right-min"></i></button> -->
                </div>
                <!-- 버튼 끝 -->
            </div>
        </div>
        <c:import url="/WEB-INF/views/admin/include/admin_footer.jsp"/>
    </div>
</body>
</html>