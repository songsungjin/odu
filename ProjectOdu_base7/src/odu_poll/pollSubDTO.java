package odu_poll;

import java.io.Serializable;
/*

CREATE TABLE SIST_POLLSUB(
	POLLSUBID NUMBER NOT NULL,
	POLLID NUMBER NOT NULL,
	ANSWER VARCHAR2(1000) NOT NULL,
	ACOUNT NUMBER NOT NULL,
	CONSTRAINT SIST_POLLSUB_PK PRIMARY KEY("POLLSUBID")
);

CREATE SEQUENCE SIST_POLLSUB_SEQ
START WITH 1 INCREMENT BY 1;

ALTER TABLE SIST_POLLSUB ADD CONSTRAINT SIST_POLLSUB_FK
FOREIGN KEY("POLLID")
REFERENCES SIST_POLL("POLLID");
*/

// 문항수(보기) ex) 1.사과  2.배..
public class pollSubDTO implements Serializable {
	
	private int pollsubid;		// 보기 나온 순서에 대한 번호
	private int pollid;			// 질문 번호
	private String answer;		// 보기: 1, 2, a, b
	private int acount;			// 보기를 선택한 사람수
	
	public pollSubDTO() {}
	
	public pollSubDTO(int pollsubid, int pollid, String answer, int acount) {
		this.pollsubid = pollsubid;
		this.pollid = pollid;
		this.answer = answer;
		this.acount = acount;
	}

	@Override
	public String toString() {
		return "pollSubDTO [pollsubid=" + pollsubid + ", pollid=" + pollid + ", answer=" + answer + ", acount=" + acount
				+ "]";
	}

	public int getPollsubid() {
		return pollsubid;
	}

	public void setPollsubid(int pollsubid) {
		this.pollsubid = pollsubid;
	}

	public int getPollid() {
		return pollid;
	}

	public void setPollid(int pollid) {
		this.pollid = pollid;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getAcount() {
		return acount;
	}

	public void setAcount(int acount) {
		this.acount = acount;
	}
	
}
