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
                                <li class="xi-angle-right"><a href="slist.do">후원하기</a></li>
                            </ul>
                        </div>
                        <h2><span>후원하기</span></h2>
                        <h3>여러분의 따뜻한 손길로<br/>작은 생명에게 새 삶을 찾아주세요.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="../include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->
                    <div class="subContent">
                        <!--상세-->
                        <div class="sponsorSuccess">
                        	<h1>후원해 주셔서 감사합니다.</h1>
	                        <table>
	                            <colgroup>
	                                <col width="20%">
	                                <col width="%">
	                                <col width="20%">
	                                <col width="20%">
	                            </colgroup>
	                            <tbody>
	                                <tr>
	                                    <th>후원유형</th>
	                                    <th>후원항목</th>
	                                    <th>후원방법</th>
	                                    <th>후원내용</th>
	                                </tr>
	                                <tr>
	                                	<td>일시</td>
	                                    <td>${ title }</td>
	                                    <td>${ way }</td>
	                                    <td>${ cash } 원</td>
	                                </tr>
	                            </tbody>
	                        </table>
                            <button onclick="javascript:location.href='slist.do'">확인</button>
                        </div>
                        <!-- 상세 끝 -->                        
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>