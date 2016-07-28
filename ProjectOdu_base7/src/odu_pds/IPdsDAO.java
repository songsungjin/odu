package odu_pds;

import java.util.List;

public interface IPdsDAO {
	
	List<PdsDTO> getPDSList();
	boolean writePDS(PdsDTO pds);
	boolean downloadCount(int pdsid);
	boolean uploadPDS(PdsDTO pds);
	PdsDTO detailPDS(int seq);
}
