package odu_poll;

import java.io.Serializable;
import java.util.Date;

/*

CREATE TABLE SIST_VOTER(
	VOTERID NUMBER NOT NULL,
	POLLID NUMBER,
	POLLSUBID NUMBER NOT NULL,
	ID VARCHAR2(50) NOT NULL,
	REGIDATE DATE NOT NULL,
	CONSTRAINT SIST_VOTER_PK PRIMARY KEY("VOTERID")
);

CREATE SEQUENCE SIST_VOTER_SEQ
START WITH 1 INCREMENT BY 1;

ALTER TABLE SIST_VOTER ADD CONSTRAINT SIST_VOTER_FK
FOREIGN KEY("POLLID")
REFERENCES SIST_POLL("POLLID");


ALTER TABLE SIST_VOTER ADD CONSTRAINT SIST_VOTER_FK2
FOREIGN KEY("POLLSUBID")
REFERENCES SIST_POLLSUB("POLLSUBID");


ALTER TABLE SIST_VOTER ADD CONSTRAINT SIST_VOTER_FK3
FOREIGN KEY("ID")
REFERENCES MemberDTO("ID");

*/
// 응답자: 누가 투표했는지 어느 문제에 투표했는지
public class VoterDTO implements Serializable {
	
	private int voterid;		// 답한 사람을 카운트
	private int pollid;			// 질문 번호
	private int pollsubid;		// 보기 나온 순서의 번호
	private String id;			// 답한 사람의 ID
	private Date regidate;		// 답한 날짜와 시간
	
	public VoterDTO() {}
	
	public VoterDTO(int voterid, int pollid, int pollsubid, String id, Date regidate) {
		this.voterid = voterid;
		this.pollid = pollid;
		this.pollsubid = pollsubid;
		this.id = id;
		this.regidate = regidate;
	}
	
	public VoterDTO(int pollid, int pollsubid, String id) {
		this.pollid = pollid;
		this.pollsubid = pollsubid;
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "VoterDTO [voterid=" + voterid + ", pollid=" + pollid + ", pollsubid=" + pollsubid + ", id=" + id
				+ ", regidate=" + regidate + "]";
	}

	public int getVoterid() {
		return voterid;
	}

	public void setVoterid(int voterid) {
		this.voterid = voterid;
	}

	public int getPollid() {
		return pollid;
	}

	public void setPollid(int pollid) {
		this.pollid = pollid;
	}

	public int getPollsubid() {
		return pollsubid;
	}

	public void setPollsubid(int pollsubid) {
		this.pollsubid = pollsubid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getRegidate() {
		return regidate;
	}

	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}
	
}
