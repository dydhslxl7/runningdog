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
    		$('#pwdWarning2 span').html('비밀번호 다시 한번 입력해주세요.');
        } else if (!(pwd2.match(pwqRegExp))) {
    		$('#pwdWarning2 span').html('특수문자 / 문자 / 숫자 포함, 8~15자리 이내로 입력해주세요.');
        } else {
    		$('#pwdWarning2 span').html('');
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
 
	//멤버공통 정규표현식  *로그인포함 끝 ***********************************************
    
    
    
	//회원추가 ajax
    $('.memberInsert_btn').click(function() {
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
    		$('#pwdWarning2 span').html('비밀번호 다시 한번 입력해주세요.');
        }
	    if (pwd2 != pwd) {
    		$('#pwdWarning2 span').html('입력하신 비밀번호가 일치하지 않습니다.');
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
			var formData = new FormData($('#memberInsertForm')[0]);
			
			$.ajax({
	            type:'post',
	            enctype: 'multipart/form-data',
	            url:'adminMemberInsertAction.ad',
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
	                } else if(data == "memberInsertOk") {
	                	alert("회원 추가가 완료되었습니다.");
	    				location.reload();
	                }
	            },
	    		error : function(jqXHR, textstatus, errorthrown) { console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);}
    		});
		}
	});
    
    
});





//관리자 회원탈퇴
function leaveChkAction() {
	var cnt = $("input[name='leaveChk']:checked").length;
	var arr = new Array();
	$("input[name='leaveChk']:checked").each(function() {
		arr.push($(this).attr('id'));
	});
	if (cnt == 0) {
		alert("선택된 회원이 없습니다.");
	} else if(cnt != 0 && confirm("선택한 회원을 탈퇴처리 하시겠습니까?")) {
		$.ajax({
			type : 'POST',
			url : "memberLeaveAction.ad",
			data : "RPRT_ODR=" + arr + "&CNT=" + cnt,
			dataType : "json",
			success : function(data) {
				if (data != 1) {
					alert("선택된 회원 탙퇴가 실패했습니다.");
				} else {
					alert("선택된 회원 탈퇴가 성공했습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus + ", "
						+ errorthrown);
			}
		});
	}
}


//관리자 탈퇴회원 DB 삭제
function deleteChkAction() {
	var cnt = $("input[name='deleteChk']:checked").length;
	var arr = new Array();
	$("input[name='deleteChk']:checked").each(function() {
		arr.push($(this).attr('id'));
	});
	if (cnt == 0) {
		alert("선택된 회원이 없습니다.");
	} else if(cnt != 0 && confirm("선택한 회원을 삭제처리 하시겠습니까?")) {
		$.ajax({
			type : 'POST',
			url : "memberDeleteAction.ad",
			data : "RPRT_ODR=" + arr + "&CNT=" + cnt,
			dataType : "json",
			success : function(data) {
				if (data != 1) {
					alert("선택된 회원 삭재가 실패했습니다.");
				} else {
					alert("선택된 회원 삭제가 성공했습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus + ", "
						+ errorthrown);
			}
		});
	}
}




