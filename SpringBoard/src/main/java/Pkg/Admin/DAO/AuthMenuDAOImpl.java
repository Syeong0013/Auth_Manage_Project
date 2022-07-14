package Pkg.Admin.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Pkg.Admin.VO.AuthMenuDTO;

@Repository
public class AuthMenuDAOImpl implements AuthMenuDAO{

	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<AuthMenuDTO> getMenuList(String menuName){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("menuName", menuName);
		
		sqlsession.selectList("selectTopMenuList", params);
		List<AuthMenuDTO> menuList = (List<AuthMenuDTO>)params.get("result");
		
		return menuList;
	}
	
	@Override
	public List<AuthMenuDTO> getSubMenuList(String menuName, String menuID){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuName", menuName);
		map.put("menuId", menuID);
		
		sqlsession.selectList("selectMenuList", map);
		List<AuthMenuDTO> submenuList = (List<AuthMenuDTO>)map.get("result");
		return submenuList;
	}
	
	@Override
	public void saveMenuList(Map<String, String[]> params) {
		String[] hidVals = params.get("hidVal");
		String[] menuID = params.get("menuID");
		String[] menuName = params.get("menuName");
		String[] menuSeq = params.get("menuSeq");
		String[] menuLvl = params.get("menuLvl");
		String[] parentID = params.get("parentID");
		
		for(int i=0; i<hidVals.length; i++) {
			if(!hidVals[i].equals("")) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("menuID", menuID[i]);
				map.put("menuName", menuName[i]);
				map.put("menuSeq", menuSeq[i]);
				map.put("menuLvl", menuLvl[i]);
				map.put("parentID", parentID[i]);
				
				sqlsession.update("saveMenuList", map);
			}
		}
	}
	
	@Override
	public void removeMenu(String[] delMenus) {
		for(String del : delMenus) {
			sqlsession.delete("deleteMenu", del);
		}
	}
}
