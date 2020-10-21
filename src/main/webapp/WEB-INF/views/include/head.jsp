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

<title>지금 달려갈 개</title>

<link rel="shortcut icon" href="resources/images/common/favicon.ico">
<link href="resources/common/css/common.css" rel="stylesheet">

<script src="resources/common/js/jquery-3.5.1.min.js"></script>
<script src="resources/dboard/js/dboard.js"></script>
<script src="resources/common/js/bootstrap.js"></script>
<script src="resources/common/js/common.js"></script>
<script src="resources/common/js/vegas.js"></script>
<script src="resources/common/js/masonry-docs.min.js"></script>
<script src="resources/common/js/swiper.min.js"></script>
<script src="resources/common/js/member.js"></script>
<script src="resources/common/js/sponsor.js"></script>
<script src="resources/common/js/volunteer.js"></script>
<script src="resources/common/js/contents.js"></script>
<script src="resources/common/js/notice.js"></script>
<link href="${pageContext.request.contextPath}/resources/summernote/summernote.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/summernote/summernote.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- include summernote-ko-KR -->
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<!-- 소셜로그인 API -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="/runningdog/resources/common/js/kakaoLogin.js"></script>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v8.0&appId=1200941690288936&autoLogAppEvents=1" nonce="T57R8Bl1"></script>
<script src="resources/common/js/facebookLogin.js"></script>
<script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script src="resources/common/js/naveridlogin_js_sdk_2.0.0.js"></script>
<script src="resources/common/js/naverLogin.js"></script>
<!-- 소셜로그인 API 끝 -->

<script src="resources/common/js/issueShare.js"></script>

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