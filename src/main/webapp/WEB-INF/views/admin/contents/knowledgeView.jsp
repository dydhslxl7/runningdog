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
                    <h2>| 상세</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="view-area">
                <h3><span>상식</span></h3>
                <h2>${ title }</h2>
                <ul>
                    <li><span>작성자 : </span>관리자</li>
                    <!-- <li><span>등록일 : </span>2020.08.28</li> -->
                    <li><span>조회수 : </span>${ readcount }</li>
                </ul>

                <div class="view-ctn">
                
                <pre style="background-color: rgba(255, 0, 0, 0);"><c:out value="${ content }"/></pre>
                
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