<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Pkg.Admin.VO.AuthMenuDTO" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리 프로그램</title>

  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="jscss/js/common.js"></script>
	<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

	
	<script>
	
		var checkVal = function(){
			var isResult = true;
			$("#menuForm input[name='menuName']").each(function(){
				var chkIdx = $("#menuForm form input[name='menuName']").index(this);
				var objMenuSeq = $("#menuForm input[name='menuSeq']").eq(chkIdx);
				if($(this).val().trim().length <= 0 || objMenuSeq.val().trim().length<=0){
					isResult = false;
				}
			});
			
			if(!isResult){
				alert("메뉴이름 또는 메뉴순서는 빈값일수 없습니다.");
				return;
			}
			var SeqNum = [];
			var check = /^[0-9]+$/;
			
			$("#menuForm input[name='menuSeq']",).each(function(){
				if(!check.test($(this).val())){
					alert("순서는 숫자로만 입력가능합니다.");
					$(this).focus();
				 	isResult = false;
				}
				if(SeqNum.includes($(this).val())){
					alert("순서는 중복될 수 없습니다.");
					$(this).focus();
				 	isResult = false;
				}
				SeqNum.push($(this).val());
			});
			
			if(!isResult){
				return false;
			}
			$("#menuForm").submit();
		}
		
		var subcheckVal = function(){
			var isResult = true;
			$("#submenuForm input[name='menuName']").each(function(){
				var chkIdx = $("#submenuForm form input[name='menuName']").index(this);
				var objMenuSeq = $("#submenuForm input[name='menuSeq']").eq(chkIdx);
				var objMenuLvl = $("#submenuForm input[name='menuLvl']").eq(chkIdx);
				if($(this).val().trim().length <= 0 || objMenuSeq.val().trim().length<=0 || objMenuLvl.val().trim().length<=0){
					isResult = false;
				}
			});
			
			if(!isResult){
				alert("메뉴이름 또는 메뉴순서는 빈값일수 없습니다.");
				return false;
			}
			var SeqNum = [];
			var check = /^[0-9]+$/;
			
			$("#submenuForm input[name='menuSeq']",).each(function(){
				if(!check.test($(this).val())){
					alert("순서는 숫자로만 입력가능합니다.");
					$(this).focus();
				 	isResult = false;
				}
				SeqNum.push($(this).val());
			});
			
			if(!isResult){
				return false;
			}
			
			$("#submenuForm").submit();
		}
		
		var getSubList = function(menuID){
				var smenuName = $("input[name='sSubMenuName']").val();
				$.ajax({
					url : "SubMenuList",
					data : {menuID : menuID, smenuName: smenuName},
					type : "get",
					async : false,
					dataType : "json",	
					success : function(datas){
						var rootID = "<input type='hidden' id='rootID' name='rootID' value='"+ datas[0].rootID +"'/>";
						$("#rootIDbox").html(rootID);
						var strHTML = "";
						$(datas).each(function(){
							var eachLvl = (this.menuLvl-1) * 30;
							
							strHTML += '<tr name="subrow" data-mid="'+this.menuID+'" data-Seq="'+this.menuSeq+'" data-Lvl="'+this.menuLvl+'">';
							strHTML += '<td width="50px" height="30px" align="center">';
							if(this.parentID!="ROOT   ")
							strHTML += '	<input type="checkbox" name="subchk" value="' + this.menuID + '"/>';
							strHTML += '</td>';
						
							strHTML += '<td width="150px" height="30px" align="center">';
							strHTML += '	<input type="text" name="menuID" value="' + this.menuID + '" style="width:100%;height:100%" readonly/>';
							strHTML += '</td>';
							
							strHTML += '<td width="250px" height="30px" align="center">';
							strHTML += '	<input type="text" name="menuName" value="' + this.menuName + '" style="width:100%;height:100%;padding-left:' + eachLvl + 'px;"';
							strHTML += (this.parentID=="ROOT   ")? "readonly/>" : "/>";
							strHTML += '</td>';
							
							strHTML += '<td width="75px" height="30px" align="center">';
							strHTML += '	<input type="text" name="menuSeq" value="' + this.menuSeq + '" style="width:100%;height:100%"';
							strHTML += (this.parentID=="ROOT   ")? "readonly/>" : "/>";
							strHTML += '</td>';
							
							strHTML += '<td width="75px" height="30px" align="center">';
							strHTML += '	<input type="text" name="menuLvl" value="' + this.menuLvl + '" style="width:100%;height:100%"';
							strHTML += (this.parentID=="ROOT   ")? "readonly/>" : "/>";
							strHTML += '</td>';
							
							strHTML += '<td width="150px" height="30px" align="center">';
							if(this.parentID=="ROOT   "){
								strHTML += '	<input type="text" name="parentID" value="ROOT" style="width:100%;height:100%" readonly/>';
							}else{
								strHTML += '	<select name="parentID" style="width:100%;height:100%">';
								
								var menuID = this.menuID;
								var parentID = this.parentID;
								
								$(datas).each(function(){
									if(menuID != this.menuID){
									strHTML += '	<option value="'+ this.menuID +'" style="padding:5px 0px 5px 0px;"';
									strHTML += (parentID == this.menuID)? "selected>" : ">";
									strHTML += 		this.menuID + '</option>';
									}
								});
								
								strHTML += '	</select>';
							}
							strHTML += '</td>';
							
							strHTML += '<td width="0px" height="30px" align="center">';
							strHTML += '	<input type="text" name="hidVal" value="" style="width:100%;height:100%"/>';
							strHTML += '</td>';
							
							strHTML += '</tr>';
						});
					$("#subMenuList").html(strHTML);
					$("#searchMenuID").val(menuID);
					},
					error : function(err){
						alert("err");
					}
				});
		}
	
		$(document).ready(function(){
		<%
			String rootID = request.getParameter("rootID");
			if(rootID != null){
		%>
			getSubList("<%= rootID%>");
		<% } %>
			
			$("input").on("change",function(){
				$(this).css("background-color", "#e3f1f3");
			});
			
			$("#btnSearch").click(function(){
				location.href = "MenuList?smenuName=" + $("#smenuName").val();
			});
			
			//menuName textbox onchange event 시작
			$(document).on("change", "input[name='menuName']", function(){
				var chgIdx = $("input[name='menuName']").index(this);
				$("input[name='hidVal']").eq(chgIdx).val("U");
			});
				
			//menuSeq textbox onchange event 시작
			$(document).on("change", "input[name='menuSeq']", function(){
				var chgIdx = $("input[name='menuSeq']").index(this);
				$("input[name='hidVal']").eq(chgIdx).val("U");
			});
			
			$(document).on("change", "input[name='menuLvl']", function(){
				var chgIdx = $("input[name='menuLvl']").index(this);
				$("input[name='hidVal']").eq(chgIdx).val("U");
			});
			
			$(document).on("change", "select", function(){
				alert("셀렉박스 변경");	
				var chgIdx = $("select[name='parnetID']").index(this);
				$("input[name='hidVal']").eq(chgIdx).val("U");
			});
			
			$("#btnAdd").click(function(){
				var strHTML = "";
						
				strHTML += '<tr>';
				strHTML += '<td width="50px" height="30px" align="center">';
				strHTML += '	<input type="checkbox" name="chk" />';
				strHTML += '</td>';
				strHTML += '<td width="150px" height="30px" align="center">';
				strHTML += '	<input type="text" name="menuID" value="" style="width:150px;height:30px;" readonly/>';
				strHTML += '</td>';
				strHTML += '<td width="250px" height="30px" align="center">';
				strHTML += '	<input type="text" name="menuName" value="" style="width:250px;height:30px;"/>';
				strHTML += '</td>';
				strHTML += '<td width="75px" height="30px" align="center">';
				strHTML += '	<input type="text" name="menuSeq" value="" style="width:75px;height:30px;"/>';
				strHTML += '</td>';
				strHTML += '<td width="0px" height="30px" align="center">';
				strHTML += '	<input type="hidden" name="menuLvl" value="1"/>';
				strHTML += '	<input type="hidden" name="parentID" value="ROOT"/>';
				strHTML += '	<input type="hidden" name="hidVal" value="I"/>';
				strHTML += '</td>';
				strHTML += '</tr>';
						
				$("#menuTbl tbody").append(strHTML);
			});
				
				
			$("#btnSave").click(function(){
				checkVal();
			});
				
				
			$("#allChk").click(function(){
				var isAllChk = $(this).prop("checked");
				if(isAllChk){
					$("input[name='chk']").prop("checked", true);
				}
				else{
					$("input[name='chk']").prop("checked", false);
				}
			});
			
			$("#allSubChk").click(function(){
				var isAllChk = $(this).prop("checked");
				if(isAllChk){
					$("input[name='subchk']").prop("checked", true);
				}
				else{
					$("input[name='subchk']").prop("checked", false);
				}
			});
				
				
			$("#btnDel").click(function(){
				
				var chkValues = [];
				$("input[name='chk']").each(function(){
					var isAllChk = $(this).prop("checked");
					if(isAllChk){
						chkValues.push($(this).val());
					}
				});
				
				if(chkValues.length==0){
					alert("삭제할 데이터를 선택해주세요.");
					return;
				}
				
				var isConfirm = confirm("주메뉴 삭제시 하위메뉴도 함께 삭제됩니다. 삭제하시겠습니까?");
				if(!isConfirm){
					return;
				}
				
					
				var strHTML = "";
				strHTML += "<form id='delForm' action='delMenus' method='post'>";
				for(var i=0;i<chkValues.length;i++){
					strHTML += "<input type='hidden' name='delMenuID' value='" + chkValues[i] + "' />";
				}
				strHTML += "</form>";
						
				$("body").append(strHTML);
				$("#delForm").submit();
			});
				
		
		//row Click Event 시작
		$("tr[name='row']").click(function(){
			$("input[name='sSubMenuName']").val("");
			
			var idx = $("tr[name='row']").index(this);
			var menuID = ($("input[name='menuID']").eq(idx).val());
			getSubList(menuID);
		});
		
		$("#btnSubSearch").click(function(){
			getSubList($("#searchMenuID").val());
		});
		
		$("#btnSubAdd").click(function(){
			var menuID = $("#subMenuList tr").attr("data-mid");
			$.ajax({
				url : "SubMenuList",
				data : {menuID : menuID, smenuName:""},
				type : "get",
				async : false,
				dataType : "json",	
				success : function(datas){
					var strHTML = "";
					var addSubMenu = $("input[name='subchk']:checked").parent().parent();
						strHTML += '<tr name="subrow">';
						strHTML += '<td width="50px" height="30px" align="center">';
						strHTML += '	<input type="checkbox" name="subchk" value=""/>';
						strHTML += '</td>';
					
						strHTML += '<td width="150px" height="30px" align="center">';
						strHTML += '	<input type="text" name="menuID" value="" style="width:100%;height:100%" readonly/>';
						strHTML += '</td>';
							
						strHTML += '<td width="250px" height="30px" align="center">';
						strHTML += '	<input type="text" name="menuName" value="" style="width:100%;height:100%;padding-left:0px;"/>';
						strHTML += '</td>';
							
						strHTML += '<td width="75px" height="30px" align="center">';
						strHTML += '	<input type="text" name="menuSeq" value="" style="width:100%;height:100%"/>';
						strHTML += '</td>';
							
						strHTML += '<td width="75px" height="30px" align="center">';
						strHTML += '	<input type="text" name="menuLvl" value="" style="width:100%;height:100%"/>';
						strHTML += '</td>';
							
						strHTML += '<td width="150px" height="30px" align="center">';
						strHTML += '	<select name="parentID" style="width:100%;height:100%">';
						$(datas).each(function(){
						strHTML += '	<option value="'+ this.menuID +'" style="height:35px;">'+ this.menuID + '</option>';
						});
						strHTML += '	</select>';
						strHTML += '</td>';
							
						strHTML += '<td width="0px" height="30px" align="center">';
						strHTML += '	<input type="text" name="hidVal" value="I" style="width:100%;height:100%"/>';
						strHTML += '</td>';
							
						strHTML += '</tr>';
					
					$("#subMenuList").append(strHTML);
				},
				error : function(err){
					alert("err");
				}
			});
			
		});
		
		$("#btnSubSave").click(function(){
			subcheckVal();
			getSubList($("#rootID").val());
		});
			
	
		$("#btnSubDel").click(function(){
			
			var chkValues = [];
			$("input[name='subchk']").each(function(){
				var isAllChk = $(this).prop("checked");
				if(isAllChk){
					chkValues.push($(this).val());
				}
			});
			
			if(chkValues.length==0){
				alert("삭제할 데이터를 선택해주세요.");
				return;
			}
			
			var isConfirm = confirm("삭제하시겠습니까?");
			if(!isConfirm){
				return;
			}
			
				
			var strHTML = "";
			strHTML += "<form id='delForm' action='delMenus' method='post'>";
			strHTML += "<input type='hidden' name='rootID' value='<%= rootID%>'/>";
			for(var i=0;i<chkValues.length;i++){
				strHTML += "<input type='hidden' name='delMenuID' value='" + chkValues[i] + "' />";
			}
			strHTML += "</form>";
					
			$("body").append(strHTML);
			$("#delForm").submit();
		});
	
	});
	</script>

</head>
 

<%
	List<AuthMenuDTO> menuList = (List<AuthMenuDTO>)request.getAttribute("menuList");
%>

<body>

	<table border="0px" width="1400px" align="center" cellpadding="0" cellspacing="0" >
		<tr>
			<td width="750px" align="center" valign="top">
				<form name="menuForm" id="menuForm" action="SaveMenuList" method="post">
				<table border="1px" width="525px" align="center" cellpadding="0" cellspacing="0" id="menuTbl">
					<tr>
						<td width="525px" colspan="4" height="30px">
							<input type="text" name="smenuName" id="smenuName" placeholder="메뉴명을 입력하세요."/>
							<input type="button" value="조회" id="btnSearch"/>
							<input type="button" value="저장" id="btnSave" />
							<input type="button" value="추가" id="btnAdd" />
							<input type="button" value="삭제" id="btnDel" />
						</td>
					</tr>
					<tr>
						<td width="50px" height="30px" align="center">
							<input type="checkbox" name="allChk" id="allChk" />
						</td>
						<td width="150px" height="30px" align="center">
							메뉴아이디
						</td>
						<td width="250px" height="30px" align="center">
							메뉴명
						</td>
						<td width="75px" height="30px" align="center">
							순서
						</td>
						<td width="0px" height="30px" align="center">
							
						</td>
					</tr>
					
					<% 
						for(AuthMenuDTO dto : menuList){
					%>
					<tr name="row">
						<td width="50px" height="30px" align="center">
							<input type="checkbox" name="chk" value="<%=dto.getMenuID() %>"/>
						</td>
						<td width="150px" height="30px" align="center" >
							<input type="text" name="menuID" value="<%=dto.getMenuID() %>" style="width:150px;height:30px;" readonly/>
						</td>
						<td width="250px" height="30px" align="center">
							<input type="text" name="menuName" value="<%=dto.getMenuName() %>" style="width:250px;height:30px;"/>
						</td>
						<td width="75px" height="30px" align="center">
							<input type="text" name="menuSeq" value="<%=dto.getMenuSeq() %>" style="width:75px;height:30px;"/>
						</td>
						<td width="0px" height="30px" align="center">
							<input type="hidden" name="menuLvl" value="1"/>
							<input type="hidden" name="parentID" value="ROOT"/>
							<input type="hidden" name="hidVal" />
						</td>
					</tr>
					<%
						}
					%>
					
					
				</table> 
				</form>
			</td>
			<td width="750px" align="center" valign="top">
				<form name="submenuForm" id="submenuForm" action="SaveSubMenuList" method="post">
				<table border="1px" width="750px" align="center" cellpadding="0" cellspacing="0" id="subMenuTbl">
				<div id="rootIDbox">
				</div>
					<tr>
						<td width="750px" colspan="7" height="30px">
							<input type="hidden" value="" id="searchMenuID"/>
							<input type="text" name="sSubMenuName" id="sSubMenuName" placeholder="메뉴명을 입력하세요." />
							<input type="button" value="조회" id="btnSubSearch"/>
							<input type="button" value="저장" id="btnSubSave" />
							<input type="button" value="추가" id="btnSubAdd" />
							<input type="button" value="삭제" id="btnSubDel" />
						</td>
					</tr>
					<tr>
						<td width="50px" height="30px" align="center">
							<input type="checkbox" name="allChk" id="allSubChk" />
						</td>
						<td width="150px" height="30px" align="center">
							메뉴아이디
						</td>
						<td width="250px" height="30px" align="center">
							메뉴명
						</td>
						<td width="75px" height="30px" align="center">
							순서
						</td>
						<td width="75px" height="30px" align="center">
							레벨
						</td>
						<td width="150px" height="30px" align="center">
							부모아이디
						</td>
						<td width="0px" height="30px" align="center">
							
						</td>
					</tr>
					<tbody id="subMenuList">
					</tbody>
				</table>
				
				</form>
			</td>
		</tr>
	</table>

</body>
</html>