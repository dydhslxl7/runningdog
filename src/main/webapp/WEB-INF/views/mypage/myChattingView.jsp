<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
        <style>
            @media all and (max-width:600px) {
                #mHeader, #footer, .vegas-container, #topRollBtn, #fmobileMenu{
                    display: none !important;
                }
                .chattingView_wrap {
                    margin-bottom: 1.25rem;
                }
                .chattingView_wrap .chattingView {
                    min-height: 100%;
                    max-height: 40rem;
                }
            }
        </style>
        <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
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
                        <div class="chattingView_wrap">
                            <dl class="userInfo">
                                <dt><button class="xi-backspace" onclick="javascript:history.back();"></button></dt>
                                <dd>
                                    <h2>${param.receiver} <span>#${param.receiverNo}</span></h2>
                                </dd>
                                <dt class="chattingController">
                                    <button type="button"><i class="xi-ellipsis-v"></i></button>
                                    <div>
                                        <button type="button" class="OutBtn" onclick="location.href='deleteChat.do?roomNo=${roomNo}'">채팅방 삭제하기</button>
                                        <button type="button" class="cancelBtn">취소하기</button>
                                    </div>
                                </dt>
                            </dl>
                            
                            <div class="chattingView" id="chatdata">
                                <div>
                                    <h3><i class="xi-comment-o"></i> 채팅안내</h3>
                                    <p>욕설, 모욕, 상대방이 불쾌할 수 있는 언어의 사용을 금지합니다. 이웃끼리 매너있는 채팅문화를 만들어주세요."</p>
                                </div>
                                <c:if test="${logList != null}">
                                	<c:forEach var="log" items="${logList}">
                                		<c:if test="${sessionScope.loginMember.getUniqueNum() eq log.getSender() and roomNo eq log.getRoomNo()}">
                                			<dl class="user_right myChatting">
                                    		<dt>${log.getContent()}</dt>
                                    		<dd><fmt:formatDate value="${log.getSendTime()}" pattern="a hh:mm" /></dd>
                             				</dl>
                           				</c:if>
                                		<c:if test="${sessionScope.loginMember.getUniqueNum() eq log.getReceiver() and roomNo eq log.getRoomNo()}">
                                			<dl class="user_left">
                                    		<dt><img src="resources/images/common/userBg.png"></dt>
                                    		<dd><p>${log.getContent()}</p><span><fmt:formatDate value="${log.getSendTime()}" pattern="a hh:mm" /></span></dd>
                                			</dl>
                           				</c:if>
                                	</c:forEach>
                                </c:if>
                            <input type="hidden" value="${ sessionScope.loginMember.getNickname() }" id="sessionuserid">
                            </div>
                            <form action="testForm.do" method="post" onsubmit="return false;">
                            <div class="cmt_body">
                                <div><textarea name="" placeholder="메세지를 입력하세요." class="form-control" id="message"></textarea></div>
                                <button class="xi-send" type="submit" id="sendBtn"></button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 컨텐츠 끝 -->

            <c:import url="/WEB-INF/views/include/footer.jsp"/>
		</div>
	</body>
	
<script type="text/javascript">
	$("#chatdata").scrollTop($("#chatdata")[0].scrollHeight);
	//websocket을 지정한 URL로 연결
	var sock= new SockJS("<c:url value='/echo'/>");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	sock.onmessage = onMessage;
	//websocket 과 연결을 끊고 싶을때 실행하는 메소드
	sock.onclose = onClose;
	$(function(){
		$("#sendBtn").click(function(){
			console.log('send message...');
	        sendMessage();
	    });
	});
	
	// 메세지 enter로 전송
	$(function() {
		 $('textarea').on('keydown', function(event) {
		     if (event.keyCode == 13){
		         if (!event.shiftKey){
		            event.preventDefault();
		            var button=document.getElementById('sendBtn');
					button.click();
		         }
		     }
		});
		 
	});
	
	function sendMessage(){      
		//websocket으로 메시지를 보내겠다.
		const message = {
			type: 'message',
			data: {
				sender: '${sessionScope.loginMember.getNickname()}',
				message: ($("#message").val()).replace("\n", "<br>"),
				roomno: ${roomNo},
				receiverNo: ${receiverNo},
				time: new Date().getTime()
			}
		}
		if (message.data.message != "") {
		  	sock.send(JSON.stringify(message));
		}
		$("#message").val('');
	}
	            
	//evt 파라미터는 websocket이 보내준 데이터다.
	function onMessage(evt){  //변수 안에 function자체를 넣음.
		var data = evt.data;
		var time = null;
		var chatTime = null;
		var nickname = null;
		var message = null;
		var roomno = null;
		
		var receivedMessage = JSON.parse(data);
		
		//current session id//
		var currentuser_session = $('#sessionuserid').val();
		console.log('current session id: ' + currentuser_session);
		
		switch (receivedMessage.type) {
		case 'message':
			time = receivedMessage.data.time;
			chatTime = new Date(time).toLocaleString('ko-KR', { hour: 'numeric', minute: 'numeric', hour12: true });
			nickname = receivedMessage.data.nickname; //현재 메세지를 보낸 사람의 세션 등록//
			message = receivedMessage.data.message; //현재 메세지를 저장//
			roomno = receivedMessage.data.roomno;
			if (message=="") {
				break;
			}
			//나와 상대방이 보낸 메세지를 구분하여 영역을 나눈다.//
			if (roomno == ${roomNo}) {
				
				if(nickname == currentuser_session){
					var printHTML = "<dl class='user_right myChatting'>";
					printHTML += "<dt>" + message;
					printHTML += "<dd>" + chatTime + "</dd>";
					printHTML += "</dt></dl>";
		
					$("#chatdata").append(printHTML);
				} else{
					var printHTML = "<dl class='user_left'>";
					printHTML += "<dt><img src='resources/images/common/userBg.png'></dt>";
					printHTML += "<dd><p>" + message +"</p><span>" + chatTime + "</span></dd>";
					printHTML += "</dl>";
					
					$("#chatdata").append(printHTML);
				}
					$("#chatdata").scrollTop($("#chatdata")[0].scrollHeight);
			}
				console.log('chatting data: ' + data);
			break;
		default:
			console.log('Unknown message type: ' + receivedMessage.type + '\n%o', receivedMessage);
		}
	  	/* sock.close(); */
	}
	    
	function onClose(evt){
		$("#data").append("연결 끊김");
	}    
</script>
</html>