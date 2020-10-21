<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="header">
    <h1 onclick="location='/runningdog/'" title="지금 달려갈 개"><img src="resources/admin/images/common/logo.png" alt="지금 달려갈 개"></h1>
    <!-- gnb -->
    <ul class="gnb">
        <li>
            <h2><a href="#collapse1" class="collapsed" data-toggle="collapse"><i class="xi-users-o"></i> 사용자관리 <i class="xi-angle-down-min more"></i></a></h2>
            <div id="collapse1" class="collapse show" data-parent="#accordion">
                <a href="memberAllList.ad">전체회원 리스트</a>
                <a href="memberLeaveList.ad">탈퇴회원 리스트</a>
            </div>
        </li>
        <li>
            <h2><a href="#collapse2" class="collapsed" data-toggle="collapse"><i class="xi-document"></i> 사용자게시판 <i class="xi-angle-down-min more"></i></a></h2>
            <div id="collapse2" class="collapse show" data-parent="#accordion">
                <a href="dboardList.ad">유기동물 주인찾기 관리</a>
                <a href="/runningdog/vlist.ad">자원봉사모집 관리</a>
                <a href="aslist.ad">후원하기 관리</a>
                <a href="nlist.ad">공지사항 관리</a>
            </div>
        </li>
        <li>
            <h2><a href="#collapse3" class="collapsed" data-toggle="collapse"><i class="xi-library-bookmark"></i> 콘텐츠 <i class="xi-angle-down-min more"></i></a></h2>
            <div id="collapse3" class="collapse show" data-parent="#accordion">
                <a href="cknowlist.ad">반려동물 상식 관리</a>
                <a href="cissuelist.ad">오늘의 이슈 관리</a>
            </div>
        </li>
        <!-- li>
            <h2><a href="#collapse4" class="collapsed" data-toggle="collapse"><i class="xi-cog"></i> 관리자 관리 <i class="xi-angle-down-min more"></i></a></h2>
            <div id="collapse4" class="collapse show" data-parent="#accordion">
                <a href="/WEB-INF/views/admin/etc/aboutView.jsp">사이트소개 관리</a>
                <a href="etcView.ad">사용자약관 관리</a>
                <a href="adminInfo.ad">관리자 정보수정</a>
            </div>
        </li-->
    </ul>
</div>