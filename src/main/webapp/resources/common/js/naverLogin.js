var naverLogin = new naver.LoginWithNaverId({
	clientId: "BH_kSon1igZkUqwElBdD",
	callbackUrl: "http://192.168.30.34:9392/runningdog/login.do",
	isPopup: true, /* 팝업을 통한 연동처리 여부 */
	loginButton: {color: "green", type: 3, height: 60}
	/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
	}
);
	
/* 설정정보를 초기화하고 연동을 준비 */
naverLogin.init();


/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
				/* (5) 필수적으로 받아야하는 프로필 정보가 있다면 callback처리 시점에 체크 */
			var email = naverLogin.user.getEmail();
			var nickname = naverLogin.user.getNickName();
			var profileImage = naverLogin.user.getProfileImage();
			
			if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			} else if( nickname == undefined || nickname == null) {
				alert("별명 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			} else if( profileImage == undefined || profileImage == null) {
				alert("프로필사진은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
	
			console.log("email : " + email);
			console.log("nickname : " + nickname);
			console.log("profileImage : " + profileImage);
			console.log("status : " + status);
		
			console.log("확인2");
			//location.href="naverLogin.do?id=" + email + "&nickname=" + nickname + "&profileImage=" + profileImage;
			window.opener.location.replace("naverLogin.do?id=" + email + "&nickname=" + nickname + "&profileImage=" + profileImage);

		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});
