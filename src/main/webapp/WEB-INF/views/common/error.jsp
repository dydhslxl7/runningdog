<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
        <c:import url="/WEB-INF/views/include/head.jsp"/>
	</head>
	<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
		<h1>에러페이지</h1>
		<h3>Servlet message: <%=request.getAttribute("message")%></h3>

		<a href="main.do">메인 페이지로 이동</a>
	</body>
</html>