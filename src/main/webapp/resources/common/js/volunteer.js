/* 파일용량체크 */
function che_Size(input) {
    if (input.files && input.files[0].size > (10 * 1024 * 1024)) {
        alert("이미지 크기가 10mb 를 넘습니다.");
        input.value = null;
    }
}


// 파일업로드 시 이미지만 받게함
 function chk_type(obj){
	 var file_kind = obj.value.lastIndexOf('.');
	 var file_name = obj.value.substring(file_kind+1,obj.length);
	 var file_type = file_name.toLowerCase();
	 
	 var check_file_type = new Array();
	 
	 check_file_type = ['jpg' ,'png', 'jpeg', 'bmp'];
	 
	 if (check_file_type.indexOf(file_type)==-1){
		 alert('이미지 파일만 선택할 수 있습니다.');
		 var parent_Obj = obj.parentNode
		 var node = parent_Obj.replaceChild(obj.cloneNode(true), obj);
		return false;
	 }
 }

//sns공유하기
 $(function(){
 	$('[data-toggle="popover3"]').popover({
 		container: $(this).attr('id'),
 		placement: 'bottom',
 		title: "공유하기",
 		html: true,
 		content: function() {
 			var id = $(this).attr('data-id');
 			var title = $(this).attr('data-title');
 			var image = $(this).attr('data-image');

 			
 			var value = "";
 			value += "<a href='javascript:snsGo(1, \""+ title + "\");'><img src='resources/images/snsIcn/sns_naver.png' style='width:30px;' alt='네이버'></a>&nbsp;&nbsp;";
 			value += "<a id='kakao-link-btn' href='javascript:sendLink(\""+ title + "\", \""+ image +"\")'><img src='resources/images/snsIcn/sns_ka.png' style='width:30px' alt='카카오톡'></a>&nbsp;&nbsp;";
 			value += "<a href='javascript:snsGo(3, \""+ title + "\");'><img src='resources/images/snsIcn/sns_face.png' style='width:30px' alt='페이스북'></a>&nbsp;&nbsp;";
 			value += "<a href='javascript:snsGo(4, \""+ title + "\");'><img src='resources/images/snsIcn/sns_tw.png' style='width:30px' alt='트위터'></a><br>";
 			value += "<a href='javascript:CopyUrlToClipboard();' class='urlcopy'>URL 복사</a>";
 			return value;
 		}
 	});
 });
 
//url 복사
 function CopyUrlToClipboard() {
 	//window.document.location.href -> 현재 url정보 얻는 방법
 	var obShareUrl = window.document.location.href;

 	console.log(obShareUrl);
 	var t = document.createElement("textarea");
 	document.body.appendChild(t);
 	t.value = obShareUrl;
 	t.select();
 	document.execCommand('copy');
 	document.body.removeChild(t);

 	alert("URL이 클립보드에 복사되었습니다");
 }

 function snsGo(e, title) {
		var url = window.document.location.href;
		
		console.log(title + url)
		
		var loc = "";
		switch(e) {
		case 1 : loc = 'https://share.naver.com/web/shareView.nhn?url=' + encodeURIComponent(url) + '&title=' + encodeURIComponent(title); break; //네이버
		case 3 : loc = 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url) + '&t=' + encodeURIComponent(title); break;
		case 4 : loc = 'http://www.twitter.com/intent/tweet?url=' + encodeURIComponent(url) + '&text=' + encodeURIComponent(title); break; //트위터
		}
		window.open(loc, '', 'width=400,height=400,left=600');
	}
  
//카카오톡 공유
//사용할 앱의 JavaScript 키를 설정해 주세요.


function sendLink(title, img) {
 //카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
  
  //Kakao.init('53d444db7d449eb66c0229426868cf97');
  //var shareurl = "http:/192.168.130.170:9392/runningdog/"+ url
  var shareurl = window.document.location.href;
  var image = "http://localhost:9392/runningdog/resources/vfiles/" + img
  console.log("kakaoSendLink"+ shareurl + title + image);
  
  
  Kakao.Link.sendDefault({
        objectType: 'feed',
        content: {
          title: title,
          description: "'지금 달려갈 개' 자원봉사 모집합니다~",
          imageUrl:image,
          link: {
            mobileWebUrl: shareurl,
            webUrl: shareurl,
          },
        },
        buttons: [
          {
            title: '자세히 보기',
            link: {
              mobileWebUrl: shareurl,
              webUrl: shareurl,
            },
          },
        ],
      })
}
//sns공유하기 끝


