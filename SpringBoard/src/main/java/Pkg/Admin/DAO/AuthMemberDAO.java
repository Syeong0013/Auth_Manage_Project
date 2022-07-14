package Pkg.Admin.DAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import Pkg.Admin.VO.AuthMemberDTO;

public interface AuthMemberDAO {
	public List<AuthMemberDTO> getAuthMemberList(String searchMname);
	
	public void saveMemberList(Map<String, String[]> map);
	
	public void delMember(String[] mid);
}
