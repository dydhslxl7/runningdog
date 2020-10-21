

    function checkHideAll(){
    	if($("input[name=checkHideAll]").is(":checked")){
    		$("input[name=checkHide]").prop("checked", true);
    	}else{
    		$("input[name=checkHide]").prop("checked", false);
    	}
    }
			
    function dboardHide(page){
    	var page = page;
    	var checkRow = "";
    	$("input[name='checkHide']:checked").each(function(){
    		checkRow = checkRow + $(this).val()+",";
    	});
    	checkRow = checkRow.substring(0, checkRow.lastIndexOf(","));
    	
    	if(checkRow == ""){
    		alert("숨길 게시물을 선택해 주세요");
    		return false;
    	}
    	
    	console.log("### checkRow => {"+checkRow+"}");
    	
    	if(confirm("게시물을 숨김 처리 하겠습니까?"))
    		location.href = "dListHide.ad?checkRow=" + checkRow + "&page=" + page;
    }




/* 파일용량체크 */
function checkSize(input) {
    if (input.files && input.files[0].size > (10 * 1024 * 1024)) {
        alert("이미지 크기가 10mb 를 넘습니다.");
        input.value = null;
    }
}

//좌표값 미지정시 alert창
function check() {
  if(formname.mapX.value == "") {
    alert("발견장소를 클릭해 주세요.");
    formname.mapX.focus();
    return false;
  }
  else if(formname.mapY.value == "") {
    alert("발견장소를 클릭해 주세요.");
    formname.mapY.focus();
    return false;
  }
  else return true;

}
//이미지 클릭시 원본 사이즈 팝업
 function fnImgPop(url){
  var img=new Image();
  img.src=url;
  var img_width=img.width;
  var win_width=img.width+25;
  var img_height=img.height;
  var win=img.height+30;
  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
 }

 
// 파일업로드 시 이미지만 받게함
 function chk_file_type(obj){
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

 
 /*연락처 입력 폼*/
function inputTelNumber(obj) {

    var number = obj.value.replace(/[^0-9]/g, "");
    var tel = "";

    // 서울 지역번호(02)가 들어오는 경우
    if(number.substring(0, 2).indexOf('02') == 0) {
        if(number.length < 3) {
            return number;
        } else if(number.length < 6) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2);
        } else if(number.length < 10) {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 3);
            tel += "-";
            tel += number.substr(5);
        } else {
            tel += number.substr(0, 2);
            tel += "-";
            tel += number.substr(2, 4);
            tel += "-";
            tel += number.substr(6);
        }
    
    // 서울 지역번호(02)가 아닌경우
    } else {
        if(number.length < 4) {
            return number;
        } else if(number.length < 7) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3);
        } else if(number.length < 11) {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 3);
            tel += "-";
            tel += number.substr(6);
        } else {
            tel += number.substr(0, 3);
            tel += "-";
            tel += number.substr(3, 4);
            tel += "-";
            tel += number.substr(7);
        }
    }

    obj.value = tel;
}


//sns공유하기
$(function(){
   $('[data-toggle="popover4"]').popover({
      container: $(this).attr('id'),
      placement: 'bottom',
      title: "공유하기",
      html: true,
      content: function() {
         var id = $(this).attr('data-id');
         var title = $(this).attr('data-title').replace(/\'/g, "&#39;");
         var image = $(this).attr('data-image');
         console.log("되나 한번 보자"+id+title+image);
         
         var value = "";
         value += "<a href='javascript:snsGo1(1,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_naver.png' style='width:30px;' alt='네이버'></a>&nbsp;&nbsp;";
         value += "<a id='kakao-link-btn' href='javascript:sendLink1("+id+",\""+ title + "\", \""+ image +"\")'><img src='resources/images/snsIcn/sns_ka.png' style='width:30px' alt='카카오톡'></a>&nbsp;&nbsp;";
         value += "<a href='javascript:snsGo1(3,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_face.png' style='width:30px' alt='페이스북'></a>&nbsp;&nbsp;";
         value += "<a href='javascript:snsGo1(4,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_tw.png' style='width:30px' alt='트위터'></a><br>";
         value += "<a href='javascript:CopyUrltoClipBoard("+id+");' class='urlcopy'>URL 복사</a>";
         return value;
      }
   });
});
//http://192.168.30.34:9392/runningdog/
//url 복사


//팝오버 범위 밖 클릭하면 닫기 
$(document).on('click', function (e) {
  $('[data-toggle="popover4"],[data-original-title]').each(function () {
      //the 'is' for buttons that trigger popups
      //the 'has' for icons within a button that triggers a popup
      if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {                
          (($(this).popover('hide').data('bs.popover')||{}).inState||{}).click = false  // fix for BS 3.3.6
      }

  });
});
function CopyUrltoClipBoard(id) {
   //window.document.location.href -> 현재 url정보 얻는 방법
   var obShareUrl = "http://192.168.30.34:9392/runningdog/dboardView.do?dNum=" + id;

   console.log(obShareUrl);
   var t = document.createElement("textarea");
   document.body.appendChild(t);
   t.value = obShareUrl;
   t.select();
   document.execCommand('copy');
   document.body.removeChild(t);

   alert("URL이 클립보드에 복사되었습니다");
}

function snsGo1(e, id,title) {
	var url = "http://192.168.30.34:9392/runningdog/dboardView.do?dNum=" + id;
     
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


function sendLink1(id,title, img) {
//카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
 
 //Kakao.init('53d444db7d449eb66c0229426868cf97');
 //var shareurl = "http:/192.168.130.170:9392/runningdog/"+ url
 var shareurl = "http://192.168.30.34:9392/runningdog/dboardView.do?dNum=" + id;
 var image = "http://192.168.30.34:9392/runningdog/resources/dboard/dboardImage/" + img
 console.log("kakaoSendLink"+ shareurl + title + image);
 
 
 Kakao.Link.sendDefault({
       objectType: 'feed',
       content: {
         title: title,
         description: "'지금 달려갈 개' 유기동물을 보호해주세요.",
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



//sns공유하기
$(function(){
 $('[data-toggle="popover5"]').popover({
    container: $(this).attr('id'),
    placement: 'bottom',
    title: "공유하기",
    html: true,
    content: function() {
       var id = $(this).attr('data-id');
       var title = $(this).attr('data-title').replace(/\'/g, "&#39;");
       var image = $(this).attr('data-image');
       
       var value = "";
       value += "<a href='javascript:snsGo1(1,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_naver.png' style='width:30px;' alt='네이버'></a>&nbsp;&nbsp;";
       value += "<a id='kakao-link-btn' href='javascript:sendLink1("+id+",\""+ title + "\", \""+ image +"\")'><img src='resources/images/snsIcn/sns_ka.png' style='width:30px' alt='카카오톡'></a>&nbsp;&nbsp;";
       value += "<a href='javascript:snsGo1(3,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_face.png' style='width:30px' alt='페이스북'></a>&nbsp;&nbsp;";
       value += "<a href='javascript:snsGo1(4,"+id+", \""+ title + "\");'><img src='resources/images/snsIcn/sns_tw.png' style='width:30px' alt='트위터'></a><br>";
       value += "<a href='javascript:CopyUrltoClipBoard("+id+");' class='urlcopy'>URL 복사</a>";
       return value;
    }
 });
});
//http://192.168.30.34:9392/runningdog/
//url 복사


//팝오버 범위 밖 클릭하면 닫기 
$(document).on('click', function (e) {
$('[data-toggle="popover5"],[data-original-title]').each(function () {
    //the 'is' for buttons that trigger popups
    //the 'has' for icons within a button that triggers a popup
    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {                
        (($(this).popover('hide').data('bs.popover')||{}).inState||{}).click = false  // fix for BS 3.3.6
    }

});
});
function CopyUrltoClipBoard(id) {
 //window.document.location.href -> 현재 url정보 얻는 방법
 var obShareUrl = "http://192.168.30.34:9392/runningdog/animalView.do?desertionNo=" + id;

 console.log(obShareUrl);
 var t = document.createElement("textarea");
 document.body.appendChild(t);
 t.value = obShareUrl;
 t.select();
 document.execCommand('copy');
 document.body.removeChild(t);

 alert("URL이 클립보드에 복사되었습니다");
}

function snsGo(e, id,title) {
	var url = "http://192.168.30.34:9392/runningdog/animalView.do?desertionNo=" + id;
   
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


function sendLink1(id,title, img) {
//카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.

//Kakao.init('53d444db7d449eb66c0229426868cf97');
//var shareurl = "http:/192.168.130.170:9392/runningdog/"+ url
var shareurl = "http://192.168.30.34:9392/runningdog/animalView.do?desertionNo=" + id;
var image =  img;
console.log("kakaoSendLink"+ shareurl + title + image);


Kakao.Link.sendDefault({
     objectType: 'feed',
     content: {
       title: title,
       description: "'지금 달려갈 개' 유기동물을 보호해주세요.",
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