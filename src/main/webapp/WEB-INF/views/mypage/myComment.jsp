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
                                <li><a href="#none">홈</a></li>
                                <li class="xi-angle-right"><a href="#none">나의 댓글</a></li>
                            </ul>
                        </div>
                        <h2><span>나의 댓글</span></h2>
                        <h3>나의 댓글 목록을<br/>확인하실 수 있습니다.</h3>
                    </div>
                </div>
			    <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        <!--서브 검색-->
                        <div class="search_wrap">
                            <form action="" name="">
                            <select>
                                <option value="" class="fontColor-dark">이름</option>
                            </select>
                            <div class="search-box">
                                <input type="text" placeholder="회원의 이름를 검색해주세요.">
                                <button onclick="#none" class="xi-search"></button>
                            </div>
                            </form>
                        </div>
                        <!--서브 검색 끝-->

                        <div class="sort-area">  
                            <h4>전체 15개의 댓글</h4>
                        </div>
                        <table class="chattingList">
                            <colgroup>
                                <col width="10%">
                                <col width="*">
                                <col width="20%">
                            </colgroup>
                            <tbody>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker"><span>유기동물 분양</span></td>
                                </tr>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker2"><span>자원봉사 모집</span></td>
                                </tr>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker2"><span>자원봉사 모집</span></td>
                                </tr>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker"><span>유기동물 분양</span></td>
                                </tr>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker"><span>유기동물 분양</span></td>
                                </tr>
                                <tr onclick="location='#none'">
                                    <td class="img"><img src="/runningdog/resources/images/common/userBg.png"></td>
                                    <td class="title">
                                        <h2>멍무이 <span>2020.08.31일 댓글</span></h2>
                                        <p>안녕하세요. 유기동물 공고보고 연락드렸습니다. 강아지를 지금 보러갈까 하는데 괜찮을까요?</p>
                                    </td>
                                    <td class="marker2"><span>자원봉사 모집</span></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- 페이징 -->
                        <dl class="list-paging">
                            <dd>
                                <a href="#none"><i class="xi-angle-left"></i></a>
                                <a href="#none" class="active">1</a>
                                <a href="#none">2</a>
                                <a href="#none">3</a>
                                <a href="#none">4</a>
                                <a href="#none">5</a>
                                <a href="#none"><i class="xi-angle-right"></i></a>
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