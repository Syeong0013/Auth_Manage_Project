<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트 [ajax로 구현]</title>
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
			width:170px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col3{
			border:1px solid #444;
			width:170px;
			padding:4px 0px 4px 0px;
			display:block;
			text-align:center;
			float:left;
		}
		
		.col4{
			border:1px solid #444;
			width:290px;
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
	<script src="jscss/js/common.js?after"></script>
	<script>
	var selectMemberList = function(){
			var url = "JsonMemberList";
			var type= "post";
			var vars = ["searchMName"];
			var params = [$("#search").val()];
			var async = false;
			var dataType = "json";
			var sucFunc = function(data){
				var strHTML = "";

				$(data).each(function(){
					var members = this.memberList;
					var authes = this.authList;
					
					$(members).each(function(){
						strHTML += '<div class="row">';
						strHTML += '	<span class="col1"><input type="checkbox" name="chk" value="'+ this.MID +'"/></span>';
						strHTML += '	<span><input type="text" name="mID" value="'+ this.MID +'" class="col2" readonly/></span>';
						strHTML += '	<span><input type="text" name="mName" value="'+ this.MNAME +'" class="col3"/></span>';
						strHTML += '	<span>';
						strHTML += '		<select name="authID" class="col4">';
						var strAUTHID = this.AUTHID;
						
					$(authes).each(function(){
						strHTML += '			<option value="'+ this.AUTHID +'"';
						if(strAUTHID==(this.AUTHID)){
							strHTML += 'selected';
						}
						strHTML += '>'+ this.AUTHNAME +'</option>';
					});
					
						strHTML += '		</select>';
						strHTML += '	</span>';
						strHTML += '	<span><input type="hidden" name="gbn" value="" class="col5"/></span>';
						strHTML += '	<span><input type="hidden" name="mthID" value="' + this.MTHID + '" class=""/></span>';
						strHTML += '</div>';
					});
				});
				$("#showList").html(strHTML);
			}
			var errFunc = function(){
				alert("err");
			}
			var obj = new ajaxObj(url, type, vars, params, async, dataType, sucFunc, errFunc);
			obj.toJson();
			obj.ajaxExec();
	}
	
	
	
	//페이지로딩
	$(function(){		
		selectMemberList();
		
		//조회버튼
		$("#btnSearch").click(function(){
			selectMemberList();
		});
		
		//추가버튼
		$("#btnAdd").click(function(){
			var url = "JsonAuthList";
			var type= "post";
			var vars = ["AuthName"];
			var params = [""];
			var async = false;
			var dataType = "json";
			var sucFunc = function(data){
				var strHTML = "";
				strHTML += '	<div class="row">';
				strHTML += '	<span class="col1"><input type="checkbox" name="chk" value=""/></span>';
				strHTML += '	<span><input type="text" name="mID" value="NEWID" class="col2" readonly/></span>';
				strHTML += '	<span><input type="text" name="mName" value="" class="col3"/></span>';
				strHTML += '	<span>';
				strHTML += '		<select name="authID" class="col4">';
				$(data).each(function(){
					strHTML += '		<option value="'+ this.AUTHID +'">'+ this.AUTHNAME +'</option>';
				});
				strHTML += '		</select>';
				strHTML += '	</span>';
				strHTML += '	<input type="hidden" name="gbn" value="I" class="col5"/>';
				strHTML += '	<input type="hidden" name="mthID" value="NEWID" class=""/>';
				strHTML += '</div>';
				
				$("#showList").append(strHTML);
			};
			
			var errFunc = function(){
				alert("err");
			};
			
			var obj = new ajaxObj(url, type, vars, params, async, dataType, sucFunc, errFunc);
			obj.toJson();
			obj.ajaxExec();
		});
		
		
		//저장버튼 
		$("#btnSave").click(function(){
			var isRight = true;
		
			var cnt = 0;
			$("input[name=gbn]").each(function(){
				if($(this).val()!=""){
					cnt++;
				}
			});

			if(cnt==0){
				alert("저장할 데이터가 존재하지 않습니다.");
				return false;
			}
			
			$("input[name='mName']").each(function(){
				if($(this).val().length <= 2){
					isRight = false;
				}
			});
			
			if(!isRight){
				alert("회원명을 2글자 이상 입력하세요.");
				return;
			}
			
			$("select[name='authID']").each(function(){
				if($(this).val()=="N"){
					isRight = false;
				}
			});
			
			if(!isRight){
				alert("권한은 필수 선택입니다.");
				return;
			}
			
			$("#memberForm").submit();
			
		});
		
		//삭제버튼
		$("#btnDel").click(function(){
			if($("input[name='chk']:checked").length==0){
				alert("삭제할 데이터가 존재하지 않습니다.");
				return false;
			}
			
			var mid = [];
			$("input[name='chk']:checked").each(function(index){
				mid.push($(this).val());
			});
			$.ajax({
				url : "DelMemberList",
				type: "post",
				async : false,
				traditional : true,
				data : {
					"mid" : mid
				},
				dataType : "text",
				success : function(data){
					selectMemberList();
				},
				error : function(){
					alert("err");
				}
			});			
		});
		
		// MemberNAME onchange 메소드
		$("input[name='mName']").change(function(){
			var indexNum = $("input[name='mName']").index(this);
			$("input[name='gbn']").eq(indexNum).val("U");
		});
		
		// Select Box onchange 메소드
		$("select[name='authID']").change(function(){
			var indexNum = $("select[name='authID']").index(this);
			$("input[name='gbn']").eq(indexNum).val("U");

			if($("input[name='mthID']").eq(indexNum).val()=="null"){
				$("input[name='mthID']").eq(indexNum).val("NEWID");
			}
		});
		

		//chkAll
		$("input[name='chkAll']").click(function(){
			var isChk = this.checked;
			$("input[name='chk']").prop("checked", isChk);
		});
		
		
		//checkBox
		$("input[name='chk']").click(function(){
			var chkAllList = $("input[name='chk']").length;
			var chkList = $("input[name='chk']:checked").length;
			
			if(chkAllList == chkList){
				$("input[name='chkAll']").prop("checked",true);
			}else{
				$("input[name='chkAll']").prop("checked",false);
			}
		
		});
	});
	
	</script>
</head>
<body>
	<div id="wrap">
		<div class="search">
			<input type="text" id="search" name="searchMName" placeholder="회원명을 입력하시오."/>
			<input type="button" value="조회" id="btnSearch"/>
			<input type="button" value="추가" id="btnAdd"/>
			<input type="button" value="저장" id="btnSave"/>
			<input type="button" value="삭제" id="btnDel"/>
		</div>
		<div class="title">
			<span class="col1"><input type="checkbox" name="chkAll" value=""/></span>
			<span class="col2">회원아이디</span>
			<span class="col3">회원이름</span>
			<span class="col4">회원권한</span>
		</div>
		
		<!-- 회원 반복 구간 시작 -->
		<form action="MemberSave" name="memberForm" method="post" id="memberForm">
			<div id="showList"></div>
			<div class="row">
			</div>
		</form>
		<!-- 회원 반복 구간 끝 -->
	</div>
	
</body>
</html>