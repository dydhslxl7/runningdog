<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="listCount" value="${ requestScope.totalCount }" />
<c:set var="startPage"  value="${ requestScope.startPage }"/>
<c:set var="endPage"  value="${ requestScope.endPage }"/>
<c:set var="maxPage"  value="${ requestScope.maxPage }"/>
<c:set var="currentPage"  value="${ requestScope.currentPage }"/>
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
                                <li class="xi-angle-right"><a href="movePlist.do">보호센터 정보</a></li>
                            </ul>
                        </div>
                        <h2><span>보호센터 정보</span></h2>
                        <h3>지역 안의 보호센터의<br/>위치와 정보를 알려드립니다.</h3>
                    </div>
                </div>
                <!--서브 비주얼/타이틀 끝-->
                
                <div class="subContent_wrap">
                    <!-- 좌측메뉴 -->
                    <c:import url="/WEB-INF/views/include/leftMenu.jsp"/>
                    <!-- 좌측메뉴 끝 -->

                    <div class="subContent">
                        <!--서브 검색-->                
                        <form action="movePlist.do" name="">     
                        <div class="search_wrap" id="search">
                            <select name="searchFiled" id="searchS">
                                <option value="proname" class="fontColor-dark" ${pageVO.searchFiled eq"proname"?"selected":""}>센터명</option>
                                <option value="protype" class="fontColor-dark"${pageVO.searchFiled eq"protype"?"selected":""}>센터유형</option>
                                <option value="proorgnm" class="fontColor-dark" ${pageVO.searchFiled eq"proorgnm"?"selected":""}>관할구역</option>
                            </select>
                            <div class="search-box">
                                <input type="text" id="searchI" name="searchValue" placeholder="원하시는 키워드를 검색해주세요." value ="${ pageVO.searchValue }">
                                 <button type="submit" name="sel" value="SEARCH"  class="xi-search"></button>
                            </div>
                           </form>
                        </div>
                        <!--서브 검색 끝-->
                        
                        <div class="sort-area">  
                            <h4 id="totalcount">총 ${requestScope.totalCount} 개</h4>
                            <div>
                                <div>
                                <form action="" name="">
                                </form>
                                </div>
                            </div>
                        </div>

                        
                        <!--리스트-->
                        <table id="plist" class="servicelList">
                            <colgroup>
                                <col width="20%">
                                <col width="*">
                                <col width="20%">
                            </colgroup>
                            <tbody>
                           	 <c:forEach var="p" items="${requestScope.plist}" >
                           	 <c:url var="pd" value="pdetail.do">
                           	 		<c:param name="prono" value="${ p.prono}"/>
                                  	<c:param name="pageNo" value="${ pageVO.pageNo }"/>
                                 	<c:param name="searchFiled" value="${pageVO.searchFiled }" />
									<c:param name="searchValue" value="${pageVO.searchValue }" />
                           	 </c:url>
                                <tr class="serviceOn" onclick="location.href='${pd }'">
                                    <td class="img">
                                        <img src="/runningdog/resources/images/common/noImage02.png" style="border:2px solid #ff92a8;">
                                        <!-- <img src=""> -->
                                    </td>
                                    <td>
                                        <h3>${p.proname}</h3>
                                        <ul>
                                            <li class="location"><span>관할구역 : </span>${p.proorgnm}</li>
                                            <li><span>센터유형 : </span>${p.protype}</li>
                                        </ul>
                                    </td>
                                    <td><a href="${pd }">자세히 보기 <i class="xi-eye-o"></i></a></td>
                                </tr>
                              </c:forEach>
                            </tbody>
                        </table>
                        <!-- 리스트 끝 -->
                    
                        <!-- 페이징 -->
                       <c:if test="${totalCount > 0}">
                        <dl class="list-paging">
                            <dd>
								<c:if test="${pageVO.pageNo >0 }">
									<c:if test="${pageVO.startPageNo >5 }">
										<c:url var = "dl1" value="movePlist.do">
											<c:param name="pageNo" value="${ pageVO.startPageNo-5 }"/>
											<c:param name="searchFiled" value="${pageVO.searchFiled }"/>
											<c:param name="searchValue" value="${pageVO.searchValue }"/>
										</c:url>
										<a href="${dl1 }"><i class="xi-angle-left"></i></a>
									</c:if>
									<c:forEach var="i" begin="${pageVO.startPageNo}"
										end="${ pageVO.endPageNo }" step="1">
										<c:url var = "dl2" value="movePlist.do">
												<c:param name="pageNo" value="${ i }"/>
												<c:param name="searchFiled" value="${pageVO.searchFiled }"/>
												<c:param name="searchValue" value="${pageVO.searchValue }"/>
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
									<c:if test="${pageVO.pageNo != pageVO.finalPageNo and pageVO.finalPageNo > 5}">
										<c:url var = "dl3" value= "movePlist.do">
											<c:param name="pageNo" value="${ pageVO.endPageNo +1 }"/>
											<c:param name="searchFiled" value="${pageVO.searchFiled }"/>
											<c:param name="searchValue" value="${pageVO.searchValue }"/>
										</c:url>
										<a href="${dl3 }"><i
											class="xi-angle-right"></i></a>
									</c:if>
								</c:if>
							</dd>
                        </dl>
                      </c:if>
                      <c:if test="${ listCount eq 0}">
                        <tr class="list-no">
							<td colspan="7">
								<p><img src="/runningdog/resources/images/btnIcn/icn_big_listNo.png" alt="" title="" /></p>
								<h1>목록이 없습니다.</h1>
							</td>
						</tr>
                    </c:if>
                        <!-- //페이징 -->
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
		
		<!-- ajax로 JSON객체 가져오기 -->
<!-- <script type="text/javascript">

$(document).ready(function(){
	showList();
});

function showList(){
	$.ajax({
		url : "movePlist.do",
		type : "get",
		data : paramData,
		dataType: "text",
		success : function(data){
			console.log("success:성공");
			
			var jsonStr = JSON.stringify(data);
			var json = JSON.parse(jsonStr);
			var totalcount = (json.list).length;
			var values = "";
			console.log((json.list).length);
			for(var i in json.list){
				values += 
	            "<tr class='serviceOn' onclick=movePdetail('"+json.list[i].careNm +"')>"
                +"<td class='img'>"
                  +"<img src='/runningdog/resources/images/test/animalNews04.jpg'>"
                +"</td>"
                +"<td>"
                    +"<h3>"+decodeURIComponent(json.list[i].careNm).replace(/\+/gi, "  ")+"</h3>"
                    +"<ul>"
                        +"<li class='location'><span>관할구역 : </span>"+decodeURIComponent(json.list[i].orgNm).replace(/\+/gi, "  ")+"</li>"
                        +"<li><span>동물보호센터유형 : </span>" + decodeURIComponent(json.list[i].divisionNm).replace(/\+/gi, "  ") + "</li>"
                    +"</ul>"
                +"</td>"
                +"<td><a href='movePdetail.do?careNm=json.list[i].careNm'>자세히 보기 <i class='xi-eye-o'></i></a></td>"
            +"</tr>" } //for in
            
   
            $('#plist > tbody').html(values); 
            },
            error : function(jqXHR, textstatus, errorthrown) {
               console.log("error : " + jqXHR + ", " + textstatus
                     + ", " + errorthrown); 
		}
	});//ajax
	
});//document.ready

function movePdetail(careNm){
  console.log("클릭성공: " +careNm);
	location.href="movePdetail.do?careNm="+careNm;
}

</script>  -->
		
	</body>
</html>