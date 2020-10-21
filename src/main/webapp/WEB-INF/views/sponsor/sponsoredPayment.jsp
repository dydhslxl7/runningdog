<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
        <script>
            $(function(){
                $(".privacyCke_con").hide();
                $(".sPaymentInfo a.con1").click(function(){
                    $(".privacyCke_con").show();
                    $(".privacyCke_con textarea.con2").removeClass('on');
                    $(".privacyCke_con textarea.con1").toggleClass('on');
                });
                $(".sPaymentInfo a.con2").click(function(){
                    $(".privacyCke_con").show();
                    $(".privacyCke_con textarea.con1").removeClass('on');
                    $(".privacyCke_con textarea.con2").toggleClass('on');
                });
            });
        </script>
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
                        <form action="sSpon.do" method="post" id="spay">
                        <input type="hidden" value="${ sNum }" name="sNum">
                        <input type="hidden" value="" name="spSnumber">
                        <input type="hidden" value="${ title }" name="title">
                        <table class="sPaymentInfo">
                            <colgroup>
                                <col width="20%">
                                <col width="80%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">▣ 후원자 정보&nbsp;&nbsp;&nbsp;<span>*필수입력</span></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>후원자 분류<span>*</span></td>
                                    <td>
                                        <button type="button" id="per" class="active"><i class="xi-user-o"></i> 개인</button>
                                        <button type="button" id="peer"><i class="xi-network-company"></i> 사업자</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>후원인(이름or가명)<span>*</span></td>
                                    <td>
                                        <input onfocus="textlength(this);" maxlength="6" type="text" name="spName" title="후원인(이름or가명)" class="form-control w50p" placeholder="이름" required/>
                                        <label style="margin-left:0.9375rem;"><input type="checkbox" required> 14세 이상(필수)</label> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>이메일<span>*</span></td>
                                    <td>
                                        <input maxlength="30" value="${ loginMember.userId }" type="email" name="spEmail" title="이메일" class="form-control w50p" placeholder="이메일" required/>
                                        <label style="margin-left:0.9375rem;"><input type="checkbox" name="spEch" value="y"> 이메일수신동의(선택)</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>연락처<span>*</span></td>
                                    <td>
                                        <input value="${ loginMember.phone }" type="tel" name="spPhone" title="연락처" class="form-control w50p" placeholder="'-'를 입력해주세요." required/>
                                        <label style="margin-left:0.9375rem;"><input type="checkbox" name="spPch" value="y"> SNS수신동의(선택)</label> 
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <table class="sPaymentInfo mt50">
                            <colgroup>
                                <col width="20%">
                                <col width="80%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="2">▣ 후원정보&nbsp;&nbsp;&nbsp;<span>*필수입력</span></th>
                                </tr>
                            <tbody>
                                <tr>
                                    <td>후원방법<span>*</span></td>
                                    <td><button type="button" class="active">일시불</button></td>
                                </tr>
                                <tr>
                                    <td>납부방법<span>*</span></td>
                                    <td>
                                        <label><input type="radio" name="spWay" value="chk1" id="chk1" checked> 신용카드</label>
                                        <label><input type="radio" name="spWay" value="chk2" id="chk2"> 무통장입금</label>
                                        <p id="bank">신한은행 : 111-222-666666(지금 달려갈 개)</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>후원종류<span>*</span></td>
                                    <td>${ title }</td>
                                </tr>
                                <tr>
                                    <td>후원금액<span>*</span></td>
                                    <td>
                                        <select onChange="payOption(this);" class="form-control w50p mb10">
                                            <option value="">직접입력</option>
                                            <option value="1,000">1천원</option>
                                            <option value="3,000">3천원</option>
                                            <option value="5,000">5천원</option>
                                            <option value="10,000">1만원</option>
                                            <option value="30,000">3만원</option>
                                            <option value="50,000">5만원</option>
                                        </select>
                                        <input onblur="checkAc();" type="text" name="amount" id="amt" onkeyup="addCommas(this.value)" class="form-control w50p" placeholder="금액을 입력해주세요." required>
                                        &nbsp;10만원 이하의 금액만 후원가능합니다.
                                    </td>
                                </tr>
                                <tr class="receipt">
                                    <td colspan="2" id="yorn">
                                        <p>따뜻한 후원의 손길 감사합니다. 기부금영수증 처리를 하시겠습니까?</p>
                                        <button type="button" id="yes">네</button>
                                        <button type="button" class="active" id="no">아니요</button>
                                       	<div style="font-size:13px;" id="spnum">
                                       		※후원자님의 주민등록번호를 입력해주세요. (타인 주민등록번호 입력 불가)<br/>
                                       		입력하신 주민등록번호로 국세청 연말정산 간소화 서비스에 등록됩니다.<br/>
                                       		※금융거래 기록이 없는 14세 미만은 인증이 불가할 수도 있습니다.<br/><br/>
                                       		
                                       		<p class="rNumber">
											주민등록번호 <input type="text" id="jumin1" AUTOCOMPLETE="off" class="form-control" style="width:80px; height:30px;" maxlength="6"> - <input id="jumin2" type="password" AUTOCOMPLETE="off" class="form-control" style="width:80px; height:30px;" maxlength="7">
											&nbsp;&nbsp;<button data-val="n" id="re" value="n" onclick="aaa(); return false;" style="width:60px; height:30px;">확인</button>
                                       		</p>
                                       	</div>
                                    </td>
                                </tr>
                                <tr class="privacyInfo">
                                    <td>약관동의<span>*</span></td>
                                    <td>
                                        <label onclick="checkAll();"><input type="checkbox" name="checkAll">모두 동의합니다.</label><br/>
                                        <label><input type="checkbox" name="checkDel" required>(필수)이용약관에 동의합니다.</label><a href="#none" class="con1"><i class="xi-comment-o"></i> 보기</a><br/>
                                        <label><input type="checkbox" name="checkDel" required>(필수)개인정보처리방에 동의합니다.</label><a href="#none" class="con2"><i class="xi-comment-o"></i> 보기</a><br/>
                                    </td>
                                </tr>
                                <tr class="privacyCke_con">
                                    <td colspan="2">
                                        <c:import url="../include/termsCon.jsp"/>
                                        <c:import url="../include/privacyCon.jsp"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="sPayment_Btn">
                            <button class="w50p" id="sub" type="submit"><i class="xi-piggy-bank"></i> 후원하기</button>
                        </div>
                        </form>
                        <!-- 상세 끝 -->                        
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
</html>