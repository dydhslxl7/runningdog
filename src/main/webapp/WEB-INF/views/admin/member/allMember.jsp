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
                    <h3>전체회원 관리</h3>
                    <h2>| 리스트</h2>
                </div>
            </div>
            <!-- //상단 타이틀 -->

            <!-- 본문내용 -->
            <div class="list_wrap">
                <!-- 검색영역 -->
                <div class="sort-area">  
                    <h4>전체회원 100명</h4>
                    <form action="" method="get" id="">
                    <div class="searchBox">
                        <select name="search" class="ListSelect">
                            <option value="userId" elected="selected">아이디(이메일)</option>
                            <option value="userName">닉네임</option>
                            <option value="userEmail">회원번호</option>
                            <option value="userPhone">휴대폰번호</option>
                        </select>
                        <div>
                            <input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
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
                        <col width="8%">
                        <col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <col width="8%">
                        <col width="6%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>번호</th>
                            <th>아이디(이메일)</th>
                            <th>닉네임</th>
                            <th>회원번호</th>
                            <th>휴대폰번호</th>
                            <th>가입일</th>
                            <th>최근접속일</th>
                            <th>로그인유형</th>
                            <th>접근제한</th>
                        </tr>
                        <tr>
                        </tr>
                        <tr class="hr">
                            <th colspan="10"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">10</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-kakaotalk"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">9</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-kakaotalk"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">8</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-facebook-official"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">7</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-facebook-official"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">6</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-naver-square"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">5</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-naver-square"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">4</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-naver-square"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">3</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-kakaotalk"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">2</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-facebook-official"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        <tr>
                            <td class="checkBox"><input type="checkbox" name="leaveChk" id="leaveChk" value=""></td>
                            <td class="number" onclick="location='memberView.jsp'">1</td>
                            <td class="userId" onclick="location='memberView.jsp'">taeung103@naver.com</td>
                            <td class="userName" onclick="location='memberView.jsp'">멍무이</td>
                            <td class="gender" onclick="location='memberView.jsp'">#1971345</td>
                            <td class="phone" onclick="location='memberView.jsp'">010-3387-7583</td>
                            <td class="joinDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="lastAccessDate" onclick="location='memberView.jsp'">2020.09.01</td>
                            <td class="loginType" onclick="location='memberView.jsp'"><i class="xi-kakaotalk"></i></td>
                            <td class="loginLimit" onclick="location='memberView.jsp'">Y</td>
                        </tr>
                        
						<tr class="list-no">
							<td colspan="10">
								<p><img src="/WEB-INF/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>

                    </tbody>
                </table>
                <p class="warning_text"> *탈퇴된 회원은 되돌릴 수 없습니다. 신중하게 선택해주세요.</p>
                <!-- //게시판 -->

                <!-- 버튼 -->
                <div class="list-btn">
                    <button type="button" id="" class="btn-left chkBtn"><i class="xi-cut"></i> 선택탈퇴</button>
                    <button type="button" id="" class="btn-right writeBtn" onclick="location='memberInsert.ad'"><i class="xi-pen-o"></i> 회원추가</button>
                </div>
                <!-- //버튼 -->

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
        <c:import url="/WEB-INF/views/admin/include/admin_footer.jsp"/>
    </div>
</body>
</html>