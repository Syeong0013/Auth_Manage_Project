package Pkg.Admin.VO;

public class AuthMemberDTO {

	private String mID;
	private String mName;
	private String authID;
	private String authName;
	private String mthID;
	
	
	public String getMthID() {
		return mthID;
	}
	public void setMthID(String mthID) {
		this.mthID = mthID;
	}
	public String getAuthID() {
		return authID;
	}
	public void setAuthID(String authID) {
		this.authID = authID;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}	
	public String getmID() {
		return mID;
	}
	public void setmID(String mID) {
		this.mID = mID;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
}
