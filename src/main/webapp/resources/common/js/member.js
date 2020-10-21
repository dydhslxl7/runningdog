$(function () {
	//멤버공통 정규표현식  *로그인포함 ***********************************************
	//아이디(이메일)정규식
    var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    //비밀번호 정규식
    var pwqRegExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    //휴대폰번호 정규식
    var phoneRegExp = /^\d{3}-\d{3,4}-\d{4}$/;
    

    $('#userIdChk').blur(function () {
	    var id = $('#userIdChk').val().trim();
	    
        if (id == null || id == '' || id == 'undefined') {
    		$('#idWarning span').html('아이디(이메일)를 입력해주세요.');
        } else if (!(id.match(emailRegExp))) {
    		$('#idWarning span').html('올바른 이메일 형식이 아닙니다.');
        } else {
    		$('#idWarning span').html('');
        }
    });

    $('#userPwdChk').blur(function () {
        var pwd = $('#userPwdChk').val().trim();
        
        if (pwd == null || pwd == '' || pwd == 'undefined') {
    		$('#pwdWarning span').html("비밀번호를 입력해주세요.");
        } else if (!(pwd.match(pwqRegExp))) {
    		$('#pwdWarning span').html("특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.");
        } else {
    		$('#pwdWarning span').html('');
        }
    });
    
    
    $('#userPwdChk2').blur(function () {
        var pwd2 = $('#userPwdChk2').val().trim();
        
        if (pwd2 == null || pwd2 == '' || pwd2 == 'undefined') {
    		$('#pwdWarning span').html('비밀번호 다시 한번 입력해주세요.');
        } else if (!(pwd2.match(pwqRegExp))) {
    		$('#pwdWarning span').html('특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.');
        } else {
    		$('#pwdWarning span').html('');
        }
    });

    
    $('#nicknameChk').blur(function () {
	    var nickname = $('#nicknameChk').val().trim();
        if (nickname == null || nickname == '' || nickname == 'undefined') {
    		$('#nicknameWarning span').html('닉네임을 입력해주세요.');
        } else {
    		$('#nicknameWarning span').html('');
        }
    });
    
    $('#phoneChk').blur(function () {
	    var phone = $('#phoneChk').val().trim();
        if (phone == null || phone == '' || phone == 'undefined') {
    		$('#phoneWarning span').html('휴대폰번호를 입력해주세요.');
        } else if (!(phone.match(phoneRegExp))) {
    		$('#phoneWarning span').html('올바른 형식의 휴대폰번호가 아닙니다.');
        } else {
    		$('#phoneWarning span').html('');
        }
    });
    
    $('#phoneChk2').blur(function () {
	    var phone = $('#phoneChk2').val().trim();
        if (phone == null || phone == '' || phone == 'undefined') {
    		$('#phoneWarning2 span').html('휴대폰번호를 입력해주세요.');
        } else if (!(phone.match(phoneRegExp))) {
    		$('#phoneWarning2 span').html('올바른 형식의 휴대폰번호가 아닙니다.');
        } else {
    		$('#phoneWarning2 span').html('');
        }
    });
    
    $('#newUserPwdChk').blur(function () {
	    var newPwd = $('#newUserPwdChk').val().trim();
        if (newPwd == null || newPwd == '' || newPwd == 'undefined') {
    		$('#newUserPwdWarning span').html("변경하실 새 비밀번호를 입력해주세요.");
        } else if (!(newPwd.match(pwqRegExp))) {
    		$('#newUserPwdWarning span').html("특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.");
        } else {
    		$('#newUserPwdWarning span').html('');
        }
    });
    
    $('#newUserPwdChk2').blur(function () {
	    var newPwd2 = $('#newUserPwdChk2').val().trim();
        if (newPwd2 == null || newPwd2 == '' || newPwd2 == 'undefined') {
    		$('#newUserPwdWarning span').html('변경하실 새 비밀번호 다시 한번 입력해주세요.');
        } else if (!(newPwd2.match(pwqRegExp))) {
    		$('#newUserPwdWarning span').html("특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.");
        } else {
    		$('#newUserPwdWarning span').html('');
        }
    });
    //멤버공통 정규표현식  *로그인포함 끝 ***********************************************
    
    
    //회원가입 ajax
    $('.joinAction').click(function() {
	    var id = $('#userIdChk').val().trim();
        var pwd = $('#userPwdChk').val().trim();
        var pwd2 = $('#userPwdChk2').val().trim();
	    var nick = $('#nicknameChk').val().trim();
	    var phone = $('#phoneChk').val().trim();

	    if (id == null || id == '' || id == 'undefined') {
    		$('#idWarning span').html('아이디(이메일)를 입력해주세요.');
        }
	    if (pwd == null || pwd == '' || pwd == 'undefined') {
    		$('#pwdWarning span').html('비밀번호를 입력해주세요.');
        }
	    if (pwd2 == null || pwd2 == '' || pwd2 == 'undefined') {
    		$('#pwdWarning span').html('비밀번호 다시 한번 입력해주세요.');
        }
	    if (pwd2 != pwd) {
    		$('#pwdWarning span').html('입력하신 비밀번호가 일치하지 않습니다.');
        }
	    if (nick == null || nick == '' || nick == 'undefined') {
    		$('#nicknameWarning span').html('닉네임을 입력해주세요.');
        }
	    if (phone == null || phone == '' || phone == 'undefined') {
    		$('#phoneWarning span').html('휴대폰번호를 입력해주세요.');
        }
	    if ($("#chkY").is(":checked") == false) {
			alert('서비스 이용약관, 개인정보처리방침 동의 시 회원가입이 가능합니다.');
			$('#chkY').focus();
			return false;
		}
		
		if(id != '' && pwd != '' && pwd2 != '' && nick != '' && phone != '' && $('#chkY').is(':checked') == true){
			
			//formData 객체생성
			var formData = new FormData($('#joinForm')[0]);
			
			$.ajax({
	            type:'post',
	            enctype: 'multipart/form-data',
	            url:'joinAction.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
	            success : function(data) {
	                if (data == 'notUserId') {
	        			$('#idWarning span').html('이미 가입된 아이디(이메일)입니다.');
	                	$("#joinUserId").focus();
	                } else if(data == "notNickname") {
	        			$('#nicknameWarning span').html('이미 존재하는 닉네임 입니다.');
	                	nickname.focus();
	                } else if(data == "notPhone") {
	        			$('#phoneWarning span').html('이미 가입된 핸드폰 번호 입니다.');
	                	phone.focus();
	                } else if(data == "joinOk") {
	                	alert("회원가입을 축하합니다.\n로그인 후 '지금 달려갈 개'의 서비스를 이용하실 수 있습니다.");
	    				location.reload();
	                	window.location.href = 'login.do';
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);}
    		});
		}
	});
    
   
    
  //아이디(이메일) 찾기 ajax
	$('.idFindBtn').click(function() {
		
	    var phone = $('#phoneChk').val().trim();
	    
		if(phone == null || phone == '' || phone == 'undefined'){
    		$('#phoneWarning span').html("휴대폰번호를 입력해주세요.");
		} else if (!(phone.match(phoneRegExp))) {
    		$('#phoneWarning span').html("올바른 형식의 휴대폰번호가 아닙니다.");
        } else {
			$.ajax({
	            type:'post',
	            url:'idFindAction.do',
	            data: {phone: $("#phoneChk").val()},
	            dataType : "html",
	            success : function(data) {
	            	if(data == "selectId") {
	            		location.href = "idFindComplete.do";
	                } else if(data == "notSelectId") {
	        			$('#phoneWarning span').html("가입된 휴대폰번호가 아닙니다. 다시 입력해주세요.");
		            }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});
		}
	});
	
	
	
	//비밀번호 찾기 ajax
	$('.pwdFindBtn').click(function() {
		var id = $('#userIdChk').val().trim();
		var phone = $('#phoneChk2').val().trim();
	
		if(id == null || id == '' || id == 'undefined'){
    		$('#idWarning span').html('아이디(이메일)를 입력해주세요.');
		} else if (!(id.match(emailRegExp))) {
    		$('#idWarning span').html('올바른 이메일 형식이 아닙니다.');
        }
	
		if(phone == null || phone == '' || phone == 'undefined'){
    		$('#phoneWarning2 span').html("휴대폰번호를 입력해주세요.");
		} else if (!(phone.match(phoneRegExp))) {
    		$('#phoneWarning2 span').html("올바른 형식의 휴대폰번호가 아닙니다.");
        }
		
		if(id != '' && phone != ''){

			$.ajax({
	            type:'post',
	            url:'pwdFindAction.do',
	            data: {userId: $("#userIdChk").val(), phone: $("#phoneChk2").val(), userPwd: $("#userPwdChk").val()},
				success : function(data) {
					console.log(id, phone);
	            	if(data == "selectIdPhoneChk") {
	        			$('form[name="pwdFind"] .loginInfo').css("display", "none");
	        			$('.pwdFindView').css("display", "block");
	                } else if(data == "socialUser") {
	                	alert("본 계정은 sns 간편 로그인 회원계정으로 임시 비밀번호를 발급받을 수 없습니다. 가입하신 sns로 로그인해주세요.");
	                } else if(data == "notSelectIdPhoneChk") {
	        			$('#userIdPhoneWarning span').html("가입된 계정이 존재하지 않습니다.\n다시 입력해주세요.");
	                } else if(data == "notSelectPhone") {
	        			$('#phoneWarning2 span').html("");
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});	
		}
	});

	
	
	//나의프로필 ajax
	$('.myinfoBtn').click(function() {

		var pwd = $('#userPwdChk').val().trim();

		if(pwd != ''){
			//formData 객체생성
			var formData = new FormData($('#myinfoForm')[0]);
			
			$.ajax({
	            type:'post',
	            enctype: 'multipart/form-data',
	            url:'myinfoAction.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
				success : function(data) {
            		if(data == "myinfoOk") {
        				alert("나의 프로필 정보가 변경되었습니다.");
	                	location.reload();
	                	window.location.href = 'mypage.do?userId='+userId;
	                } else if(data == "notNickname") {
	        			$('#nicknameWarning span').html('이미 존재하는 닉네임 입니다.');
	                	nickname.focus();
	                } else if(data == "notPhone") {
	        			$('#phoneWarning span').html('이미 가입된 핸드폰 번호 입니다.');
	                	phone.focus();
	                } else if(data == "notUserPwd") {
	        			$('#pwdWarning span').html('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
	        			pwd.focus();
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});	
		} else {
			alert('비밀번호를 입력해야 나의 프로필 수정이 가능합니다.');
			$('#userPwdChk').focus();
		}
	});
	


	//나의 프로필 비밀번호 변경 ajax
	$('.myPwdChangeBtn').click(function() {
		var pwd = $('#userPwdChk').val().trim();
		var newPwd = $('#newUserPwdChk').val().trim();
		var newPwd2 = $('#newUserPwdChk2').val().trim();

		if(pwd == ''){
			alert('비밀번호를 입력해야 새 비밀번호 변경이 가능합니다.');
			$('#userPwdChk').focus();
		} else if(pwd != '' && newPwd == '') {
			$('#newUserPwdWarning span').html('새 비밀번호를 입력해야 비밀번호 변경이 가능합니다.');
        	$('#newUserPwdChk').focus();
		} else if(pwd != '' && newPwd2 == '') {
			$('#newUserPwdWarning span').html('새 비밀번호를 한번 더 입력해주세요.');
			$('#newUserPwdChk2').focus();
		} else if(newPwd != newPwd2) {
			$('#newUserPwdWarning span').html('새 비밀번호가 서로 일치하지 않습니다. 다시 입력해주세요.');
			$('#newUserPwdChk2').focus();
		} else if (pwd != '' && newPwd != '' && newPwd2 != '' && newPwd == newPwd2){
			//formData 객체생성
			var formData = new FormData($('#myinfoForm')[0]);
			
			$.ajax({
	            type:'post',
	            url:'pwdChangeAction.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
				success : function(data) {
	            	if(data == "myinfoOk") {
	        			alert('새 비밀번호가 변경되었습니다.');
	        			$('#userPwdChk').append(data);
	        			window.location.href='mypage.do';
	                } else if(data == "notUserPwd") {
	                	alert('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
	        			$('#pwdWarning span').html('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
	        			pwd.focus();
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});
		}
			
	});
	
	
	//회원탈퇴
	$(".leaveBtn").click(function(){
		var result = confirm('회원탈퇴를 하시겠습니까?\n탈퇴된 회원은 되돌릴 수 없으니 신중하게 선택해주세요.');
		
		if(result == true){
			console.log(result);
			var pwd = $('#userPwdChk').val().trim();
			
	        if (pwd == null || pwd == '' || pwd == 'undefined') {
	        	alert('비밀번호 입력 후 회원탈퇴가 가능합니다.');
	        	$('#userPwdChk').focus();
	    		$('#pwdWarning span').html("비밀번호를 입력해주세요.");
	        } else if (!(pwd.match(pwqRegExp)) && result2) {
	    		$('#pwdWarning span').html("특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.");
	        } else {
	    		$('#pwdWarning span').html('');
	        }
			if(pwd != ''){
				//formData 객체생성
				var formData = new FormData($('#myinfoForm')[0]);
				
				$.ajax({
		            type:'post',
		            url:'leaveMember.do',
		            data: formData, // 필수
		            processData: false, // 필수
		            contentType: false, // 필수
		            cache: false,
					success : function(data) {
						if(data == "myinfoOk") {
		        			alert('회원탈퇴가 처리되었습니다.\n이용해주셔서 감사합니다.');
		        			window.location.href='logout.do';
		                } else if(data == "notUserPwd") {
		                	alert('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
		        			$('#pwdWarning span').html('입력하신 비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
		        			pwd.focus();
		                }
		            },
		    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
		    		}
				});
			}
		} else {
			
		}
		
	});
	
    
    
    
    
    
    
    
    
    // 소셜 회원가입 ajax
    $('.facebookJoinAction').click(function() {
	    var nickname = $('#nicknameChk').val().trim();
	    var phone = $('#phoneChk').val().trim();

	    if (nickname == null || nickname == '' || nickname == 'undefined') {
    		$('#nicknameWarning span').html('닉네임을 입력해주세요.');
        }
	    if (phone == null || phone == '' || phone == 'undefined') {
    		$('#phoneWarning span').html('휴대폰번호를 입력해주세요.');
        }
	    if ($("#chkY").is(":checked") == false) {
			alert('서비스 이용약관, 개인정보처리방침 동의 시 회원가입이 가능합니다.');
			$('#chkY').focus();
			return false;
		}
		
		if(nickname != '' && phone != '' && $('#chkY').is(':checked') == true){
			
			//formData 객체생성
			var formData = new FormData($('#facebookJoinForm')[0]);
			
			$.ajax({
	            type:'post',
	            enctype: 'multipart/form-data',
	            url:'facebookJoinAction.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
	            success : function(data) {
	                if(data == "notNickname") {
	        			$('#nicknameWarning span').html('이미 존재하는 닉네임 입니다.');
	                	phone.focus();
	                } else if(data == "notPhone") {
	        			$('#phoneWarning span').html('이미 가입된 핸드폰 번호 입니다.');
	                	phone.focus();
	                } else if(data == "joinOk") {
	                	alert("회원가입을 축하합니다.\n로그인 후 '지금 달려갈 개'의 서비스를 이용하실 수 있습니다.");
	    				location.reload();
	                	window.location.href = 'login.do';
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);}
    		});
		}
	});
    

	
	//소셜로그인 프로필 변경 ajax
	$('.socialMyinfoBtn').click(function() {
	    var nickname = $('#nicknameChk').val().trim();
	    var phone = $('#phoneChk').val().trim();
	    
		if(nickname != '' && phone != ''){
			//formData 객체생성
			var formData = new FormData($('#socialMyinfoForm')[0]);
			
			$.ajax({
	            type:'post',
	            enctype: 'multipart/form-data',
	            url:'socialMyinfoAction.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
				success : function(data) {
            		if(data == "myinfoOk") {
        				alert("나의 프로필 정보가 변경되었습니다.");
	    				location.reload();
	                	window.location.href = 'mypage.do?userId='+userId;
	                } else if(data == "notNickname") {
	                	console.log('안녕하세요.');
	        			$('#socialNicknameWarning span').html('이미 존재하는 닉네임 입니다.');
	                	nickname.focus();
	                } else if(data == "notPhone") {
	        			$('#socialPhoneWarning span').html('이미 가입된 핸드폰 번호 입니다.');
	                	phone.focus();
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});	
		} else {
			alert('비밀번호를 입력해야 나의 프로필 수정이 가능합니다.');
			$('#userPwdChk').focus();
		}
	});
 
	
	//소셜회원탈퇴
	$(".socialMemberLeaveBtn").click(function(){
		var result = confirm('회원탈퇴를 하시겠습니까?\n탈퇴된 회원은 되돌릴 수 없으니 신중하게 선택해주세요.');
		
		if(result == true){
			console.log(result);
			//formData 객체생성
			var formData = new FormData($('#socialMyinfoForm')[0]);
			
			$.ajax({
	            type:'post',
	            url:'socialMemberLeave.do',
	            data: formData, // 필수
	            processData: false, // 필수
	            contentType: false, // 필수
	            cache: false,
				success : function(data) {
					if(data == "myinfoOk") {
	        			alert('회원탈퇴가 처리되었습니다.\n이용해주셔서 감사합니다.');
	        			window.location.href='logout.do';
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
	    		}
			});
		} else {
			
		}
		
	});
		
});



// 로그인 아이디(이메일) 체크 저장
$(document).ready(function(){
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $(".userLoginId").val(key); 
     
    if($(".userLoginId").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $(".userLoginId").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $(".userLoginId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#userIdChk").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
