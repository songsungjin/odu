package odu_bbs;

import java.util.List;

import odu_bbs.bbsDTO;
import odu_bbs.bbsRepleDTO;

public interface ibbsDAO {

	
	List<bbsDTO> getbbslist(); 
	boolean writeBBS(bbsDTO tbbs);
	void readCount(int seq);
	bbsDTO getBBS(int seq);
	boolean repleInsert(int bbsnum, int seq, String id, String reple);
	List<bbsRepleDTO> getreplelist(int bbsnum, int seq);
	
}
