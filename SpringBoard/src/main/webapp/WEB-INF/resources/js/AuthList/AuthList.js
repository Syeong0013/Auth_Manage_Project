$(document).ready(function(){
		$("#btnSearch").on("click", function(){
			location.href="AuthList?authName=" + $("#authName").val();
		});
				
		$("#btnAdd").click(function(){
			var strHTML = "";
						
			strHTML += "<tr>";
			strHTML += '<td width="100px" height="30px" align="center">';
			strHTML += '<input type="checkbox" name="chk"  value="" />';
			strHTML += '</td>';
			strHTML += '<td width="200px" height="30px" align="center">';
			strHTML += 'NEW AUTHID';
			strHTML += '</td>';
			strHTML += '<td width="400px" height="30px" align="center">';
			strHTML += '<input type="text" name="authName" style="width:98%;height:98%"/>';
			strHTML += '</td>';
			strHTML += "</tr>";
			//alert(strHTML);
			$("#authTbl tbody").append(strHTML);
		});
});