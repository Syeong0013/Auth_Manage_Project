package Pkg.Admin.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import Pkg.Admin.Services.AuthMenuService;
import Pkg.Admin.VO.AuthMenuDTO;

@Controller
public class AuthMenuController {

	@Autowired
	private AuthMenuService authMenuService;
	
	@RequestMapping("MenuList")
	public String getMenuList(String smenuName, Model m) {
		List<AuthMenuDTO> menuList = authMenuService.getMenuList(smenuName);
		
		m.addAttribute("menuList", menuList);
		return "/Admin/AuthList/menuList";
	}
	
	@ResponseBody
	@RequestMapping("SubMenuList")
	public String getSubMenuList(String smenuName, String menuID) {
		System.out.println("menuID = " + menuID);
		List<AuthMenuDTO> submenuList = authMenuService.getSubMenuList(smenuName, menuID);
		
		JSONArray arrSubMenuList = new JSONArray();
		for(AuthMenuDTO dto: submenuList) {
			JSONObject obj = new JSONObject();
			obj.put("menuID", dto.getMenuID());
			obj.put("menuName", dto.getMenuName());
			obj.put("menuSeq", dto.getMenuSeq());
			obj.put("menuLvl", dto.getMenuLvl());
			obj.put("parentID", dto.getParentID());
			
			arrSubMenuList.add(obj);
		}
		return arrSubMenuList.toString();
	}
	
	@RequestMapping("SaveMenuList")
	public String saveMenuList(String[] menuID, String[] menuName, String[] menuSeq, String[] menuLvl, String[] parentID, String[] hidVal) {
	
		Map<String, String[]> params = new HashMap<String, String[]>();
		params.put("menuID", menuID);
		params.put("menuName", menuName);
		params.put("menuSeq", menuSeq);
		params.put("menuLvl", menuLvl);
		params.put("parentID", parentID);
		params.put("hidVal", hidVal);
		
		authMenuService.saveMenuList(params);
		return "redirect:MenuList";
	}
	
	@RequestMapping("delMenus")
	public String removeMenu(String[] delMenuID) {
		authMenuService.removeMenu(delMenuID);
		return "redirect:MenuList";
	}
}
