<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, Pkg.Admin.VO.AuthDTO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한관리</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="jscss/js/common.js"></script>

	<script>
	$(document).ready(function(){
		$("#btnSearch").on("click", function(){
			location.href="AuthList?authName=" + $("#authNames").val();
		});
				
		$("#btnAdd").click(function(){
			var strHTML = "";
						
			strHTML += "<tr>";
			strHTML += '<td width="100px" height="30px" align="center">';
			strHTML += '<input type="checkbox" name="chk"  value="" />';
			strHTML += '</td>';
			strHTML += '<td width="200px" height="30px" align="center">';
			strHTML += '<input type="text" name="authID" value="NEWID" style="width:98%;height:98%" readonly/>';
			strHTML += '</td>';
			strHTML += '<td width="400px" height="30px" align="center">';
			strHTML += '<input type="text" name="authName" style="width:98%;height:98%"/>';
			strHTML += '</td>';
			strHTML += '<input type="hidden" value="I" name="gbn" />';
			strHTML += "</tr>";
			$("#authTbl tbody").append(strHTML);
		});
		
		// onchange 메소드
		$("input[name='authName']").change(function(){
			var indexNum = $("input[name='authName']").index(this);
			$("input[name='gbn']").eq(indexNum).val("U");
		});
		
		// btnSave 저장버튼
		$("#btnSave").click(function(){
			var isCheck = true;
			$("input[name='authName']").each(function(){
				if($(this).val().length == 0){
					isCheck = false;
				}
			});
			
			if(!isCheck){
				alert("권한명을 입력하시오.");
				return;
			}
			
			$("#authListForm").attr("action", "SaveAuthList");
			$("#authListForm").submit();
		});
		
		
		//chkAll event
		$("#chkAll").on("click", function(){
			$("input[name='chk']").prop("checked", $(this).prop("checked"));
		}); 
		
		//chk event
		$("input[name='chk']").on("click", function(){
			var chkAll = $("input[name='chk']").length;
			var isChk = $("input[name='chk']:checked").length;
		
			if(chkAll == isChk){
				$("#chkAll").prop("checked", true);
			}else{
				$("#chkAll").prop("checked", false);
			}
		});
		
		//삭제버튼
		$("#btnDelete").click(function(){
			var hiddenNames = [];
			var hiddenVals = [];
			
			$("input[name='chk']:checked").each(function(index){
				hiddenNames[index] = "authID";
				hiddenVals[index] = $(this).val();
			});
			
			var obj = new objectSubmit("chkForm", "DelAuthList", "post", hiddenNames, hiddenVals);
			obj.linkSubmit();
		});
		
		
	});
	</script>
</head>
<body>
<%
	List<AuthDTO> authList = (List<AuthDTO>)request.getAttribute("authList");
	String authName = (String)request.getAttribute("authName");
	
	authName = (authName == null) ? "" : authName;
%>
	<form id="authListForm" name="authListForm" method="post">
	<table cellpadding="0" cellspacing="0" width="700px" align="center" border="1" id="authTbl">
		<tr>
			<td width="700px" height="30px" align="" colspan="4">
				<input type="text" name="authNames" id="authNames" value="<%=authName%>" placeholder="권한명을 입력하시오."/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="조회" id="btnSearch"/>
				<input type="button" value="추가" id="btnAdd"/>
				<input type="button" value="저장" id="btnSave"/>
				<input type="button" value="삭제" id="btnDelete"/>
			</td>
		</tr>
		<tr>
			<td width="100px" height="30px" align="center">
				<input type="checkbox" name="chkAll" id="chkAll" value="" />
			</td>
			<td width="200px" height="30px" align="center">
				권한아이디
			</td>
			<td width="400px" height="30px" align="center">
				권한이름
			</td>
		</tr>
		
		
		<% for(AuthDTO dto : authList) { %>
		<tr>
			<td width="100px" height="30px" align="center">
				<input type="checkbox" name="chk"  value="<%=dto.getAuthID() %>" />
			</td>
			<td width="200px" height="30px" align="center">
				<input type="text" name="authID" value="<%=dto.getAuthID() %>" style="text-align:center; width:98%;height:98%" readonly/>
			</td>
			<td width="400px" height="30px" align="center">
				<input type="text" name="authName" value="<%=dto.getAuthName() %>" style="text-align:center; width:98%;height:98%" onchange="updateFunc()"/>
			</td>
				<input type="hidden" value="" name="gbn" readonly />
		</tr>
		<% } %>
		
	</table>
	</form>

</body>
</html>