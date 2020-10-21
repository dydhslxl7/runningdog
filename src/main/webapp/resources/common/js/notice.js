$(document).ready(function(){
	/* 라디오버튼 동적 체크하기 */
	$("input[id='state']").on('click', function() {
		console.log("버튼클릭함");
		if ($('#state').val() == 'checked') {
			console.log("체크되어있음");
			$('#state').prop('checked', false);
			$('#state').val("unchecked");
		} else {
			console.log("체크안되어있음");
			$('#state').prop('checked', true);
			$('#state').val("checked");
		}
	});
	
	/* 첩부파일 선택창 숨기기 */
	$('#showSelect1').hide();
	$('#showSelect2').hide();
	$('#showSelect3').hide();
	
	/* 전체삭제(th)에 있는 체크 박스 클릭시 아래 체크들 전체 체크 */
	$("#allCheck").on("click", function(){
		var chk = $("#allCheck").prop("checked");
		if(chk) {
			$("input[name=checkDel]").prop("checked", true);
		} else {
			$("input[name=checkDel]").prop("checked", false);
		}
	});	
	
	/* 개별 선택 체크시 전체삭제 체크가 풀어지는거 */
	$("input[name=checkDel]").on("click", function(){
		$("#allCheck").prop("checked", false);
		
		/* 개별 선택 체크가 모두 체크됬을 경우 전체 삭제 체크 되게 하기 */
		if($("input[name=checkDel]:checked").length == $("input[name=checkDel]").length){
			$("#allCheck").prop("checked", true);
		}
	});
ㄴ	
});


/* update 페이지  */
/* 파일 삭제 누르면 첨부파일 선택창 나오게 하기 */
function showFileSelect1() {
	var files = document.getElementById("files");
	var originalFile = document.getElementById("original1");
	files.removeChild(originalFile);
	$('#showSelect1').show();
}
function showFileSelect2() {
	var files = document.getElementById("files");
	var originalFile = document.getElementById("original2");
	files.removeChild(originalFile);
	$('#showSelect2').show();
}
function showFileSelect3() {
	var files = document.getElementById("files");
	var originalFile = document.getElementById("original3");
	files.removeChild(originalFile);
	$('#showSelect3').show();
}

/* 삭제버튼 눌렀을때 original파일 이름 보내기 */
function deletefile1() {
	var deleteFilename = '<c:out value="${notice.noticeOriginalFilename1}"/>';
	var tag = "<input type='hidden' name='deleteFilename1' value='" + deleteFilename + "'>";
	$("#inHere").append(tag);
	console.log("1번 파일삭제" + deleteFilename + tag);
}
function deletefile2() {
	var deleteFilename = '<c:out value="${notice.noticeOriginalFilename2}"/>';
	var tag = "<input type='hidden' name='deleteFilename2' value='" + deleteFilename + "'>";
	$("#inHere").append(tag);
	console.log("2번 파일삭제" + deleteFilename + tag);
}
function deletefile3() {
	var deleteFilename = '<c:out value="${notice.noticeOriginalFilename3}"/>';
	var tag = "<input type='hidden' name='deleteFilename3' value='" + deleteFilename + "'>";
	$("#inHere").append(tag);
	console.log("3번 파일삭제" + deleteFilename + tag);
}

/* 수정 최소하기 버튼 눌리면 새로고침하기 */
function Refresh() {
	window.location.reload();
}


/* view 상세 페이지 */
/* 이전글, 다음글 이동 */
function moveNoticePreDetail(preNo, npre){
    if(preNo == 0){
    	alert("이전글이 없습니다.");
    } else {
		location.href=npre;
    }
}
     
function moveNoticeNextDetail(nextNo, nnext){
	if(nextNo == 0){
		alert("다음글 없습니다.");
	} else {
		location.href=nnext;
	}
}


/* 관리자 list페이지 */
/* 선택삭제 버튼을 클릭했을 때 */
function selectDel(){
	var confirm_val;
	if($("input[name=checkDel]:checked").length == 0) {
		alert("삭제할 대상을 선택하세요.")
	} else {
		confirm_val = confirm('삭제된 게시물은 되돌릴 수 없습니다.\n정말 삭제하시겠습니까?');
	}
	
	if(confirm_val){
		console.log("삭제가 선택되었습니다.");
		var checkArr = new Array();
		
		$("input[name=checkDel]:checked").each(function(){
			checkArr.push($(this).val());
		});
		console.log(checkArr);
		
		$.ajax({
			url : "ndelete.ad",
			type : "post",
			data : { checkDel : checkArr },
			success : function(result){
				if(result == 1) {
					alert("삭제되었습니다.")
					location.href = "nlist.ad";
				} else {
					alert("삭제 실패");
				}
			},
			error : function(request, status, errorData){
				console.log("error code : " + request.status + "\nMessage : " + request.responseText + "\nError : " + errorData);
			}
		}); //ajax
	}
}


/* 메인에서 공지사항 상세페이지 이동 */
function moveNoticeDetail(noticeNo){
	location.href = "ndetail.do?noticeNo=" + noticeNo;
}

