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
                                <li class="xi-angle-right"><a href="moveChatting.do">나의 채팅</a></li>
                            </ul>
                        </div>
                        <h2><span>나의 채팅</span></h2>
                        <h3>나의 채팅 목록을 한눈에<br/>확인하실 수 있습니다.</h3>
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
                            <form action="searchChatUser.do" method="get">
                            <select name="searchnickname">
                                <option value="" class="fontColor-dark">이름</option>
                            </select>
                            <div class="search-box">
                                <input type="text" placeholder="회원의 이름를 검색해주세요." name="nickname">
                                <button class="xi-search"></button>
                            </div>
                            </form>
                        </div>
                        <!--서브 검색 끝-->

                        <div class="sort-area">  
                            <h4 id="listCount"></h4>
                        </div>
                        <table class="chattingList">
                            <colgroup>
                                <col width="10%">
                                <col width="*">
                                <col width="10%">
                            </colgroup>
                            <tbody id="chatList">
                            	
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
		
		<script type="text/javascript">
			function updateChatList() {
				console.trace('chatList call');
				var myChatList = ${sessionScope.myChatList};
				console.log(myChatList);
				$.ajax({
					url: "chatList.do",
					cache: false,
					type: "get",
					dataType: "json",
					success: function(data) {
						console.log("success : " + data);
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						console.log(json.list.length);
						var values = "";
						if (json.list.length != 0) {
							for (var i = 0; i < json.list.length; i++) {
								var chatUpdate = json.list[i];
								values += "<tr onclick=\"javascript:location.href='moveChattingView.do?roomNo=" + chatUpdate.roomNo 
										+ "&receiver=" + decodeURIComponent(chatUpdate.receiver).replace(/\+/gi, " ") 
										+ "&receiverNo=" + chatUpdate.receiverNo + "'\">"
		                            	+ "<td class=\"img\"><img src=\"/runningdog/resources/images/memberImg/" + chatUpdate.profile + "\"></td>"
		                            	+ "<td class=\"title\">"
		                                + "<h2>" + decodeURIComponent(chatUpdate.receiver).replace(/\+/gi, " ") + "<span>" + chatUpdate.lastdate + "일 마지막 응답</span></h2>"
		                                + "<p>" + decodeURIComponent(chatUpdate.lastmessage).replace(/\+/gi, " ") + "</p></td>";
		                        values +=  chatUpdate.unread > 0 ? "<td><span>"+ chatUpdate.unread +"</span></td></tr>" : "<td></td></tr>";
		                            	//<td class="img"><img src="/runningdog/resources/images/test/animalNews04.jpg"></td>
							} // for in
						} else {
							values += "<tr><td class='list-no'><img src='/runningdog/resources/images/btnIcn/icn_big_listNo.png' alt='' title='' />"
			                        + "<h1>참여한 채팅이 없습니다.</h1></td></tr>";
						}
						$("#chatList").html(values);
						$("#listCount").html("전체 " + json.list.length +"개의 채팅");
					},
					error : function(jqXHR, textstatus, errorthrown) {
						console.log("error : " + jqXHR + ", " + textstatus + ", "
								+ errorthrown);
					},
					complete: function() {
					      setTimeout(updateChatList, 30000);
				    }
				});
			};
    		setTimeout(updateChatList, 1000);
		</script>
	</body>
</html>