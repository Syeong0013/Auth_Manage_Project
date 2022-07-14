package Pkg.Admin.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Pkg.Admin.VO.AuthMemberDTO;

@Repository
public class AuthMemberDAOImpl implements AuthMemberDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<AuthMemberDTO> getAuthMemberList(String searchMname) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchMName", searchMname);
		
		sqlSession.selectList("selectAuthMember", map);
		
		List<AuthMemberDTO> authMemberList = (List<AuthMemberDTO>) map.get("result");
		
		return authMemberList;
	}

	@Override
	public void saveMemberList(Map<String, String[]> map) {
		String[] mID = map.get("mID");
		String[] mName = map.get("mName");
		String[] authID = map.get("authID");
		String[] gbn = map.get("gbn");
		String[] mthID = map.get("mthID");
		
		for(int i=0; i<mName.length; i++) {
			Map<String, Object> maps = new HashMap<String, Object>();
			
			maps.put("mID", mID[i]);
			maps.put("mName", mName[i]);
			maps.put("authID", authID[i]);
			maps.put("gbn", gbn[i]);
			maps.put("mthID", mthID[i]);
			
			if(gbn[i] != null) {
				sqlSession.selectList("saveAuthMember", maps);
			}
		}
	}
	
	@Override
	public void delMember(String[] mid) {
		for(String mID : mid) {
			sqlSession.delete("delAuthMember", mID);
		}
	}
}
