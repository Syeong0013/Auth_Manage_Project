package Pkg.Admin.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@GetMapping("login")
	public String Login() {
		return "../index";
	}
	
	@PostMapping("login")
	public String Login(String id, String pw) {
		if(id.equals("admin") && pw.equals("123")) {
			return "redirect:AuthManager";	
		}
		 return "redirect:/";
	}
}
