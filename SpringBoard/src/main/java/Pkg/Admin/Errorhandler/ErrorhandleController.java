package Pkg.Admin.Errorhandler;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorhandleController {
	
	@RequestMapping("errorHandle")
	public String goErrorPage(String errorCode, String errorMsg, Model model) {
		
		if(errorCode.equals("404")) {
			// 보통 이미지로 처리
			errorMsg = "요청하신 페이지는 없는 페이지입니다.";
		}
		if(errorCode.equals("500")) {
			errorMsg = "Server Error";
		}
		
		model.addAttribute("errorCode", errorCode);
		model.addAttribute("errorMsg", errorMsg);
		
		return "/Admin/AdminError/err";
		
		// 일반화 >> ErrorHandler
	}
}
