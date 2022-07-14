<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Pkg.Admin.VO.ProgramDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 관리</title>
	<style>
		.body{
			margin:0px;
			font-size:12px;
		}
		
		#wrap{                                                                                                                                                                                                                                                                           
			width:900px;
			margin:auto;
		}
		
		.search{
			width:900px;
			border:0px solid red;
			padding:4px 0px 4px 0px;
			clear:both;
		}
		
		.row{
			width:900px;
			border:0px solid red;
			/*padding:4px 0px 4px 0px;*/
			clear:both;
		}
		
		.col1{
			border:1px solid #444;
			width:50px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col1{
			border:1px solid #444;
			width:50px;
			padding:2px 0px 3px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col2{
			border:1px solid #444;
			width:150px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col3{
			border:1px solid #444;
			width:220px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col4{
			border:1px solid #444;
			width:150px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col5{
			border:1px solid #444;
			width:10px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="jscss/js/common.js"></script>

</head>
<body>
<%
	List<ProgramDTO> list = (List<ProgramDTO>)request.getAttribute("programList");
%>
	<div class="row">
		<span class="col1"><input type="checkbox" /></span>
		<span class="col2">아이디</span>
		<span class="col3">프로그램명</span>
		<span class="col2">연결 메뉴</span>
		<span class="col2">jsp</span>
		<span class="col2">url</span>
		<span class="col5"><input type="text" /></span>
	</div>
	<% for(ProgramDTO dto: list){ %>
	<div class="row">
		<span class="col1"><input type="checkbox" /></span>
		<span class="col2"><%= dto.getpID() %></span>
		<span class="col3"><%= dto.getpName() %></span>
		<span class="col2"><%= dto.getMenuID() %></span>
		<span class="col2"><%= dto.getpFileName() %></span>
		<span class="col2"><%= dto.getFileUrl() %></span>
		<span class="col5"><input type="text" /></span>
	</div>
	<% } %>
</body>
</html>