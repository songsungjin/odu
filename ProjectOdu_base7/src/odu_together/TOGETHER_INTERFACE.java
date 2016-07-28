package odu_together;

import java.util.List;

public interface TOGETHER_INTERFACE {
	
	boolean writeTogether(togetherDTO dto);
	List<togetherDTO> getTogether();
	togetherDTO getToDTO(int seq);
}
