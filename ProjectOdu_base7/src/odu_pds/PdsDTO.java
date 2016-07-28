package odu_pds;

/*
DROP TABLE PDS;

CREATE TABLE PDS(
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	FILENAME VARCHAR2(50) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL,
	DOWNCOUNT NUMBER(8) NOT NULL,
	REGIDATE DATE NOT NULL
);

CREATE SEQUENCE SEQ_PDS
START WITH 1 INCREMENT BY 1;

ALTER TABLE PDS ADD CONSTRAINT FK_SIST_ID FOREIGN KEY(ID)
REFERENCES MEMBERDTO(ID);

SELECT * FROM PDS;
*/


import java.io.Serializable;

public class PdsDTO implements Serializable {
	private int seq;
	private String id;
	private String title;
	private String content;
	private String filename;
	private int readcount;
	private int downcount;
	private String regidate;
	
	public PdsDTO() {}
	
	public PdsDTO(int seq, String id, String title, String content, String filename, 
				  int readcount, int downcount, String regidate) {
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.readcount = readcount;
		this.downcount = downcount;
		this.regidate = regidate;
	}
	
	public PdsDTO(String id, String title, String content, String filename) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
	}
	
	@Override
	public String toString() {
	
		return "PDS[seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", filename="
				+ filename + ", readcount=" + readcount + ", downcount=" + downcount + ", regidate=" + regidate +"]";
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getDowncount() {
		return downcount;
	}

	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

}
