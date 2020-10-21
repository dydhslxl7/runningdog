$(document).ready(function(){
	/* 관리자 상식리스트에서 페이지 동물종류 선택 */
    $("#searchAnimal").change(function() {
        location.href="cknowlist.ad?animal=" + $("#searchAnimal").val();
    });
    
    /* 관리자 상식리스트에서 페이지 동물종류 선택 */
    $("#searchOrder").change(function() {
        location.href="cissuelist.ad?order=" + $("#searchOrder").val();
    });    
	
});


/* 상식리스트에서 페이지 동물종류 선택 */
function moveSearchKnow(animal){
	location.href="cknowlist.do?animal=" + animal;
} 

/* 이슈리스트 페이지 정렬 선택 */ 
function moveSearchIssue(order){
	location.href="cissuelist.do?order=" + order;
} 

/* 메인에서 이슈 상세페이지 이동 */
function moveIssueDetail(link){
	 console.log("버튼클릭");
	 location.href = "cissuedetail.do?link=" + link;
}


