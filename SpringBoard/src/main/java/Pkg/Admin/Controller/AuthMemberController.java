package Pkg.Admin.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.ServletRequestAttributes;

import Pkg.Admin.Services.AuthListService;
import Pkg.Admin.Services.AuthMemberService;
import Pkg.Admin.VO.AuthDTO;
import Pkg.Admin.VO.AuthMemberDTO;
@Controller
public class AuthMemberController {
	@Autowired
	private AuthMemberService authMemberService;
	
	@Autowired
	private AuthListService authListService;
	
	@Autowired
	HttpServletResponse res;
	
	@RequestMapping("MemberList")
	public String goMemberList() {
		return "/Admin/AuthList/MemberList";
	}
	
	@ResponseBody
	@RequestMapping("JsonMemberList")
	public void MemberList(String searchMName) {
		
		List<AuthDTO> authList = authListService.getAuthList("");
		List<AuthMemberDTO> memberList = authMemberService.getAuthMemberList(searchMName);
		
		JSONArray jarray = new JSONArray();
		
		// 멤버리스트 받아와서 JSON객체에 저장 220602 by.김시영
		for(AuthMemberDTO dto : memberList) {
			JSONObject jobj = new JSONObject();
			jobj.put("MID", dto.getmID());
			jobj.put("MNAME", dto.getmName());
			jobj.put("AUTHID", dto.getAuthID());
			jobj.put("AUTHNAME", dto.getAuthName());
			jobj.put("MTHID", dto.getMthID());
			jarray.add(jobj);
		}
		
		// 권한리스트 받아와서 JSON객체에 저장 220602
		JSONArray jarray2 = new JSONArray();
		JSONObject empty = new JSONObject();
		empty.put("AUTHID", "N");
		empty.put("AUTHNAME", "선택해주세요. (필수)");

		jarray2.add(empty);
		
		for(AuthDTO dto : authList) {
			JSONObject jobj = new JSONObject();
			jobj.put("AUTHID", dto.getAuthID());
			jobj.put("AUTHNAME", dto.getAuthName());
			
			jarray2.add(jobj);
		}
		
		JSONObject jarray3 = new JSONObject();
		jarray3.put("memberList", jarray);
		jarray3.put("authList", jarray2);
		
		//HttpServletResponse res = ((ServletRequestAttributes)requestAttributes).getResponse();
		try {
			(res.getWriter()).print(jarray3);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping("JsonAuthList")
	public String JsonAuthList(String authName) {
		List<AuthDTO> authList = authListService.getAuthList("");
		
		JSONArray jarray2 = new JSONArray();
		JSONObject empty = new JSONObject();
		empty.put("AUTHID", "N");
		empty.put("AUTHNAME", "선택해주세요.");

		jarray2.add(empty);
		for(AuthDTO dto : authList) {
			JSONObject jobj = new JSONObject();
			jobj.put("AUTHID", dto.getAuthID());
			jobj.put("AUTHNAME", dto.getAuthName());
			
			jarray2.add(jobj);
		} 
		return jarray2.toString();
	}
	
	
	@RequestMapping("MemberSave")
	public String MemberSave(String[] mID, String[] mName, String[] authID, String[] gbn, String[] mthID) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("mID", mID);
		map.put("mName", mName);
		map.put("authID", authID);
		map.put("gbn", gbn);
		map.put("mthID", mthID);
		
		authMemberService.saveMemberList(map);
		
		return "/Admin/AuthList/MemberList";
	}
	
	@ResponseBody
	@RequestMapping("DelMemberList")
	public String JsonDelMemberList(String[] mid) {
		authMemberService.delMember(mid);
		return "suc";
	}
}
