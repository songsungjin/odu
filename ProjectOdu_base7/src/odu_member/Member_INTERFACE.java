package odu_member;

import java.util.List;

public interface Member_INTERFACE {
	// member 관련
		boolean insertMember(MemberDTO dto);
		MemberDTO login(MemberDTO dto);
		
}
