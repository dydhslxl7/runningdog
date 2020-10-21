<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="title" content="지금 달려갈 개" />
<meta name="description" content="지금 달려갈 개 설명" />
<meta name="keywords" content="지금 달려갈 개 키워드" />

<title>관리자 화면</title>

<link rel="shortcut icon" href="resources/images/common/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/admin/css/common.css">
<link rel="stylesheet" type="text/css" href="resources/common/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="resources/common/css/swiper.min.css">
<script src="resources/common/js/jquery-3.5.1.min.js"></script>
<script src="resources/common/js/bootstrap.js"></script>
<script src="resources/common/js/swiper.min.js"></script>
<script src="resources/common/js/common.js"></script>
<script src="resources/common/js/sponsor.js"></script>
<script src="resources/dboard/js/dboard.js"></script>
<script src="resources/admin/js/member.js"></script>
<script src="resources/common/js/contents.js"></script>
<script src="resources/common/js/notice.js"></script>
<link href="${pageContext.request.contextPath}/resources/summernote/summernote.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/summernote/summernote.js"></script>
<!-- include summernote-ko-KR -->
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>


<!--티스토리 불펌금지-->
<!-- <script type="text/javascript">
    var omitformtags=["input", "textarea", "select"]
    omitformtags=omitformtags.join("|")
    function disableselect(e){
    if (omitformtags.indexOf(e.target.tagName.toLowerCase())==-1)
        return false
    }
    function reEnable(){
        return true
    }
    if (typeof document.onselectstart!="undefined")
        document.onselectstart=new Function ("return false")
    else{
        document.onmousedown=disableselect
        document.onmouseup=reEnable
    }
</script> -->