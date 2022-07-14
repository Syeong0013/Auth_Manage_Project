package Pkg.Admin.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Pkg.Admin.VO.AuthDTO;

@Repository
public class AuthListDAOImpl implements AuthListDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AuthDTO> getAuthList(String authName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authName", authName);
		
		sqlSession.selectList("selectAuthList", map);
		
		List<AuthDTO> authList = (List<AuthDTO>)map.get("result");
		
		return authList;
	}

	@Override
	public Map<String, ArrayList<String>> saveAuthList(Map<String, String[]> params) {
		String[] authID = params.get("authID");
		String[] authName = params.get("authName");
		String[] gbn = params.get("gbn");
		
		// 에러처리용 
		Map<String, ArrayList<String>> errMap = new HashMap<String, ArrayList<String>>();
		
		ArrayList<String> errCode = new ArrayList<String>();
		ArrayList<String> errMsg = new ArrayList<String>();
		
		for(int i=0; i<authName.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("authID", authID[i]);
			map.put("authName", authName[i]);
			map.put("gbn", gbn[i]);
			
			if(gbn[i] != null) {
				sqlSession.selectList("saveAuthList", map);
			}
			errCode.add((String)map.get("errCode"));
			errMsg.add((String)map.get("errMsg"));
		}
		
		errMap.put("errCode", errCode);
		errMap.put("errMsg", errMsg);
		
		return errMap;
	}

	@Override
	public Map<String, ArrayList<String>> delAuthList(String[] authID){
		
		// 에러처리용 
		Map<String, ArrayList<String>> errMap = new HashMap<String, ArrayList<String>>();
		
		ArrayList<String> errCode = new ArrayList<String>();
		ArrayList<String> errMsg = new ArrayList<String>();
		
		for(int i=0; i<authID.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("authID", authID[i]);
			
			
			sqlSession.selectList("delAuthList", map);
			
			errCode.add((String)map.get("errCode"));
			errMsg.add((String)map.get("errMsg"));
		}
		
		errMap.put("errCode", errCode);
		errMap.put("errMsg", errMsg);
		
		return errMap;
	}
	
}
