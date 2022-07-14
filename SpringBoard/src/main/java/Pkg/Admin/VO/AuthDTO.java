package Pkg.Admin.VO;

public class AuthDTO {
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
	public String getGbn() {
		return gbn;
	}
	public void setGbn(String gbn) {
		this.gbn = gbn;
	}
	
	private String authID;
	private String authName;
	private String gbn;
}
