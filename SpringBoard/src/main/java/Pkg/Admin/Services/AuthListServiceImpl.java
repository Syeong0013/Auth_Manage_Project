package Pkg.Admin.Services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Pkg.Admin.DAO.AuthListDAO;
import Pkg.Admin.VO.AuthDTO;

@Service
public class AuthListServiceImpl implements AuthListService{

	@Autowired
	private AuthListDAO authDAO;
	
	@Override
	public List<AuthDTO> getAuthList(String authName) {
		return authDAO.getAuthList(authName);
	}

	@Override
	public Map<String, ArrayList<String>> saveAuthList(Map<String, String[]> params) {
		return authDAO.saveAuthList(params);
	}
	
	@Override
	public Map<String, ArrayList<String>> delAuthList(String[] authID){
		return authDAO.delAuthList(authID);
	}

}
