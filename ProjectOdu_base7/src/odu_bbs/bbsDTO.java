package odu_bbs;

import java.io.Serializable;

public class bbsDTO {


/*
drop table bbs
cascade constraint;  

drop sequence seq_bbs;
  
create table bbs(
	seq number(8) primary key,
	id varchar2(50) not null,
	ref number(8) not null,
	step number(8) not null,
	depth number(8) not null,
	title varchar2(200) not null,
	content varchar2(4000) not null,
	wdate date not null,
	parent number(8) not null,
	del number(1) not null,
	readcount number(8) not null	
);

create sequence seq_bbs
start with 1 increment by 1;

alter table bbs
add constraint fk_bbs_id foreign key(id)
references member(id);

select * from bbs; 
 
*/

	private int seq;
	private int bbs_num;
	private String id;
	
	private int ref;	// 부모글
	private int step;	// 답글의 순서
	private int depth; 	// 답글의 깊이
	
	private String title;
	private String content;
	
	private String f_name;
	private String l_name;
	private int f_like;
	
	private String wdate;
	private int parent;
	
	private int readcount;
	private int del;
	
	
	public bbsDTO() {}
	
	public bbsDTO(int seq, int bbs_num, String id, int ref, int step, int depth, String title, String content,
			String f_name, String l_name, int f_like, String wdate, int parent, int readcount, int del) {
		super();
		this.seq = seq;
		this.bbs_num = bbs_num;
		this.id = id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.f_name = f_name;
		this.l_name = l_name;
		this.f_like = f_like;
		this.wdate = wdate;
		this.parent = parent;
		this.readcount = readcount;
		this.del = del;
	}
	
	public bbsDTO(String id,String title, String content){
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getBbs_num() {
		return bbs_num;
	}
	public void setBbs_num(int bbs_num) {
		this.bbs_num = bbs_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
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
	public String getF_name() {
		return f_name;
	}
	public void setF_name(String f_name) {
		this.f_name = f_name;
	}
	public String getL_name() {
		return l_name;
	}
	public void setL_name(String l_name) {
		this.l_name = l_name;
	}
	public int getF_like() {
		return f_like;
	}
	public void setF_like(int f_like) {
		this.f_like = f_like;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "test_bbsDTO [seq=" + seq + ", bbs_num=" + bbs_num + ", id=" + id + ", ref=" + ref + ", step=" + step
				+ ", depth=" + depth + ", title=" + title + ", content=" + content + ", f_name=" + f_name + ", l_name="
				+ l_name + ", f_like=" + f_like + ", wdate=" + wdate + ", parent=" + parent + ", readcount=" + readcount
				+ ", del=" + del + "]";
	}
	
	
}


