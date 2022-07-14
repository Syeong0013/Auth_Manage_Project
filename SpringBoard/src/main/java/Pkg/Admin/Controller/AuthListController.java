package Pkg.Admin.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import Pkg.Admin.Services.AuthListService;
import Pkg.Admin.VO.AuthDTO;

@Controller
public class AuthListController {
	
	@Autowired
	private AuthListService authService;
	
	@RequestMapping("AuthList")
	public String getAuthList(String authName, Model model) {
		
		List<AuthDTO> authList = null;
		
		if(authName == null) {
			authList = authService.getAuthList("");
		}else {
			authList = authService.getAuthList(authName);
		}
		model.addAttribute("authList",authList);
		model.addAttribute("authName", authName);
		
		return "/Admin/AuthList/AuthList";
	}

	@RequestMapping("SaveAuthList")
	public String saveAuthList(String[] authID, String[] authName, String[] gbn) {
		Map<String, String[]> paramsMap = new HashMap<>();
		paramsMap.put("authID", authID);
		paramsMap.put("authName", authName);
		paramsMap.put("gbn", gbn);

		Map<String, ArrayList<String>> errMap = authService.saveAuthList(paramsMap);
	
		// error 처리 
		
		return "redirect:AuthList?authName=";
	}
	
	@RequestMapping("DelAuthList")
	public String delAuthList(String[] authID) {
		authService.delAuthList(authID);
		return "redirect:AuthList?authName=";
	}
}
