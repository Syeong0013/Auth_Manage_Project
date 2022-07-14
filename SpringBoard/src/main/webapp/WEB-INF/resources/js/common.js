
	var ajaxObj = function(url, type, vars, params, async, dataType, sucFunc, errFunc){
		this.url = url;
		this.type = type;
		this.data = null;
		this.vars = vars;
		this.params = params;
		this.async = async;
		this.dataType = dataType;
		this.sucFunc = sucFunc;
		this.errFunc = errFunc;
		
		this.toJson = function(){
			
			var strJson = "";
			strJson += "{";
				for(var i=0;i<vars.length;i++){
					strJson += "\"" +  this.vars[i] + "\"";
					strJson += ":";
					strJson += "\"" + this.params[i] + "\"";
					if(i != vars.length - 1){
						strJson += ",";
					}
				}
			strJson += "}";
			
			this.data = JSON.parse(strJson);
		};
		
		this.ajaxExec = function(){
			$.ajax(
					{
						url : this.url,
						data : this.data,//{sid: "", sname:""}
						type : this.type,
						async : this.async,
						dataType : this.dataType,
						
						success : this.sucFunc
						,
						error : this.errFunc
						
					} 
				); 
		};
		
	};
	

	var objectSubmit = function(formID, formAction, formMethod, hiddenNames, hiddenVals){
		this.formID = formID;
		this.formAction = formAction;
		this.formMethod = formMethod;
		this.hiddenNames = hiddenNames;
		this.hiddenVals = hiddenVals;
		
		this.linkSubmit = function(){
			var strHTML = "<form action='" + this.formAction + "' method='" + this.formMethod + "' id='" + this.formID + "'>";
			for(var i=0;i<this.hiddenNames.length;i++){
				strHTML += "<div>";
				strHTML += "<input type='hidden' name='" + this.hiddenNames[i] + "' value='" + this.hiddenVals[i] + "' />";
				strHTML += "</div>";
			}
			strHTML += "</form>";
			
			$("body").append(strHTML);
			$("#" + this.formID).submit();
		};
		
		this.formSubmit = function(){
			var strHiddenHTML = "";
			for(var i=0;i<this.hiddenNames.length;i++){
				strHiddenHTML += "<div>";
				strHiddenHTML += "<input type='hidden' name='" + this.hiddenNames[i] + "' value='" + this.hiddenVals[i] + "' />";
				strHiddenHTML += "</div>";
			}
			$("#" + this.formID).attr("method", this.formMethod);
			$("#" + this.formID).attr("action", this.formAction);
			$("#" + this.formID).append(strHiddenHTML);
			$("#" + this.formID).submit();
		}
	};
	
	
	