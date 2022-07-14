<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
</head>
<body>
<%
	String errCode = (String)request.getAttribute("errorCode");
	String errMsg = (String)request.getAttribute("errorMsg");
%>

	<div>에러코드 : <%=errCode %></div>
	<div>에러메시지 : <%=errMsg %></div>
	<div>홍길동(1111) 연락주세요</div>
</body>
</html>