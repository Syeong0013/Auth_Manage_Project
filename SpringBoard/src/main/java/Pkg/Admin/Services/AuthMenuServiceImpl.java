package Pkg.Admin.Services;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Pkg.Admin.DAO.AuthMenuDAO;
import Pkg.Admin.VO.AuthMenuDTO;

@Service
public class AuthMenuServiceImpl implements AuthMenuService{
	@Autowired
	private AuthMenuDAO authMenuDAO;
	
	@Override
	public List<AuthMenuDTO> getMenuList(String menuName){
		return authMenuDAO.getMenuList(menuName);
	}
	
	@Override
	public List<AuthMenuDTO> getSubMenuList(String menuName, String menuID){
		return authMenuDAO.getSubMenuList(menuName, menuID);
	}
	
	@Override
	public void saveMenuList(Map<String, String[]> params) {
		authMenuDAO.saveMenuList(params);
	}
	
	@Override
	public void removeMenu(String[] delMenus) {
		authMenuDAO.removeMenu(delMenus);
	}
}
