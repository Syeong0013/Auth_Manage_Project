package Pkg.Admin.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuthManageController {
	
	@RequestMapping("AuthManager")
	public String goAuthManager() {
		return "/Admin/Auth_Manager";
	}
	
}
