package odu_bbs;

public class bbsRepleDTO {

	private int seq;
	private int bbsnum;
	private String id;
	private int rep;
	private int step;
	private String content;
	private String wdate;
	private int del;
	
	
	public bbsRepleDTO() {
	}
	
	public bbsRepleDTO(int seq, int bbsnum, String id, int rep, int step, String content, String wdate, int del) {
		super();
		this.seq = seq;
		this.bbsnum = bbsnum;
		this.id = id;
		this.rep = rep;
		this.step = step;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getBbsnum() {
		return bbsnum;
	}

	public void setBbsnum(int bbsnum) {
		this.bbsnum = bbsnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getRep() {
		return rep;
	}

	public void setRep(int rep) {
		this.rep = rep;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "test_bbsRepleDTO [seq=" + seq + ", bbsnum=" + bbsnum + ", id=" + id + ", rep=" + rep + ", step=" + step
				+ ", content=" + content + ", wdate=" + wdate + ", del=" + del + "]";
	}
	
	
}
