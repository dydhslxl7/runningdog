//sns공유하기
$(function(){
	$('[data-toggle="popover2"]').popover({
		container: $(this).attr('id'),
		placement: 'bottom',
		title: "공유하기",
		html: true,
		content: function() {
			var url = $(this).attr('data-url');
			var title = $(this).attr('data-title').replace(/\"/g, "").replace(/\'/g, "&#39;");
			var image = $(this).attr('data-image');
			console.log(title)
			var value = "";
			value += "<a href='javascript:naverShare(\""+url+"\", \""+ title + "\");'><img src='resources/images/snsIcn/sns_naver.png' style='width:30px;' alt='네이버' onclick='event.cancelBubble=true'></a>&nbsp;&nbsp;";
			value += "<a id='kakao-link-btn' href='javascript:kakaoSendLink(\""+url+"\", \""+ title + "\", \""+ image +"\")'><img src='resources/images/snsIcn/sns_ka.png' style='width:30px' alt='카카오톡' onclick='event.cancelBubble=true'></a>&nbsp;&nbsp;";
			value += "<a href='javascript:facebookShare(\""+url+"\", \""+ title + "\");'><img src='resources/images/snsIcn/sns_face.png' style='width:30px' alt='페이스북' onclick='event.cancelBubble=true'></a>&nbsp;&nbsp;";
			value += "<a href='javascript:twitterShare(\""+url+"\", \""+ title + "\");'><img src='resources/images/snsIcn/sns_tw.png' style='width:30px' alt='트위터'onclick='event.cancelBubble=true'></a><br>";
			value += "<a href='javascript:CopyUrlToClipboard(\""+url+"\");' class='urlcopy' onclick='event.cancelBubble=true'>URL 복사</a>";
			return value;
		}
	});
});
$('.xi-share-alt-o').click(function(){
	
	console.log("클릭확인용");
});

//팝오버 범위 밖 클릭하면 닫기
$(document).on('click', function (e) {
    $('[data-toggle="popover"],[data-original-title]').each(function () {
        //the 'is' for buttons that trigger popups
        //the 'has' for icons within a button that triggers a popup
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {                
            (($(this).popover('hide').data('bs.popover')||{}).inState||{}).click = false  // fix for BS 3.3.6
        }

    });
});

//url 복사
function CopyUrlToClipboard(url) {
	//window.document.location.href -> 현재 url정보 얻는 방법
	var t = document.createElement("textarea");
	document.body.appendChild(t);
	t.value = url;
	t.select();
	document.execCommand('copy');
	document.body.removeChild(t);

	alert("URL이 클립보드에 복사되었습니다");
}

function naverShare(url, title){
	console.log('naverShare' + title);
	loc = 'https://share.naver.com/web/shareView.nhn?url=' + encodeURIComponent(url) + '&title=' + encodeURIComponent(title);
	window.open(loc, '', 'width=400,height=400,left=600');
}

function facebookShare(url, title){
	console.log('facebookShare');
	loc = 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url) + '&t=' + encodeURIComponent(title);
	window.open(loc, '', 'width=400,height=400,left=600');
}

function twitterShare(url, title){
	console.log('twitterShare' + title);
	loc = 'http://www.twitter.com/intent/tweet?url=' + encodeURIComponent(url) + '&text=' + encodeURIComponent(title);
	window.open(loc, '', 'twittersharedialog', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');
}


//카카오톡 공유
//사용할 앱의 JavaScript 키를 설정해 주세요.


function kakaoSendLink(url, title, img) {
  //카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
	//Kakao.init('53d444db7d449eb66c0229426868cf97');
	//var shareurl = "http://localhost:9392/runningdog/" + url;
	var image = img.substring(img.indexOf(["name="]) + 5, img.length);
	console.log("kakaoSendLink" + url + title + image);
	
	var title = title.replace("&#39;", "'")
	
	Kakao.Link.sendDefault({
	      objectType: 'feed',
	      content: {
	        title: title,
	        description: "'지금 달려갈 개' 오늘의 이슈를 만나보세요~",
	        imageUrl:image,
	        link: {
	          mobileWebUrl: url,
	          webUrl: url,
	        },
	      },
	      buttons: [
	        {
	          title: '자세히 보기',
	          link: {
	            mobileWebUrl: url,
	            webUrl: url,
	          },
	        },
	      ],
	    })
}
//sns공유하기 끝





