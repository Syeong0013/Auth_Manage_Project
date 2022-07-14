package Pkg.Admin.DAO;

import java.util.List;

import Pkg.Admin.VO.ProgramDTO;

public interface ProgramDAO {
	public List<ProgramDTO> getProgramList(String pName);
}
