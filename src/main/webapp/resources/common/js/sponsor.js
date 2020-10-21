//sns공유하기
$(function(){
   $('[data-toggle="spopover"]').popover({
      container: $(this).attr('id'),
      placement: 'bottom',
      title: "공유하기",
      html: true,
      content: function() {
         var sid = $(this).attr('data-sid');
         var stitle = $(this).attr('data-stitle').replace(/\'/g, "&#39;");
         var ssummary = $(this).attr('data-ssummary').replace(/\'/g, "&#39;");
         var simage = $(this).attr('data-simage');
         var scount = $(this).attr('data-scount');
         var surl = "http://localhost:9392/runningdog/sdetail.do?sNum=" + sid; //망할 카카오톡은 127로 작동이 안됩니다. 그런데 localhost로 하면 모바일에서 작동안됩니다.^^
         var surl2 = "http://127.0.0.1:9392/runningdog/sdetail.do?sNum=" + sid; //망할 페이스북은 또 local로는 작동이 안됩니다.
         
         var value = "";
         value += "<a href='javascript:snsGos(1, \""+surl+"\", \""+stitle+"\");'><img src='resources/images/snsIcn/sns_naver.png' style='width:30px;' alt='네이버'></a>&nbsp;&nbsp;";
         value += "<a href='javascript:sendLinks(\""+surl+"\", \""+stitle+"\", \""+ssummary+"\", \""+simage+"\", "+scount+");'><img src='resources/images/snsIcn/sns_ka.png' style='width:30px' alt='카카오톡'></a>&nbsp;&nbsp;";
         value += "<a href='javascript:snsGos(3, \""+surl2+"\", \""+stitle+"\");'><img src='resources/images/snsIcn/sns_face.png' style='width:30px' alt='페이스북'></a>&nbsp;&nbsp;";
         value += "<a href='javascript:snsGos(4, \""+surl+"\", \""+stitle+"\");'><img src='resources/images/snsIcn/sns_tw.png' style='width:30px' alt='트위터'></a><br>";
         value += "<a href='javascript:CopyUrlToClipboard(\""+surl+"\");' class='urlcopy'>URL 복사</a>";
         return value;
      }
   });

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

function snsGos(e, url, title) {
   var loc = "";
   switch(e) {
   case 1 : loc = 'https://share.naver.com/web/shareView.nhn?url=' + encodeURIComponent(url) + '&title=' + encodeURIComponent(title); break; //네이버
   case 3 : loc = 'http://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url) + '&t=' + encodeURIComponent(title); break;
   case 4 : loc = 'http://www.twitter.com/intent/tweet?url=' + encodeURIComponent(url) + '&title=' + encodeURIComponent(title); break; //트위터
   }
   window.open(loc, '', 'width=400,height=400,left=600');
}

$(function(){
    Kakao.init('5af2df86f21b8c419bec6598d2c35677');
});

//카카오톡 공유
function sendLinks(surl, title, summary, image, count) {
  //카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
  Kakao.Link.sendDefault({
    objectType: 'feed',
    content: {
      title: title,
      description: summary,
      imageUrl: 'http://localhost:9392/runningdog/resources/sponsor/summernoteContent/'+image,
      link: {
        mobileWebUrl: surl,
        webUrl: surl
      }
    },
    social: {
      viewCount: count
    },
    buttons: [
      {
        title: '자세히 보기',
        link: {
          mobileWebUrl: surl,
          webUrl: surl
        }
      }
    ]
  });
}
//sns공유하기 끝

//썸머노트 이미지 업로드
function sendFile(file, el) {
   var form_data = new FormData();
   form_data.append('file', file);
   $.ajax({
      data: form_data,
      type: "post",
      url: 'summer_image.ad',
      cache: false,
      contentType: false,
      enctype: 'multipart/form-data',
      processData: false,
      success: function(img_name) {
         $(el).summernote('editor.insertImage', img_name);
      }
   });
}

//금액 콤마
function addCommas(x) {
	x = x.replace(/(^0+)/g,'');
	x = x.replace(/[^0-9]/g,'');
	x = x.replace(/,/g,'');
	var pay = $("#amt").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ","));
}

//후원금액
function payOption(ele) {
   var ele = $(ele);
   var pay = $('#amt');
   
   if(ele.val() == "") {
      pay.attr('readonly', false);
      pay.val('');
   }else {
      pay.attr('readonly', true);
      pay.val(ele.val());
   }
}

function checkAc() {  
	var acount = $("#amt").val().replace(/,/g, "");
	console.log(acount);
	if(acount < 1 || acount > 100001) {
		alert("10만원까지만 가능합니다.");
		$("#amt").val("");
	}
}

//무통장입금, 신용카드 선택 창
$(function(){
   $("#bank").hide();
   $("#chk2").on("click", function(){
      $("#bank").show();
   });
   $("#chk1").on("click", function(){
      $("#bank").hide();
   });
});

//썸네일 & 썸머노트 내용 빈칸 확인
$(function(){
   $("#editor").on('submit', function() {
	   if($("#wfile").val().length == 0) {
		   alert("썸네일을 선택해주세요");
		   return false;
	   }
	   if ($('#summernote').summernote('isEmpty') && !($("#wfile").val().length == 0)) {
		   alert('내용을 입력해주세요');
		   return false;
	   }
   });
});

//수정용 썸네일 빈칸 확인
$(function(){
	$("#cucu").on('click', function() {
		if($("#ufile").attr("data-ch") == "y" && $("#ufile").val().length == 0) {
			alert("썸네일을 선택해주세요");
			return false;
		}
	});
});

//(전체/선택) 삭제
function checkAll(){
   if($("input[name=checkAll]").is(":checked")){
      $("input[name=checkDel]").prop("checked", true);
   }else{
      $("input[name=checkDel]").prop("checked", false);
   }
}

/* 개별 선택 체크시 전체삭제 체크가 풀어지는거 
$("input[name=checkDel]").on("click", function(){
   if($("input[name=checkAll]:checked")) {
      $("input[name=checkAll]").prop("checked", false);
   }
    개별 선택 체크가 모두 체크됬을 경우 전체 삭제 체크 되게 하기 
   if($("input[name=checkDel]:checked").length == $("input[name=checkDel]").length){
      $("input[name=checkAll]").prop("checked", true);
   }
});*/

//삭제
function deleteAction(page){
   var page = page;
   var checkRow = "";
   $("input[name='checkDel']:checked").each(function(){
      checkRow = checkRow + $(this).val()+",";
   });
   checkRow = checkRow.substring(0, checkRow.lastIndexOf(","));
   
   if(checkRow == ""){
      alert("삭제할 대상을 선택하세요.");
      return false;
   }
   
   console.log("### checkRow => {"+checkRow+"}");
   
   if(confirm("삭제 하시겠습니까?"))
      location.href = "sdelete.ad?checkRow=" + checkRow + "&page=" + page;
}

//분류 없으면 알림
$(function(){
   $("#seld").on("click", function(){
      if($("select[name='selected'] option:selected").val().length == 0) {
         alert("분류를 선택해주세요");
         return false;
      }
   //공백만 입력하고 검색할 때
   var keyword = $.trim($("input[name=keyword]").val());
      if(keyword == "") {
         alert("내용을 입력해주세요.");
         return false;
      }
   });
});

//썸머노트때문에 리셋추가
function Refresh() {
   $('#summernote').summernote('reset');
   window.location.reload();
}

//파일삭제되면 파일첨부칸 열리게끔 일단 숨김
$(document).ready(function() {
   $('#showSelect').hide();
});

//ajax로 파일삭제
function showFileSelect(snum) {
   $.ajax({
      data: {snum},
      type: "post",
      url: 'sfileDel.ad',
      success: function(result){
    	  if(result == "ok") {
    		  console.log("파일 삭제 성공");
    		  $("input[name=sOriginal]").attr("value", "null");
    		  $("input[name=sOriginal]").attr("value", "null");
    	  }
      },
      error : function(reqest, status, errorData){
         console.log("error code : " + request.status
               + "\nMessage : " + request.responseText
               + "\nError : " + errorData);
      }
   });
   
   var files = document.getElementById("file");
   var originalFile = document.getElementById("ofile");
   files.removeChild(originalFile);
   $('#showSelect').show();
   $("#ufile").attr("data-ch", "y");
}

//기부금 영수증
$(function(){
	$('#spnum').hide();
	$("#yes").on("click", function(){
		$("#spnum").show();
		$('#no').removeClass('active');
		$('#yes').addClass('active');
		$("#re").attr("data-val", "y");
	});
	$("#no").on("click", function(){
		$("#spnum").hide();
		$('#yes').removeClass('active');
		$('#no').addClass('active');
		$("#re").attr("data-val", "n");
		$("input[name=spSnumber]").attr("value", "");
		$("#jumin1").val("");
		$("#jumin2").val("");
	});
});

//개인 or 사업자
$(function(){
   $("#per").on("click", function(){
      $('#peer').removeClass('active');
      $('#per').addClass('active');
   });
   $("#peer").on("click", function(){
      $('#per').removeClass('active');
      $('#peer').addClass('active');
   });
});

//주민번호 유효성 검사
function aaa() {
   var jumins3 = $("#jumin1").val() + $("#jumin2").val();
   
   var fmt = RegExp(/^\d{6}[1234]\d{6}$/);
   var buf = new Array(13);
   
   if(!fmt.test(jumins3)) {
      alert("주민등록번호 형식에 맞게 입력해주세요");
      $("#jumin1").focus();
      return false;
   }
   
   for(var i=0; i<buf.length; i++) {
      buf[i] = parseInt(jumins3.charAt(i));
   }
   
   var multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
   var sum = 0;
   
   for(var i=0; i<12; i++) {
      sum += (buf[i] *= multipliers[i]);
   }
   
   if((11 - (sum % 11)) % 10 != buf[12]) {
      alert("잘못된 주민등록번호입니다.");
      return false;
   }else {
      $("#re").attr("value", "y");
      $("input[name=spSnumber]").attr("value", $("#jumin1").val() +"-"+ $("#jumin2").val());
      alert("올바른 주민등록번호입니다.");
      return false;
   }   
}

//기부금영수증 요청시 검사
$(function(){
   $("#sub").on("click", function(){
      if($("#jumin2").val() == "" && $("#re").val() == "n" && $("#re").attr("data-val") == "y") {
         alert("주민등록번호를 입력해 주세요.");
         $("re").focus();
         return false;
      }
      if($("#jumin2").val() != "" && $("#re").val() == "n") {
         alert("주민등록번호 확인을 눌러주세요.");
         $("re").focus();
         return false;
      }
   });
});

//후원하기 페이지 연락처 입력란 작성
$(function(){
   var phoneRule = /^\d{2,3}-\d{3,4}-\d{4}$/;
   $("input[name='spPhone']").blur(function(){
      if(!phoneRule.test($("input[name='spPhone']").val())) {
         alert("형식에 맞게 입력해주세요.");
         $("input[name='spPhone']").val("");
      }
   });
});

//글자수 제한
function textlength(text) {
	var inputText = $(text).val();
	var inputMax = $(text).prop("maxlength");
	var j = 0;
	var count = 0;
	for(var i = 0; i<inputText.length; i++) {
		val = escape(inputText.charAt(i).length);
		if(val == 6) {
			j++;
		}
		j++;
		if(j <= inputMax) {
			count++;
		}
	}
	if(j > inputMax) {
		$(text).val(inputText.substr(0, count));
	}
}
