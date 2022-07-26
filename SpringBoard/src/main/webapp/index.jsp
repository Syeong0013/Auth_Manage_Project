<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>

	<style>
		body{
			margin:0px;
		}
	
	</style>

<meta charset="UTF-8">
<title>관리 프로그램</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function(){
			$("#loginbtn").click(function(){
				var isResult = true;
				
				var id = $("input[name='id']").val();
				if(id.trim().length==0){
					alert("id를 입력하세요.");
					$("input[name='id']").focus();
					isResult = false;
				}
				
				var pw = $("input[name='pw']").val();
				if(pw.trim().length==0){
					alert("비밀번호를 입력하세요.");
					$("input[name='pw']").focus();
					isResult = false;
				}
				
				if(!isResult){
					return;
				}
				
				$("#loginForm").submit();
			});	
			
		});
</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" width="1350px" height="630px" align="center" border="1px">
		<tr>
			<td width="700px" align="center" valign="middle">
				<form id="loginForm" action="login" method="post">
					<table cellpadding="0" cellspacing="0" width="400px" align="center" border="1">
						<tr>
							<td width="100px" height="30px" align="center">
								아이디
							</td>
							<td width="300px" height="30px" align="center">
								<input type="text" name="id" style="width:296px; height:100%; padding:0px; margin:0px;"/>
							</td>
						</tr>
						<tr>
							<td width="100px" height="30px" align="center">
								비밀번호
							</td>
							<td width="300px" height="30px" align="center">
								<input type="password" name="pw" style="width:296px; height:100%; padding:0px; margin:0px;"/>
							</td>
						</tr>
						<tr>
							<td width="400px" height="30px" align="center" colspan="2">
								<input type="button" id="loginbtn" value="로그인"/> 
							</td>
						</tr>
					
					</table>
				
				</form>
			</td>
		</tr>
	</table>
</body>
</html>