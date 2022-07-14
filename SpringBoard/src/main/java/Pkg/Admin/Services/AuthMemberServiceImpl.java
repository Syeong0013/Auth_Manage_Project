package Pkg.Admin.Services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Pkg.Admin.DAO.AuthMemberDAO;
import Pkg.Admin.VO.AuthMemberDTO;

@Service
public class AuthMemberServiceImpl implements AuthMemberService{

	@Autowired
	private AuthMemberDAO authMemberDAO;
	
	@Override
	public List<AuthMemberDTO> getAuthMemberList(String searchMname) {
		return authMemberDAO.getAuthMemberList(searchMname);
	}
	
	@Override
	public void saveMemberList(Map<String, String[]> map) {
		authMemberDAO.saveMemberList(map);
	}
	
	@Override
	public void delMember(String[] mid) {
		authMemberDAO.delMember(mid);
	}
}
