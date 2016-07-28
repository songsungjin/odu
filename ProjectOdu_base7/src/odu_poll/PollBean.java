package odu_poll;

import java.io.Serializable;


// 보기
public class PollBean implements Serializable {
	private String id;
	private int syear;
	private int smonth;
	private int sday;
	
	private int eyear;
	private int emonth;
	private int eday;
	
	
	private String question;
	private int itemcount;
	
	private String poll1;
	private String poll2;
	private String poll3;
	private String poll4;
	private String poll5;
	private String poll6;
	private String poll7;
	private String poll8;
	private String poll9;
	private String poll10;
	
	private String[] pollnum=new String[10];
	
	public String[] getPollnum() {
		
		pollnum[0]=PollDAO.str(poll1); //poll1을 스트링으로 받아서 
		pollnum[1]=PollDAO.str(poll2);
		pollnum[2]=PollDAO.str(poll3);
		pollnum[3]=PollDAO.str(poll4);
		pollnum[4]=PollDAO.str(poll5);
		pollnum[5]=PollDAO.str(poll6);
		pollnum[6]=PollDAO.str(poll7);
		pollnum[7]=PollDAO.str(poll8);
		pollnum[8]=PollDAO.str(poll9);
		pollnum[9]=PollDAO.str(poll10);
		return pollnum;
	}

	public PollBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "PollBean [id=" + id + ", syear=" + syear + ", smonth=" + smonth
				+ ", sday=" + sday + ", eyear=" + eyear + ", emonth=" + emonth
				+ ", eday=" + eday + ", question=" + question + ", itemcount="
				+ itemcount + ", poll1=" + poll1 + ", poll2=" + poll2
				+ ", poll3=" + poll3 + ", poll4=" + poll4 + ", poll5=" + poll5
				+ ", poll6=" + poll6 + ", poll7=" + poll7 + ", poll8=" + poll8
				+ ", poll9=" + poll9 + ", poll10=" + poll10 + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSyear() {
		return syear;
	}
	public void setSyear(int syear) {
		this.syear = syear;
	}
	public int getSmonth() {
		return smonth;
	}
	public void setSmonth(int smonth) {
		this.smonth = smonth;
	}
	public int getSday() {
		return sday;
	}
	public void setSday(int sday) {
		this.sday = sday;
	}
	public int getEyear() {
		return eyear;
	}
	public void setEyear(int eyear) {
		this.eyear = eyear;
	}
	public int getEmonth() {
		return emonth;
	}
	public void setEmonth(int emonth) {
		this.emonth = emonth;
	}
	public int getEday() {
		return eday;
	}
	public void setEday(int eday) {
		this.eday = eday;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public int getItemcount() {
		return itemcount;
	}
	public void setItemcount(int itemcount) {
		this.itemcount = itemcount;
	}
	public String getPoll1() {
		return poll1;
	}
	public void setPoll1(String poll1) {
		this.poll1 = poll1;
	}
	public String getPoll2() {
		return poll2;
	}
	public void setPoll2(String poll2) {
		this.poll2 = poll2;
	}
	public String getPoll3() {
		return poll3;
	}
	public void setPoll3(String poll3) {
		this.poll3 = poll3;
	}
	public String getPoll4() {
		return poll4;
	}
	public void setPoll4(String poll4) {
		this.poll4 = poll4;
	}
	public String getPoll5() {
		return poll5;
	}
	public void setPoll5(String poll5) {
		this.poll5 = poll5;
	}
	public String getPoll6() {
		return poll6;
	}
	public void setPoll6(String poll6) {
		this.poll6 = poll6;
	}
	public String getPoll7() {
		return poll7;
	}
	public void setPoll7(String poll7) {
		this.poll7 = poll7;
	}
	public String getPoll8() {
		return poll8;
	}
	public void setPoll8(String poll8) {
		this.poll8 = poll8;
	}
	public String getPoll9() {
		return poll9;
	}
	public void setPoll9(String poll9) {
		this.poll9 = poll9;
	}
	public String getPoll10() {
		return poll10;
	}
	public void setPoll10(String poll10) {
		this.poll10 = poll10;
	}
}
