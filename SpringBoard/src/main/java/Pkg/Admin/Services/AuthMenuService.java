package Pkg.Admin.Services;

import java.util.List;
import java.util.Map;

import Pkg.Admin.VO.AuthMenuDTO;

public interface AuthMenuService {
	public List<AuthMenuDTO> getMenuList(String menuName);
	public List<AuthMenuDTO> getSubMenuList(String menuName, String menuID);
	public void saveMenuList(Map<String, String[]> params);
	public void removeMenu(String[] delMenus);
}
