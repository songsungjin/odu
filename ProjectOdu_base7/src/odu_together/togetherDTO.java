package odu_together;

import java.io.Serializable;
/*
CREATE TABLE TOGETHER(
   SEQ NUMBER(8) PRIMARY KEY,
   BBS_NUM NUMBER(1) NOT NULL,            -- 게시판 고유번호: 3로 지정
   ID VARCHAR2(50) NOT NULL,
--   REF NUMBER(8) NOT NULL,
--   STEP NUMBER(8) NOT NULL,
--   DEPTH NUMBER(8) NOT NULL,
   CATE VARCHAR2(200) NOT NULL,         -- 카테고리
   TITLE VARCHAR2(200) NOT NULL,
   CONTENT VARCHAR2(4000) NOT NULL,
   F_NAME VARCHAR2(200),               -- FILE이름
--   L_NAME VARCHAR2(2000),                -- 위치이름
--   F_LIKE NUMBER(8) NOT NULL,            -- FREEBBS LIKE, 기본값: 0
    M_DATE VARCHAR2(200) NOT NULL,
   WDATE DATE NOT NULL,
   DEAD NUMBER(8) NOT NULL,            -- 마감 전: 0, 마감: 1, 기본값: 0
   T_NUM NUMBER(8) NOT NULL,                -- 함께하는 사람 ID, 0으로 줌   
   PARENT NUMBER(8) NOT NULL,
   READCOUNT NUMBER(8) NOT NULL,
   DEL NUMBER(1) NOT NULL
);
CREATE SEQUENCE SEQ_TOGETHER
START WITH 1 INCREMENT BY 1;

ALTER TABLE TOGETHER
ADD CONSTRAINT FK_TOGETHER_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);
*/

public class togetherDTO implements Serializable {
   
   private int seq;
   private int bbs_num;
   private String id;
   private String cate;
   private String title;
   private String content;
   private String f_name;
   private String wdate;
   private String M_date;
   private int dead;
   private int t_num;
   private int parent;
   private int readcount;
   private int del;
   
   public togetherDTO() {}

   public togetherDTO(int seq, int bbs_num, String id, String cate, String title, String content, String f_name,
         String wdate, String M_date, int dead, int t_num, int parent, int readcount, int del) {
      this.seq = seq;
      this.bbs_num = bbs_num;
      this.id = id;
      this.cate = cate;
      this.title = title;
      this.content = content;
      this.f_name = f_name;
      this.wdate = wdate;
      this.M_date = M_date;
      this.dead = dead;
      this.t_num = t_num;
      this.parent = parent;
      this.readcount = readcount;
      this.del = del;
   }

   @Override
   public String toString() {
      return "togetherDTO [seq=" + seq + ", bbs_num=" + bbs_num + ", id=" + id + ", cate=" + cate + ", title=" + title
            + ", content=" + content + ", f_name=" + f_name + ", M_date=" + M_date + ", dead=" + dead + ", t_num="
            + t_num + ", parent=" + parent + ", readcount=" + readcount + ", del=" + del + "]";
   }
   
   public togetherDTO(String id, String cate, String title, String content, String f_name, String wdate, String M_date, int t_num) {
      this.id = id;
      this.cate = cate;
      this.title = title;
      this.content = content;
      this.f_name = f_name;
      this.wdate = wdate;
      this.M_date = M_date;
      this.t_num = t_num;
   }
   public togetherDTO(String id, String cate, String title, String content, String f_name, String M_date, int t_num) {
      this.id = id;
      this.cate = cate;
      this.title = title;
      this.content = content;
      this.f_name = f_name;
      this.M_date = M_date;
      this.t_num = t_num;
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

   public String getCate() {
      return cate;
   }

   public void setCate(String cate) {
      this.cate = cate;
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
   
   public String getWdate() {
      return wdate;
   }

   public void setWdate(String wdate) {
      this.wdate = wdate;
   }

   public String getM_date() {
      return M_date;
   }

   public void setM_date(String M_date) {
      this.M_date = M_date;
   }

   public int getDead() {
      return dead;
   }

   public void setDead(int dead) {
      this.dead = dead;
   }

   public int getT_num() {
      return t_num;
   }

   public void setT_num(int t_num) {
      this.t_num = t_num;
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
   
}