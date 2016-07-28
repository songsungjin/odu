package odu_poll;

import java.util.List;

public interface IPollDAO {
	
	List<pollDTO> getPollAllList();
	boolean isVote(VoterDTO dto);
	boolean makePoll(PollBean dto);
	
	pollDTO getPoll(int pollid);
	List<pollSubDTO> getPollSubList(int pollid);
	
	boolean polling(VoterDTO dto);
}
